{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 08/04/2024 18:12           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Imp.Municipio;

interface

uses
  Model.Entidade.Municipio.Interfaces,
  Model.Entidade.Estado.Interfaces;

type
  TEntidadeMunicipio<T : iInterface> = class(TInterfacedObject, iEntidadeMunicipio<T>)
    private
      [weak]
      FParent    : T;
      FId        : Integer;
      FIdEstado  : Integer;
      FIBGE      : Integer;
      FMunicipio : String;
      FUF        : String;

      //Injeção de dependência
      FEstado : iEntidadeEstado<iEntidadeMunicipio<T>>;
    public
      constructor Create(Parent : T);
      destructor Destroy; override;
      class function New(Parent : T) : iEntidadeMunicipio<T>;

      function Id       (Value : Integer) : iEntidadeMunicipio<T>; overload;
      function Id                         : Integer;               overload;
      function IdEstado (Value : Integer) : iEntidadeMunicipio<T>; overload;
      function IdEstado                   : Integer;               overload;
      function IBGE     (Value : Integer) : iEntidadeMunicipio<T>; overload;
      function IBGE                       : Integer;               overload;
      function Municipio(Value : String)  : iEntidadeMunicipio<T>; overload;
      function Municipio                  : String;                overload;
      function UF       (Value : String)  : iEntidadeMunicipio<T>; overload;
      function UF                         : String;                overload;

      //Injeção de dependência
      function Estado : iEntidadeEstado<iEntidadeMunicipio<T>>;

      function &End : T;
  end;

implementation

uses
  Model.Entidade.Imp.Estado;

{ TEntidadeMunicipio<T> }

constructor TEntidadeMunicipio<T>.Create(Parent: T);
begin
  FParent := Parent;
  FEstado := TEntidadeEstado<iEntidadeMunicipio<T>>.New(Self);
end;

destructor TEntidadeMunicipio<T>.Destroy;
begin
  inherited;
end;

class function TEntidadeMunicipio<T>.New(Parent: T): iEntidadeMunicipio<T>;
begin
  Result := Self.Create(Parent);
end;

function TEntidadeMunicipio<T>.Id(Value: Integer): iEntidadeMunicipio<T>;
begin
  Result := Self;
  FId    := Value;
end;

function TEntidadeMunicipio<T>.Id: Integer;
begin
  Result := FId;
end;

function TEntidadeMunicipio<T>.IdEstado(Value: Integer): iEntidadeMunicipio<T>;
begin
  Result    := Self;
  FIdEstado := Value;
end;

function TEntidadeMunicipio<T>.IdEstado: Integer;
begin
  Result := FIdEstado;
end;

function TEntidadeMunicipio<T>.IBGE(Value: Integer): iEntidadeMunicipio<T>;
begin
  Result := Self;
  FIBGE  := Value;
end;

function TEntidadeMunicipio<T>.IBGE: Integer;
begin
  Result := FIBGE;
end;

function TEntidadeMunicipio<T>.Municipio(Value: String): iEntidadeMunicipio<T>;
begin
  Result := Self;
  FMunicipio := Value;
end;

function TEntidadeMunicipio<T>.Municipio: String;
begin
  Result := FMunicipio;
end;

function TEntidadeMunicipio<T>.UF(Value: String): iEntidadeMunicipio<T>;
begin
  Result := Self;
  FUF    := Value;
end;

function TEntidadeMunicipio<T>.UF: String;
begin
  Result := FUF;
end;

//injeção de dependência
function TEntidadeMunicipio<T>.Estado: iEntidadeEstado<iEntidadeMunicipio<T>>;
begin
  Result := FEstado;
end;

function TEntidadeMunicipio<T>.&End: T;
begin
  Result := FParent;
end;

end.
