{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 22/04/2024 17:02           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Pedido.Item.Interfaces;

interface

uses
  Data.DB,
  Model.Entidade.Pedido.Item.Interfaces;

type
  iDAOPedidoItem = Interface
    ['{36AA7F96-3B68-4870-8224-0E77062C0396}']
    function DataSet    (DataSource : TDataSource) : iDAOPedidoItem; overload;
    function DataSet                               : TDataSet;       overload;
    function GetAll                                : iDAOPedidoItem;
    function GetbyId    (Id : Variant)             : iDAOPedidoItem; overload;
    function GetbyId    (IdParent : Integer)       : iDAOPedidoItem; overload;
    function GetbyParams                           : iDAOPedidoItem; overload;
    function GetbyParams(aIdProduto : Variant)     : iDAOPedidoItem; overload;
    function GetbyParams(aNomeProduto : String)    : iDAOPedidoItem; overload;
    function Post                                  : iDAOPedidoItem;
    function Put                                   : iDAOPedidoItem;
    function Delete                                : iDAOPedidoItem;
    function QuantidadeRegistro                    : Integer;

    function This : iEntidadePedidoItem<iDAOPedidoItem>;
  End;

implementation

end.
