{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 04/05/2024 11:42           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Pesquisar.Pedido.Interfaces;

interface

uses
  System.JSON, Model.Entidade.Pedido.Interfaces;

type
  iPesquisarPedido = Interface
    ['{A1CE483D-7EC1-40D1-A36C-0580D3111553}']
    function GetBy(Id : Integer) : iPesquisarPedido;
    function LoopPedido : TJSONValue;
    function Found : Boolean;
    function Error : Boolean;

    function Pedido : iEntidadePedido<iPesquisarPedido>;
    function &End   : iPesquisarPedido;
  End;

implementation

end.
