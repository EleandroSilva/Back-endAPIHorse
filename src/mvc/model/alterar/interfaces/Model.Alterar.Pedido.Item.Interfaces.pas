{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 04/05/2024 11:42           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Alterar.Pedido.Item.Interfaces;

interface

uses
  System.JSON,
  Model.Entidade.Pedido.Item.Interfaces;

type
  iAlterarPedidoItem = Interface
    ['{DDA72835-1137-46B2-90B7-EA77EB16CC53}']
    function JSONObject(Value : TJSONObject) : iAlterarPedidoItem; overload;
    function JSONObject                      : TJSONObject;        overload;
    function Put    : iAlterarPedidoItem;
    function Found  : Boolean;
    function Error  : Boolean;

    //injeção de dependência
    function PedidoItem : iEntidadePedidoItem<iAlterarPedidoItem>;
    function &End         : iAlterarPedidoItem;
  End;

implementation

end.
