{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 10/05/2024 13:09           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.De.Para.ReceitaWS.Empresa;

interface

uses
  System.JSON,

  Model.De.Para.ReceitaWS.Empresa.Interfaces,
  Controller.Interfaces;

type
  TDeParaReceitaWSEmpresa = class(TInterfacedObject, iDeParaReceitaWSEmpresa)
    private
      FController : iController;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDeParaReceitaWSEmpresa;

      function ConsultarDadosPorCNPJ(CNPJ : String) : TJSONObject;
  end;

implementation

uses
  Model.Entidade.Imp.Empresa,
  Imp.Controller;

{ TDeParaReceitaWSEmpresa }

constructor TDeParaReceitaWSEmpresa.Create;
begin
  FController := TController.New;
end;

destructor TDeParaReceitaWSEmpresa.Destroy;
begin
  inherited;
end;

class function TDeParaReceitaWSEmpresa.New: iDeParaReceitaWSEmpresa;
begin
  Result := Self.Create;
end;

function TDeParaReceitaWSEmpresa.ConsultarDadosPorCNPJ(CNPJ : String): TJSONObject;
begin
  Result := FController
              .FactoryConsultarAPI
                .ConsultarCNPJReceitaWS
                  .ConsultarCNPJ(CNPJ);
end;

end.
