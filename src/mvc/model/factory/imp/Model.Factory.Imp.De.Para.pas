{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 10/05/2024 13:09           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Factory.Imp.De.Para;

interface

uses
  Model.Factory.De.Para.Interfaces,
  Model.De.Para.ReceitaWS.Empresa.Interfaces;

type
  TFactoryDePara = class(TInterfacedObject, iFactoryDePara)
    private
      FDeParaReceitaWSEmpresa : iDeParaReceitaWSEmpresa;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iFactoryDePara;

      function DeParaReceitaWSEmpresa : iDeParaReceitaWSEmpresa;
  end;

implementation

uses
  Model.De.Para.ReceitaWS.Empresa;

{ TFactoryDePara }

constructor TFactoryDePara.Create;
begin
  //
end;

destructor TFactoryDePara.Destroy;
begin
  inherited;
end;

class function TFactoryDePara.New: iFactoryDePara;
begin
  Result := Self.Create;
end;

function TFactoryDePara.DeParaReceitaWSEmpresa: iDeParaReceitaWSEmpresa;
begin
  if not Assigned(FDeParaReceitaWSEmpresa) then
    FDeParaReceitaWSEmpresa := TDeParaReceitaWSEmpresa.New;

  Result := FDeParaReceitaWSEmpresa;
end;

end.
