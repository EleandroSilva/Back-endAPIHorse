{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 14/05/2024 14:24           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Factory.Imp.Uteis;

interface

uses
  Model.Factory.Uteis.Interfaces,
  Uteis.Interfaces;

type
  TFactoryUteis = class(TInterfacedObject, iFactoryUteis)
    private
      FUteis : iUteis;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iFactoryUteis;

      function Uteis : iUteis;
  end;

implementation

uses
  Uteis;

{ TFactoryUteis }

constructor TFactoryUteis.Create;
begin
  //
end;

destructor TFactoryUteis.Destroy;
begin
  inherited;
end;

class function TFactoryUteis.New: iFactoryUteis;
begin
  Result := Self.Create;
end;

function TFactoryUteis.Uteis: iUteis;
begin
  if not Assigned(FUteis) then
    FUteis := TUteis.New;

  Result := FUteis;
end;

end.
