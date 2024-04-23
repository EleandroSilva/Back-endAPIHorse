{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 11/04/2024 20:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit View.Controller.Buscar.Cep;

interface

uses
  System.SysUtils,
  System.JSON,
  Data.DB,

  ViaCEP.Intf,
  ViaCEP.Core,
  ViaCEP.Model,

  DataSet.Serialize,
  Horse,
  Horse.BasicAuthentication,
  Controller.Interfaces;

type
  TViewControllerBuscarCep = class
    private
      FController : iController;
      FDataSource : TDataSource;

      function  BuscoCepBaseDadosServidorLocal(Req: THorseRequest; Res: THorseResponse; Next : TProc; Cep : String) : Boolean;
      procedure GetAll (Req: THorseRequest; Res: THorseResponse; Next : TProc);
      procedure Registry;
    public
      constructor Create;
      destructor Destroy; override;
  end;

implementation

uses
  Imp.Controller;

{ TViewControllerBuscarCep }

function TViewControllerBuscarCep.BuscoCepBaseDadosServidorLocal(Req: THorseRequest; Res: THorseResponse; Next : TProc; Cep: String): Boolean;
begin
  Result := False;
  Try
    try
      FController
         .FactoryEntidade
           .DAOEndereco
            .GetbyId(Cep)
            .DataSet(FDataSource);
    except
      Res.Status(500).Send('Ocorreu um erro interno no servidor.');
      Exit;
    end;
  Finally
  End;
end;

constructor TViewControllerBuscarCep.Create;
begin
  FController := TController.New;
  Registry;
end;

destructor TViewControllerBuscarCep.Destroy;
begin
  inherited;
end;

procedure TViewControllerBuscarCep.GetAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LJSONObject : TJSONObject;
  LViaCEP     : IViaCEP;
  LCEP        : TViaCEPClass;
begin
  LViaCEP  := TViaCEP.Create;
  LCEP     := LViaCEP.Get(StringReplace(Req.Query.Field('cep').AsString,'-','',[rfReplaceAll]));
  if LViaCEP.Validate('01001000') then
  if not Assigned(LCEP) then
  begin  // Aqui voc� pode exibir uma mensagem para o usu�rio falando que o CEP n�o foi encontrado.
    Res.Status(500).Send('Ocorreu um erro interno no servidor.');
    Exit;
  end;
    // Crie ou obtenha os dados que deseja enviar para o frontend
  LJSONObject := TJSONObject.Create;
  try
    LJSONObject.AddPair('cep'         , LCEP.CEP);
    LJSONObject.AddPair('endereco'    , LCep.Logradouro);
    LJSONObject.AddPair('complemento' , LCep.Complemento);
    LJSONObject.AddPair('bairro'      , LCep.Bairro);
    LJSONObject.AddPair('municipio'   , LCep.Localidade);
    LJSONObject.AddPair('estado'      , LCep.UF);
    LJSONObject.AddPair('ibge'        , LCep.IBGE);
    LJSONObject.AddPair('gia'         , LCep.GIA);
    LJSONObject.AddPair('ddd'         , LCep.DDD);
    // Converta os dados para JSON
    Res.Send(LJSONObject);
  finally
     FreeAndNil(LCep);
  end;
end;

procedure TViewControllerBuscarCep.Registry;
begin
  THorse
      .Group
        .Prefix('bmw')
          .Get ('/cep' , GetAll);
end;

end.
