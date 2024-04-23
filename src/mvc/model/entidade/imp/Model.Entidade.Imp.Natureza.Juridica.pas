{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 15/04/2024 15:37           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Imp.Natureza.Juridica;

interface

uses
  Model.Entidade.Natureza.Juridica.Interfaces;

type
  TEntidadeNaturezaJuridica<T : iInterface> = class(TInterfacedObject, iEntidadeNaturezaJuridica<T>)
    private
      [weak]
      FParent               : T;
      FId                   : Integer;
      FNomeNaturezaJuridica : String;
    public
      constructor Create(Parent : T);
      destructor Destroy; override;
      class function New(Parent : T): iEntidadeNaturezaJuridica<T>;

      function Id                  (Value : Integer) : iEntidadeNaturezaJuridica<T>; overload;
      function Id                                    : Integer;                      overload;
      function NomeNaturezaJuridica(Value : String)  : iEntidadeNaturezaJuridica<T>; overload;
      function NomeNaturezaJuridica                  : String;                       overload;

      function &End : T;
  end;

implementation

constructor TEntidadeNaturezaJuridica<T>.Create(Parent: T);
begin
  FParent := Parent;
end;

destructor TEntidadeNaturezaJuridica<T>.Destroy;
begin
  inherited;
end;

class function TEntidadeNaturezaJuridica<T>.New(Parent: T): iEntidadeNaturezaJuridica<T>;
begin
  Result := Self.Create(Parent);
end;

function TEntidadeNaturezaJuridica<T>.Id(Value: Integer): iEntidadeNaturezaJuridica<T>;
begin
  Result := Self;
  FId    := Value;
end;

function TEntidadeNaturezaJuridica<T>.Id: Integer;
begin
  Result := FId;
end;

function TEntidadeNaturezaJuridica<T>.NomeNaturezaJuridica(Value: String): iEntidadeNaturezaJuridica<T>;
begin
  Result := Self;
  FNomeNaturezaJuridica := Value;
end;

function TEntidadeNaturezaJuridica<T>.NomeNaturezaJuridica: String;
begin
  Result := FNomeNaturezaJuridica;
end;

function TEntidadeNaturezaJuridica<T>.&End: T;
begin
  Result := FParent;
end;

end.
