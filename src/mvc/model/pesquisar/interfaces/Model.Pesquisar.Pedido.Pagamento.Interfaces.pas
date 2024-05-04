{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 04/05/2024 11:42           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Pesquisar.Pedido.Pagamento.Interfaces;

interface

uses
  System.JSON,
  Model.Entidade.Pedido.Pagamento.Interfaces;

type
  iPesquisarPedidoPagamento = Interface
    ['{CE9D7C29-E929-40E2-83CD-B1C3A6C515DD}']
    function GetBy(IdPedido : Integer) : iPesquisarPedidoPagamento;
    function LoopPedidoPagamento : TJSONValue;
    function Found : Boolean;
    function Error : Boolean;

    function PedidoPagamento : iEntidadePedidoPagamento<iPesquisarPedidoPagamento>;
    function &End : iPesquisarPedidoPagamento;
  End;

implementation

end.
