{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 04/05/2024 11:42           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Alterar.Pedido.Pagamento.Interfaces;

interface

uses
  System.JSON,
  Model.Entidade.Pedido.Pagamento.Interfaces;

type
  iAlterarPedidoPagamento = Interface
    ['{EEA4AF97-47DC-451E-8C16-243227231968}']
    function JSONObject(Value : TJSONObject) : iAlterarPedidoPagamento; overload;
    function JSONObject                      : TJSONObject;             overload;
    function Put    : iAlterarPedidoPagamento;
    function Found  : Boolean;
    function Error  : Boolean;

    //injeção de dependência
    function PedidoPagamento : iEntidadePedidoPagamento<iAlterarPedidoPagamento>;
    function &End : iAlterarPedidoPagamento;
  End;

implementation

end.
