{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 18/03/2024 13:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Imp.Unidade.Produto;

interface

uses
  Model.Entidade.Unidade.Produto.Interfaces;

type
  TEntidadeUnidadeProduto<T : iInterface> = class(TInterfacedObject, iEntidadeUnidadeProduto<T>)
    private
      [Weak]
      FParent      : T;
      FId          : Integer;
      FUnidade     : String;
      FNomeUnidade : String;
      FAtivo       : Integer;
    public
      constructor Create(Parent : T);
      destructor Destroy; override;
      class function New(Parent : T) : iEntidadeUnidadeProduto<T>;

      function Id         (Value : Integer) : iEntidadeUnidadeProduto<T>; overload;
      function Id                           : Integer;                    overload;
      function Unidade    (Value : String)  : iEntidadeUnidadeProduto<T>; overload;
      function Unidade                      : String;                     overload;
      function NomeUnidade(Value : String)  : iEntidadeUnidadeProduto<T>; overload;
      function NomeUnidade                  : String;                     overload;
      function Ativo      (Value : Integer) : iEntidadeUnidadeProduto<T>; overload;
      function Ativo                        : Integer;                    overload;

      function &End : T;
  end;

implementation

{ TEntidadeUnidadeProduto<T> }

constructor TEntidadeUnidadeProduto<T>.Create(Parent: T);
begin
  FParent := Parent;
end;

destructor TEntidadeUnidadeProduto<T>.Destroy;
begin
  inherited;
end;

class function TEntidadeUnidadeProduto<T>.New(Parent: T): iEntidadeUnidadeProduto<T>;
begin
  Result := Self.Create(Parent);
end;

function TEntidadeUnidadeProduto<T>.Id(Value: Integer): iEntidadeUnidadeProduto<T>;
begin
  Result := Self;
  FId    := Value;
end;

function TEntidadeUnidadeProduto<T>.Id: Integer;
begin
  Result := FId;
end;

function TEntidadeUnidadeProduto<T>.Unidade(Value: String): iEntidadeUnidadeProduto<T>;
begin
  Result := Self;
  FUnidade := Value;
end;

function TEntidadeUnidadeProduto<T>.Unidade: String;
begin
  Result := FUnidade;
end;

function TEntidadeUnidadeProduto<T>.NomeUnidade(Value: String): iEntidadeUnidadeProduto<T>;
begin
  Result := Self;
  FNomeUnidade := Value;
end;

function TEntidadeUnidadeProduto<T>.NomeUnidade: String;
begin
  Result := FNomeUnidade;
end;

function TEntidadeUnidadeProduto<T>.Ativo(Value: Integer): iEntidadeUnidadeProduto<T>;
begin
  Result := Self;
  FAtivo := Value;
end;

function TEntidadeUnidadeProduto<T>.Ativo: Integer;
begin
  Result := FAtivo;
end;

function TEntidadeUnidadeProduto<T>.&End: T;
begin
  Result := FParent;
end;

end.
