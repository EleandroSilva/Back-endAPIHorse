{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 03/05/2024 14:31           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Cadastrar.Pedido.Pagamento.Interfaces;

interface

uses
  System.JSON,
  Model.Entidade.Pedido.Pagamento.Interfaces;

type
  iCadastrarPedidoPagamento = Interface
    ['{35231893-CB62-45C5-B862-88C47038233A}']
    function JSONObjectPai(Value : TJSONObject) : iCadastrarPedidoPagamento; overload;
    function JSONObjectPai                      : TJSONObject;               overload;
    function Post   : iCadastrarPedidoPagamento;
    function Error  : Boolean;
    //injeção de dependência
    function PedidoPagamento : iEntidadePedidoPagamento<iCadastrarPedidoPagamento>;
    function &End : iCadastrarPedidoPagamento;
  End;

implementation

end.
