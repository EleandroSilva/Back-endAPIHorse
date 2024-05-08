{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 03/05/2024 14:31           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Cadastrar.Pedido.Pagamento;

interface

uses
  Data.DB,
  System.SysUtils,
  System.JSON,
  DataSet.Serialize,

  Model.Cadastrar.Pedido.Pagamento.Interfaces,
  Controller.Interfaces,
  Model.Entidade.Pedido.Pagamento.Interfaces;

type
  TCadastrarPedidoPagamento = class(TInterfacedObject, iCadastrarPedidoPagamento)
    private
      FController      : iController;
      FPedidoPagamento : iEntidadePedidoPagamento<iCadastrarPedidoPagamento>;
      FDataSet : TDataSource;
      FDataSetSomar : TDataSource;

      FJSONObjectPai : TJSONObject;
      FJSONArray     : TJSONArray;
      FJSONObject    : TJSONObject;
      FError : Boolean;

      procedure SomarTabelaPedidoItem;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iCadastrarPedidoPagamento;

      function JSONObjectPai(Value : TJSONObject) : iCadastrarPedidoPagamento; overload;
      function JSONObjectPai                      : TJSONObject;               overload;
      function Post   : iCadastrarPedidoPagamento;
      function Error  : Boolean;
      //injeção de dependência
      function This : iEntidadePedidoPagamento<iCadastrarPedidoPagamento>;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Pedido.Pagamento;

{ TCadastrarPedidoPagamento }

constructor TCadastrarPedidoPagamento.Create;
begin
  FController      := TController.New;;
  FPedidoPagamento := TEntidadePedidoPagamento<iCadastrarPedidoPagamento>.New(Self);
  FDataSet      := TDataSource.Create(nil);
  FDataSetSomar := TDataSource.Create(nil);
  FError := False;
end;

destructor TCadastrarPedidoPagamento.Destroy;
begin
  inherited;
end;

class function TCadastrarPedidoPagamento.New: iCadastrarPedidoPagamento;
begin
  Result := Self.Create;
end;

function TCadastrarPedidoPagamento.JSONObjectPai(Value: TJSONObject): iCadastrarPedidoPagamento;
begin
  Result := Self;
  FJSONObjectPai := Value;
end;

function TCadastrarPedidoPagamento.JSONObjectPai: TJSONObject;
begin
  Result := FJSONObjectPai;
end;

function TCadastrarPedidoPagamento.Post: iCadastrarPedidoPagamento;
Var
  I, lQtde : Integer;
  lValorParcela : Currency;
begin
  Result := Self;
  //Obtém os dados JSON do corpo da requisição da tabela('pedidopagamento')
  FJSONArray := FJSONObjectPai.GetValue('pedidopagamento') as TJSONArray;
  SomarTabelaPedidoItem;
  FController
    .FactoryDAO
      .DAOPedidoPagamento
        .This
          .IdPedido           (FPedidoPagamento.IdPedido)
          .IdCondicaoPagamento(FJSONObjectPai.GetValue<Integer>('idcondicaopagamento'))
        .&End
          .ValorReceber(FDataSetSomar.DataSet.FieldByName('valorreceber').AsCurrency)
          .CalcularVencimentoValorParcela
        .DataSet(FDataSet);
  lQtde := FDataSet.DataSet.FieldByName('quantidadepagamento').AsInteger;
  for I := 0 to lQtde - 1 do
  begin
    lValorParcela :=0;
    try
      lValorParcela := FDataSetSomar.DataSet.FieldByName('valorreceber').AsCurrency/ lQtde;
        FController
          .FactoryDAO
            .DAOPedidoPagamento
              .This
                .IdPedido           (FPedidoPagamento.IdPedido)
                .IdCondicaoPagamento(FJSONObjectPai.GetValue<Integer>('idcondicaopagamento'))
                .DataVencimento     (FDataSet.DataSet.FieldByName('datavencimento').AsDateTime)
                .ValorParcela       (lValorParcela)
                .ValorReceber       (FDataSetSomar.DataSet.FieldByName('valorreceber').AsCurrency)
              .&End
            .Post;
    except
      on E: Exception do
      begin
        WriteLn('Erro ao tentar incluir itens do pedido: ' + E.Message);
        //caso ocorrer algum erro no lançamento do item, excluo o pedido lançado
        FController
          .FactoryDAO
            .DAOPessoa
              .This
                .Id(FPedidoPagamento.IdPedido)
              .&End
            .Delete;
            Exit;
        FError := True;
      end;
    end;
  end;
end;

procedure TCadastrarPedidoPagamento.SomarTabelaPedidoItem;
begin
  FController
    .FactoryDAO
      .DAOPedidoItem
        .This
          .IdPedido(FPedidoPagamento.IdPedido)
        .&End
      .SomarPedidoItem
      .DataSet(FDataSetSomar);
end;

function TCadastrarPedidoPagamento.Error: Boolean;
begin
  Result := FError;
end;

function TCadastrarPedidoPagamento.This: iEntidadePedidoPagamento<iCadastrarPedidoPagamento>;
begin
  Result := FPedidoPagamento;
end;

end.
