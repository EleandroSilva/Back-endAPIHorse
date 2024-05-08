{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 22/04/2024 12:08           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Imp.Condicao.Pagamento;

interface

uses
  Model.Entidade.Condicao.Pagamento.Interfaces;

Type
  TEntidadeCondicaoPagamento<T : iInterface> = class(TInterfacedObject, iEntidadeCondicaoPagamento<T>)
    private
      [weak]
      FParent                : T;
      FId                    : Integer;
      FIdEmpresa             : Integer;
      FIdUsuario             : Integer;
      FNomeCondicaoPagamento : String;
      FQuantidadePagamento   : Integer;
      FTotalDias             : Integer;
      FPrazoMedio            : Integer;
      FDataHoraEmissao       : TDateTime;
    public
      constructor Create(Parent : T);
      destructor Destroy; override;
      class function New(Parent : T) : iEntidadeCondicaoPagamento<T>;

      function Id                   (Value : Integer)   : iEntidadeCondicaoPagamento<T>; overload;
      function Id                                       : Integer;                       overload;
      function IdEmpresa            (Value : Integer)   : iEntidadeCondicaoPagamento<T>; overload;
      function IdEmpresa                                : Integer;                       overload;
      function IdUsuario            (Value : Integer)   : iEntidadeCondicaoPagamento<T>; overload;
      function IdUsuario                                : Integer;                       overload;
      function NomeCondicaoPagamento(Value : String)    : iEntidadeCondicaoPagamento<T>; overload;
      function NomeCondicaoPagamento                    : String;                        overload;
      function QuantidadePagamento  (Value : Integer)   : iEntidadeCondicaoPagamento<T>; overload;
      function QuantidadePagamento                      : Integer;                       overload;
      function TotalDias            (Value : Integer)   : iEntidadeCondicaoPagamento<T>; overload;
      function TotalDias                                : Integer;                       overload;
      function PrazoMedio           (Value : Integer)   : iEntidadeCondicaoPagamento<T>; overload;
      function PrazoMedio                               : Integer;                       overload;
      function DataHoraEmissao      (Value : TDateTime) : iEntidadeCondicaoPagamento<T>; overload;
      function DataHoraEmissao                          : TDateTime;                     overload;

      function &End : T;
  end;

implementation

uses
  Model.Entidade.Imp.Condicao.Pagamento.Item;

{ TEntidadeCondicaoPagamento<T> }

constructor TEntidadeCondicaoPagamento<T>.Create(Parent: T);
begin
  FParent := Parent;
end;

destructor TEntidadeCondicaoPagamento<T>.Destroy;
begin
  inherited;
end;

class function TEntidadeCondicaoPagamento<T>.New(Parent: T): iEntidadeCondicaoPagamento<T>;
begin
  Result := Self.Create(Parent);
end;

function TEntidadeCondicaoPagamento<T>.Id(Value: Integer): iEntidadeCondicaoPagamento<T>;
begin
  Result := Self;
  FId    := Value;
end;

function TEntidadeCondicaoPagamento<T>.Id: Integer;
begin
  Result := FId;
end;

function TEntidadeCondicaoPagamento<T>.IdEmpresa(Value: Integer): iEntidadeCondicaoPagamento<T>;
begin
  Result := Self;
  FIdEmpresa := Value;
end;

function TEntidadeCondicaoPagamento<T>.IdEmpresa: Integer;
begin
  Result := FIdEmpresa;
end;

function TEntidadeCondicaoPagamento<T>.IdUsuario(Value: Integer): iEntidadeCondicaoPagamento<T>;
begin
  Result := Self;
  FIdUsuario := Value;
end;

function TEntidadeCondicaoPagamento<T>.IdUsuario: Integer;
begin
  Result := FIdUsuario;
end;

function TEntidadeCondicaoPagamento<T>.NomeCondicaoPagamento(Value: String): iEntidadeCondicaoPagamento<T>;
begin
  Result := Self;
  FNomeCondicaoPagamento := Value;
end;

function TEntidadeCondicaoPagamento<T>.NomeCondicaoPagamento: String;
begin
  Result := FNomeCondicaoPagamento;
end;

function TEntidadeCondicaoPagamento<T>.QuantidadePagamento(Value: Integer): iEntidadeCondicaoPagamento<T>;
begin
  Result := Self;
  FQuantidadePagamento := Value;
end;

function TEntidadeCondicaoPagamento<T>.QuantidadePagamento: Integer;
begin
  Result := FQuantidadePagamento;
end;

function TEntidadeCondicaoPagamento<T>.TotalDias(Value: Integer): iEntidadeCondicaoPagamento<T>;
begin
  Result := Self;
  FTotalDias := Value;
end;

function TEntidadeCondicaoPagamento<T>.TotalDias: Integer;
begin
  Result := FTotalDias;
end;

function TEntidadeCondicaoPagamento<T>.PrazoMedio(Value: Integer): iEntidadeCondicaoPagamento<T>;
begin
  Result := Self;
  FPrazoMedio := Value;
end;

function TEntidadeCondicaoPagamento<T>.PrazoMedio: Integer;
begin
  Result := FPrazoMedio;
end;

function TEntidadeCondicaoPagamento<T>.DataHoraEmissao(Value: TDateTime): iEntidadeCondicaoPagamento<T>;
begin
  Result := Self;
  FDataHoraEmissao := Value
end;

function TEntidadeCondicaoPagamento<T>.DataHoraEmissao: TDateTime;
begin
  Result := FDataHoraEmissao;
end;

function TEntidadeCondicaoPagamento<T>.&End: T;
begin
  Result := FParent;
end;

end.
