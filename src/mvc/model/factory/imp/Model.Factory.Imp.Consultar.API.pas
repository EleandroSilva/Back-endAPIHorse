
{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 14/05/2024 14:24           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Factory.Imp.Consultar.API;

interface

uses
  Model.Factory.Consultar.API.Interfaces,
  Model.ReceitaWS.Consultar.CNPJ.Interfaces;

type
  TFactoryConsultarAPI = class(TInterfacedObject, iFactoryConsultarAPI)
    private
      FConsultarCNPJReceitaWS : iConsultarCNPJ;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iFactoryConsultarAPI;

      function ConsultarCNPJReceitaWS : iConsultarCNPJ;
  end;

implementation

uses
  Model.ReceitaWS.Consultar.CNPJ;

{ TFactoryConsultarAPI }

constructor TFactoryConsultarAPI.Create;
begin
  //
end;

destructor TFactoryConsultarAPI.Destroy;
begin
  inherited;
end;

class function TFactoryConsultarAPI.New: iFactoryConsultarAPI;
begin
  Result := Self.Create;
end;

function TFactoryConsultarAPI.ConsultarCNPJReceitaWS: iConsultarCNPJ;
begin
  if not Assigned(FConsultarCNPJReceitaWS) then
    FConsultarCNPJReceitaWS := TConsultarCNPJ.New;

  Result := FConsultarCNPJReceitaWS
end;

end.
