{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 26/04/2024 16:08           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Caixa.Pedido.Interfaces;

interface

uses
  Data.DB,
  Model.Entidade.Caixa.Pedido.Interfaces;

type
  iDAOCaixaPedido = interface
    ['{4FBE6D06-70B6-4EC1-9D92-0F66ABB3A4C9}']
    function DataSet(DataSource : TDataSource) : iDAOCaixaPedido; overload;
    function DataSet                           : TDataSet;        overload;
    function GetAll                            : iDAOCaixaPedido;
    function GetbyId(Id : Variant)             : iDAOCaixaPedido;
    function GetbyParams                       : iDAOCaixaPedido;
    function Post                              : iDAOCaixaPedido;
    function Put                               : iDAOCaixaPedido;
    function Delete                            : iDAOCaixaPedido;

    function QuantidadeRegistro : Integer;
    function This : iEntidadeCaixaPedido<iDAOCaixaPedido>;
  end;

implementation

end.
