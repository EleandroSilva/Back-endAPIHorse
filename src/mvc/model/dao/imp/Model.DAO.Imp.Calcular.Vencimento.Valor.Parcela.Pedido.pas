unit Model.DAO.Imp.Calcular.Vencimento.Valor.Parcela.Pedido;

interface

uses
  Data.DB,
  System.SysUtils,

  Model.DAO.Calcular.Vencimento.Valor.Parcela.Pedido.Interfaces,
  Model.Entidade.Pedido.Pagamento.Interfaces,
  Model.Entidade.Condicao.Pagamento.Item.Interfaces,
  Controller.Interfaces,
  Model.Conexao.Query.Interfaces;

type
  TDAOCalcularVencimentoValorParcelaPedido = class(TInterfacedObject, iDAOCalcularVencimentoValorParcelaPedido)
    private
      FController      : iController;
      FPedidoPagamento : iEntidadePedidoPagamento<iDAOCalcularVencimentoValorParcelaPedido>;
      FQuery      : iQuery;
      FDataSet    : TDataSet;
      FQuantidadeParcela  : Integer;
      FQuantidadeDias     : Integer;
      FValorParcela       : Currency;

      procedure CalculaVencimentoValorParcela;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOCalcularVencimentoValorParcelaPedido;

      function DataSet(DataSource : TDataSource) : iDAOCalcularVencimentoValorParcelaPedido; overload;
      function DataSet                           : TDataSet;                                 overload;
      function QuantidadeParcela(Value : Integer): iDAOCalcularVencimentoValorParcelaPedido; overload;
      function QuantidadeParcela                 : Integer;                                  overload;
      function QuantidadeDias                    : Integer;
      function CalcularVencimento                : TDate;
      function CalcularValorParcela              : Currency;
      function ValorParcela                      : Currency;

      function This : iEntidadePedidoPagamento<iDAOCalcularVencimentoValorParcelaPedido>;
  end;

implementation

uses
  Imp.Controller,
  Model.Conexao.Query.Imp,
  Model.Entidade.Imp.Pedido.Pagamento;

{ TDAOCalcularVencimentoValorParcelaPedido }

constructor TDAOCalcularVencimentoValorParcelaPedido.Create;
begin
  FController      := TController.New;
  FPedidoPagamento := TEntidadePedidoPagamento<iDAOCalcularVencimentoValorParcelaPedido>.New(Self);
  FQuery           := TQuery.New;
  FQuantidadeParcela  := 0;
  FQuantidadeDias     := 0;
end;

function TDAOCalcularVencimentoValorParcelaPedido.DataSet(DataSource: TDataSource): iDAOCalcularVencimentoValorParcelaPedido;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAOCalcularVencimentoValorParcelaPedido.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

destructor TDAOCalcularVencimentoValorParcelaPedido.Destroy;
begin
  inherited;
end;

class function TDAOCalcularVencimentoValorParcelaPedido.New: iDAOCalcularVencimentoValorParcelaPedido;
begin
  Result := Self.Create;
end;

function TDAOCalcularVencimentoValorParcelaPedido.QuantidadeParcela: Integer;
begin
  Result := FQuantidadeParcela;
end;

function TDAOCalcularVencimentoValorParcelaPedido.QuantidadeParcela(Value: Integer): iDAOCalcularVencimentoValorParcelaPedido;
begin
  Result := Self;
  FQuantidadeParcela := Value;
end;

function TDAOCalcularVencimentoValorParcelaPedido.QuantidadeDias: Integer;
begin
  Result := FQuantidadeDias;
end;

function TDAOCalcularVencimentoValorParcelaPedido.ValorParcela: Currency;
begin
  Result := FValorParcela;
end;

function TDAOCalcularVencimentoValorParcelaPedido.CalcularValorParcela: Currency;
begin
//
end;

function TDAOCalcularVencimentoValorParcelaPedido.CalcularVencimento: TDate;
begin
  CalculaVencimentoValorParcela;
  Result := FPedidoPagamento.DataVencimento;
end;

procedure TDAOCalcularVencimentoValorParcelaPedido.CalculaVencimentoValorParcela;
const
   lSQL=('select '+
         'cp.id, '+
         'cp.quantidadepagamento, '+
         'cp1.numeropagamento, '+
         'cp1.quantidadedias, '+
         'date_add(curdate(), interval cp1.quantidadedias day) as datavencimento '+
         'from condicaopagamento cp '+
         'inner join condicaopagamentoitem cp1 on cp.id = cp1.idcondicaopagamento '
        );
begin
  try
      FDataSet := FQuery
                    .SQL(lSQL)
                    .Add('where cp.id=:id')
                    .Params('Id', FPedidoPagamento.IdCondicaoPagamento)
                    .Add('order by cp.id asc, cp1.quantidadedias asc')
                    .Open
                  .DataSet;
    except
      on E: Exception do
      raise Exception.Create('Erro no servidor'+E.Message);
    end;
  if not FDataSet.IsEmpty then
  begin
    //CalcularValorParcela;
    FValorParcela := FPedidoPagamento.ValorReceber/FDataSet.FieldByName('quantidadepagamento').AsInteger;
    FPedidoPagamento.DataVencimento(FDataSet.FieldByName('datavencimento').AsDateTime);
  end;
end;

//injeção de dependência
function TDAOCalcularVencimentoValorParcelaPedido.This: iEntidadePedidoPagamento<iDAOCalcularVencimentoValorParcelaPedido>;
begin
  Result := FPedidoPagamento;
end;

end.
