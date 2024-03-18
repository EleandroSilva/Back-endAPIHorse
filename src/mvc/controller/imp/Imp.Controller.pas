{*******************************************************}
{                    API PDV - JSON                     }
{                      ES Sistemas                      }
{          Início do projeto 13/03/2024 10:28           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Imp.Controller;

interface

uses
  Controller.Interfaces,
  Model.Factory.Entidade.Interfaces,
  Model.Factory.Imp.Entidade;

type
  TController = class(TInterfacedObject, iController)
    private
      FFactoryEntidade : iFactoryEntidade;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iController;

      function FactoryEntidade : iFactoryEntidade;
  end;

implementation

{ TController }

constructor TController.Create;
begin
  //
end;

class function TController.New: iController;
begin
  Result := Self.Create;
end;

destructor TController.Destroy;
begin
  //
  inherited;
end;

function TController.FactoryEntidade: iFactoryEntidade;
begin
  if not Assigned(FFactoryEntidade) then
    FFactoryEntidade := TFactoryEntidade.New;
  Result := FFactoryEntidade;
end;

end.
