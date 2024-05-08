{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 04/05/2024 11:42           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Alterar.Pedido.Interfaces;

interface

uses
  System.JSON, Model.Entidade.Pedido.Interfaces;

type
  iAlterarPedido = Interface
    ['{D2E96E66-52D4-4303-B951-0849E0CA3A85}']
    function JSONObject(Value : TJSONObject) : iAlterarPedido; overload;
    function JSONObject                      : TJSONObject;    overload;
    function Put                             : iAlterarPedido; overload;
    function Found  : Boolean;
    function Error  : Boolean;

    //injeção de dependência
    function This : iEntidadePedido<iAlterarPedido>;
    function &End : iAlterarPedido;
  End;

implementation

end.
