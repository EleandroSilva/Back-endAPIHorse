{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 22/04/2024 20:50           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Pedido.Pagamento.Interfaces;

interface

uses
  Data.DB,
  Model.Entidade.Pedido.Pagamento.Interfaces;

Type
  iDAOPedidoPagamento = Interface
    ['{BE94770E-86AF-4C61-B69D-7B6C8DEABD82}']
    function DataSet    (DataSource : TDataSource) : iDAOPedidoPagamento; overload;
    function DataSet                               : TDataSet;            overload;
    function GetAll                                : iDAOPedidoPagamento;
    function GetbyId    (Id : Variant)             : iDAOPedidoPagamento; overload;
    function GetbyId    (IdParent : Integer)       : iDAOPedidoPagamento; overload;
    function GetbyParams                           : iDAOPedidoPagamento; overload;
    function Post                                  : iDAOPedidoPagamento;
    function Put                                   : iDAOPedidoPagamento;
    function Delete                                : iDAOPedidoPagamento;
    function CalcularVencimentoValorParcela        : iDAOPedidoPagamento;
    function ValorReceber(Value : Currency)        : iDAOPedidoPagamento; overload;
    function ValorReceber                          : Currency;            overload;
    function ValorParcela(Value : Currency)        : iDAOPedidoPagamento; overload;
    function ValorParcela                          : Currency;            overload;

    function QuantidadeRegistro : Integer;
    function This : iEntidadePedidoPagamento<iDAOPedidoPagamento>;
  End;

implementation

end.
