{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 22/04/2024 12:08           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Imp.Caixa;

interface

uses
  Model.Entidade.Caixa.Interfaces,
  Model.Entidade.Usuario.Interfaces;

type
  TEntidadeCaixa<T : iInterface> = class(TInterfacedObject, iEntidadeCaixa<T>)
   private
     [weak]
     FParent   : T;
     FId              : Integer;
     FIdEmpresa       : Integer;
     FIdUsuario       : Integer;
     FValorInicial    : Currency;
     FDataHoraEmissao : TDateTime;
     FStatus          : String;

     //Injeção de dependência
     FUsuario  : iEntidadeUsuario<iEntidadeCaixa<T>>;//Caixa diário
   public
     constructor Create(Parent : T);
     destructor Destroy; override;
     class Function New(Parent : T): iEntidadeCaixa<T>;

     function Id             (Value : Integer)   : iEntidadeCaixa<T>; overload;
     function Id                                 : Integer;           overload;
     function IdEmpresa      (Value : Integer)   : iEntidadeCaixa<T>; overload;
     function IdEmpresa                          : Integer;           overload;
     function IdUsuario      (Value : Integer)   : iEntidadeCaixa<T>; overload;
     function IdUsuario                          : Integer;           overload;
     function ValorInicial   (Value : Currency)  : iEntidadeCaixa<T>; overload;
     function ValorInicial                       : Currency;          overload;
     function DataHoraEmissao(Value : TDateTime) : iEntidadeCaixa<T>; overload;
     function DataHoraEmissao                    : TDateTime;         overload;
     function Status         (Value : String)    : iEntidadeCaixa<T>; overload;
     function Status                             : String;            overload;

     //Injeção de dependência
     function Usuario  : iEntidadeUsuario<iEntidadeCaixa<T>>;
     function &End : T;
  end;

implementation

uses
  Model.Entidade.Imp.Usuario;

{ TCaixaDiario<T> }

constructor TEntidadeCaixa<T>.Create(Parent: T);
begin
  FParent  := Parent;
  FUsuario := TEntidadeUsuario<iEntidadeCaixa<T>>.New(Self);
end;

class function TEntidadeCaixa<T>.New(Parent: T): iEntidadeCaixa<T>;
begin
  Result := Self.Create(Parent);
end;

function TEntidadeCaixa<T>.DataHoraEmissao: TDateTime;
begin
  Result := FDataHoraEmissao;
end;

function TEntidadeCaixa<T>.DataHoraEmissao(Value: TDateTime): iEntidadeCaixa<T>;
begin
  Result := Self;
  FDataHoraEmissao := Value;
end;

destructor TEntidadeCaixa<T>.Destroy;
begin
  inherited;
end;

function TEntidadeCaixa<T>.Id: Integer;
begin
  Result := FId;
end;

function TEntidadeCaixa<T>.Id(Value: Integer): iEntidadeCaixa<T>;
begin
  Result := Self;
  FId    := Value;
end;

function TEntidadeCaixa<T>.IdEmpresa(Value: Integer): iEntidadeCaixa<T>;
begin
  Result := Self;
  FIdEmpresa := Value;
end;

function TEntidadeCaixa<T>.IdEmpresa: Integer;
begin
  Result := FIdEmpresa;
end;

function TEntidadeCaixa<T>.IdUsuario: Integer;
begin
  Result := FIdUsuario;
end;

function TEntidadeCaixa<T>.IdUsuario(Value: Integer): iEntidadeCaixa<T>;
begin
  Result := Self;
  FIdUsuario := Value;
end;

function TEntidadeCaixa<T>.Status(Value: String): iEntidadeCaixa<T>;
begin
  Result := self;
  FStatus := Value;
end;

function TEntidadeCaixa<T>.Status: String;
begin
  Result := FStatus;
end;

function TEntidadeCaixa<T>.ValorInicial(Value: Currency): iEntidadeCaixa<T>;
begin
  Result := Self;
  FValorInicial := Value;
end;

function TEntidadeCaixa<T>.ValorInicial: Currency;
begin
  Result := FValorInicial;
end;

//Injeção de depêndencia
function TEntidadeCaixa<T>.Usuario: iEntidadeUsuario<iEntidadeCaixa<T>>;
begin
  Result := FUsuario;
end;

function TEntidadeCaixa<T>.&End: T;
begin
  Result := FParent;
end;

end.
