{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 03/05/2024 13:46           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Cadastrar.Pedido.Item.Interfaces;

interface

uses
  Data.DB,
  System.JSON,
  Model.Entidade.Pedido.Item.Interfaces;

type
  iCadastrarPedidoItem = Interface
    ['{0EEAD4D9-411A-4A37-A000-EAFEE466C315}']
    function JSONObjectPai(Value : TJSONObject)   : iCadastrarPedidoItem; overload;
    function JSONObjectPai                        : TJSONObject;          overload;
    function DataSet(DataSource : TDataSource)    : iCadastrarPedidoItem; overload;
    function DataSet                              : TDataSet;             overload;
    function Post   : iCadastrarPedidoItem;
    function Error  : Boolean;
    //injeção de dependência
    function This : iEntidadePedidoItem<iCadastrarPedidoItem>;
  End;

implementation

end.
