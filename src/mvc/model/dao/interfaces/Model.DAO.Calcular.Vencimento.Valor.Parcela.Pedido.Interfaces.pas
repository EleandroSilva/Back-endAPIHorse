{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 06/05/2024 11:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Calcular.Vencimento.Valor.Parcela.Pedido.Interfaces;

interface

uses
  Data.DB,
  Model.Entidade.Pedido.Pagamento.Interfaces;

type
  iDAOCalcularVencimentoValorParcelaPedido= Interface
    ['{01FE235B-72EF-4BD1-B191-12FE697D769E}']
    function DataSet(DataSource : TDataSource) : iDAOCalcularVencimentoValorParcelaPedido; overload;
    function DataSet                           : TDataSet;                                 overload;
    function QuantidadeParcela(Value : Integer): iDAOCalcularVencimentoValorParcelaPedido; overload;
    function QuantidadeParcela                 : Integer;                                  overload;
    function QuantidadeDias                    : Integer;
    function CalcularVencimento                : TDate;
    function CalcularValorParcela              : Currency;
    function ValorParcela                      : Currency;

    function This : iEntidadePedidoPagamento<iDAOCalcularVencimentoValorParcelaPedido>;
  End;

implementation

end.
