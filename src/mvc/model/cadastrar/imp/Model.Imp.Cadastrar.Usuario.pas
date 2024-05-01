{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 30/04/2024 14:18           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Cadastrar.Usuario;

interface

uses
  Data.DB,
  System.JSON,
  System.SysUtils,

  Model.Cadastrar.Usuario.Interfaces,
  Controller.Interfaces,
  Model.Entidade.Usuario.Interfaces;

type
  TCadastrarUsuario = class(TInterfacedObject, iCadastrarUsuario)
    private
      FController        : iController;
      FUsuario           : iEntidadeUsuario<iCadastrarUsuario>;
      FJSONArrayUsuario  : TJSONArray;
      FJSONObjectUsuario : TJSONObject;
      FJSONObjectPai     : TJSONObject;
      FDSUsuario         : TDataSource;

      FError : Boolean;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iCadastrarUsuario;

      function JSONObjectPai(Value : TJSONObject) : iCadastrarUsuario; overload;
      function JSONObjectPai                      : TJSONObject;       overload;
      function Post  : iCadastrarUsuario;
      function Error : Boolean;

      //injeção de dependência
      function Usuario : iEntidadeUsuario<iCadastrarUsuario>;
      function &End : iCadastrarUsuario;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Usuario;

{ TCadastrarUsuario<T> }

constructor TCadastrarUsuario.Create;
begin
  FController := TController.New;
  FUsuario    := TEntidadeUsuario<iCadastrarUsuario>.New(Self);
end;

destructor TCadastrarUsuario.Destroy;
begin
  inherited;
end;

class function TCadastrarUsuario.New: iCadastrarUsuario;
begin
  Result:= Self.Create;
end;

function TCadastrarUsuario.JSONObjectPai(Value: TJSONObject): iCadastrarUsuario;
begin
  Result := Self;
  FJSONObjectPai := Value;
end;

function TCadastrarUsuario.JSONObjectPai: TJSONObject;
begin
  Result := FJSONObjectPai;
end;

function TCadastrarUsuario.Post: iCadastrarUsuario;
Var
  I : Integer;
begin
  Result := Self;
  FJSONArrayUsuario := FJSONObjectPai.GetValue('usuario') as TJSONArray;
  //Obtém os dados JSON do corpo da requisição da tabela('usuario')
  try
    //Loop emails
    for I := 0 to FJSONArrayUsuario.Count - 1 do
    begin
      //Extraindo os dados do(s) emai(s)  e salvando no banco de dados
      FJSONObjectUsuario :=  FJSONArrayUsuario.Items[I] as TJSONObject;
      if not FController
               .FactoryPesquisar
                 .PesquisarUsuario
                 .Getby(FJSONObjectUsuario.GetValue<String>('email'),
                        FJSONObjectUsuario.GetValue<String>('senha')).Found then
        FController
          .FactoryDAO
            .DAOUsuario
                .This
                  .IdEmpresa  (FUsuario.IdEmpresa)
                  .NomeUsuario(FJSONObjectUsuario.GetValue<String>('nomeusuario'))
                  .Email      (FJSONObjectUsuario.GetValue<String>('email'))
                  .Senha      (FJSONObjectUsuario.GetValue<String>('senha'))
                  .DataHoraEmissao(Now)
                  .Ativo    (1)
                .&End
            .Post;
    end;
  except
    on E: Exception do
      FError := True;
  end;
end;

function TCadastrarUsuario.Error: Boolean;
begin
  Result := FError;
end;

//Injeção de dependência
function TCadastrarUsuario.Usuario: iEntidadeUsuario<iCadastrarUsuario>;
begin
  Result := FUsuario;
end;

function TCadastrarUsuario.&End: iCadastrarUsuario;
begin
  Result := Self;
end;

end.
