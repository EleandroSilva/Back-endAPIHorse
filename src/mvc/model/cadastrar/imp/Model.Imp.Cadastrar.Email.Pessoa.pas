{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 02/05/2024 11:26           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Cadastrar.Email.Pessoa;

interface

uses
  Data.DB,
  System.JSON,
  System.SysUtils,

  DataSet.Serialize,
  Controller.Interfaces,
  Model.Cadastrar.Email.Pessoa.Interfaces,
  Model.Entidade.Email.Pessoa.Interfaces;

type
  TCadastrarEmailPessoa = class(TInterfacedObject, iCadastrarEmailPessoa)
    private
      FController  : iController;
      FEmailPessoa : iEntidadeEmailPessoa<iCadastrarEmailPessoa>;

      FJSONArray     : TJSONArray;
      FJSONObject    : TJSONObject;
      FJSONObjectPai : TJSONObject;
      FDSEmailPessoa : TDataSource;

      FError     : Boolean;
      FQuantidadeRegistro : Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iCadastrarEmailPessoa;

      function JSONObjectPai(Value : TJSONObject) : iCadastrarEmailPessoa; overload;
      function JSONObjectPai                      : TJSONObject;           overload;
      function Post  : iCadastrarEmailPessoa;

      function Error : Boolean;
      //injeção de dependência
      function EmailPessoa : iEntidadeEmailPessoa<iCadastrarEmailPessoa>;
      function &End : iCadastrarEmailPessoa;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Email.Pessoa;

{ TCadastrarEmailPessoa }

constructor TCadastrarEmailPessoa.Create;
begin
  FController    := TController.New;
  FEmailPessoa   := TEntidadeEmailPessoa<iCadastrarEmailPessoa>.New(Self);
  FDSEmailPessoa := TDataSource.Create(nil);

  FError := False;
  FQuantidadeRegistro := 0;
end;

destructor TCadastrarEmailPessoa.Destroy;
begin
  inherited;
end;

class function TCadastrarEmailPessoa.New: iCadastrarEmailPessoa;
begin
  Result := Self.Create;
end;

function TCadastrarEmailPessoa.Error: Boolean;
begin
  Result := FError;
end;

function TCadastrarEmailPessoa.JSONObjectPai(Value: TJSONObject): iCadastrarEmailPessoa;
begin
  Result := Self;
  FJSONObjectPai := Value;
end;

function TCadastrarEmailPessoa.JSONObjectPai: TJSONObject;
begin
  Result := FJSONObjectPai;
end;

function TCadastrarEmailPessoa.Post: iCadastrarEmailPessoa;
Var
  I : Integer;
begin
  Result := Self;
  FJSONArray := FJSONObjectPai.GetValue('emailpessoa') as TJSONArray;
  try
    //Loop emails
    for I := 0 to FJSONArray.Count - 1 do
    begin
      //Extraindo os dados do(s) emai(s)  e salvando no banco de dados
      FJSONObject :=  FJSONArray.Items[I] as TJSONObject;
      //verifico se consta o email que esta vindo no json. Na tabela emailempresa, se não existir insiro.
      if not FController
               .FactoryPesquisar
                 .PesquisarEmailPessoa
                 .GetBy(FEmailPessoa.IdEmpresa , FJSONObject.GetValue<String>('email')).Found Then
        FController
          .FactoryDAO
            .DAOEmailEmpresa
              .This
                .IdEmpresa(FEmailPessoa.IdEmpresa)
                .Email    (FJSONObject.GetValue<String>('email'))
                .TipoEmail(FJSONObject.GetValue<String>('tipoemail'))
                .Ativo    (1)
              .&End
            .Post;
    end;
  except
    on E: Exception do
    begin
      WriteLn('Erro ao tentar incluir o registro: ' + E.Message);
      FError := True;
    end;
  end;
end;

//Injeção de dependência
function TCadastrarEmailPessoa.EmailPessoa: iEntidadeEmailPessoa<iCadastrarEmailPessoa>;
begin
  Result := FEmailPessoa;
end;

function TCadastrarEmailPessoa.&End: iCadastrarEmailPessoa;
begin
  Result := Self;
end;

end.
