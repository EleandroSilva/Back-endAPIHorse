{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 01/05/2024 00:45           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Alterar.Endereco;

interface

uses
  Data.DB,
  System.SysUtils,
  System.JSON,

  Model.Alterar.Endereco.Interfaces,
  Controller.Interfaces,
  Model.Entidade.Endereco.Interfaces;

Type
  TAlterarEndereco = class(TInterfacedObject, iAlterarEndereco)
    private
      FController : iController;
      FEndereco   : iEntidadeEndereco<iAlterarEndereco>;
      FDSEndereco : TDataSource;
      FJSONObject : TJSONObject;
      FJSONArray  : TJSONArray;

      FJSONObjectNumero : TJSONObject;

      FIdEndereco : Integer;
      FFound : Boolean;
      FError : Boolean;
      procedure AlterarNumero;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iAlterarEndereco;

      function JSONObject(Value : TJSONObject) : iAlterarEndereco; overload;
      function JSONObject                      : TJSONObject;      overload;
      function Put    : iAlterarEndereco;
      function Found  : Boolean;
      function Error  : Boolean;

      //injeção de dependência
      function Endereco : iEntidadeEndereco<iAlterarEndereco>;
      function &End     : iAlterarEndereco;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Endereco;

{ TAlterarEndereco }

constructor TAlterarEndereco.Create;
begin
  FController := TController.New;
  FEndereco   := TEntidadeEndereco<iAlterarEndereco>.New(Self);
  FDSEndereco := TDataSource.Create(nil);

  FFound := False;
  FError := False;
end;

destructor TAlterarEndereco.Destroy;
begin
  inherited;
end;

class function TAlterarEndereco.New: iAlterarEndereco;
begin
  Result := Self.Create;
end;

function TAlterarEndereco.JSONObject(Value: TJSONObject): iAlterarEndereco;
begin
  Result := Self;
  FJSONObject := Value;
end;

function TAlterarEndereco.JSONObject: TJSONObject;
begin
  Result := FJSONObject;
end;

function TAlterarEndereco.Error: Boolean;
begin
  Result := FError;
end;

function TAlterarEndereco.Found: Boolean;
begin
  Result := FFound;
end;

function TAlterarEndereco.Put: iAlterarEndereco;
Var
  I : Integer;
begin
  //Obtém os dados JSON do corpo da requisição da tabela('endereco')
  FJSONArray := FJSONObject.Get('endereco').JsonValue as TJSONArray;
  try
    // Loop do(s) endereço(s)
    for I := 0 to FJSONArray.Count - 1 do
    begin
      FJSONObject := FJSONArray.Items[I] as TJSONObject;
        FController
          .FactoryDAO
            .DAOEndereco
              .This
                .Id            (FJSONObject.GetValue<Integer>('id'))
                .Cep           (FJSONObject.GetValue<String> ('cep'))
                .IBGE          (FJSONObject.GetValue<Integer>('ibge'))
                .UF            (FJSONObject.GetValue<String> ('uf'))
                .TipoLogradouro(FJSONObject.GetValue<String> ('tipoLogradouro'))
                .Logradouro    (FJSONObject.GetValue<String> ('Logradouro'))
                .Bairro        (FJSONObject.GetValue<String> ('bairro'))
                .GIA           (FJSONObject.GetValue<Integer>('gia'))
                .DDD           (FJSONObject.GetValue<String> ('ddd'))
              .&End
            .Put
            .DataSet(FDSEndereco);
      //Alterar dados da tabela numero
      FIdEndereco := FDSEndereco.DataSet.FieldByName('id').AsInteger;
      AlterarNumero;
    end;
  except
    on E: Exception do
    begin
      WriteLn('Erro ao tentar alterar endereço: ' + E.Message);
      FError := True;
    end;
  end;
end;

procedure TAlterarEndereco.AlterarNumero;
begin
  FController
    .FactoryAlterar
      .AlterarNumero
        .Numero
          .IdEndereco(FIdEndereco)
        .&End
      .JSONObjectPai(FJSONObject)
      .Put;
end;

//Injeção de dependência
function TAlterarEndereco.Endereco: iEntidadeEndereco<iAlterarEndereco>;
begin
  Result := FEndereco;
end;

function TAlterarEndereco.&End: iAlterarEndereco;
begin
  Result := Self;
end;

end.
