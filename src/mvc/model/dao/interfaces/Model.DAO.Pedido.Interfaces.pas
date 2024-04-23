{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 22/04/2024 17:02           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Pedido.Interfaces;

interface

uses
  Data.DB,
  Model.Entidade.Pedido.Interfaces;

type
  iDAOPedido = interface
    ['{3E6C679D-FF0D-4215-B74E-ECF28B86DD5B}']
    function DataSet    (DataSource : TDataSource) : iDAOPedido; overload;
    function DataSet                               : TDataSet;   overload;
    function GetAll                                : iDAOPedido;
    function GetbyId    (Id : Variant)             : iDAOPedido;
    function GetbyParams                           : iDAOPedido; overload;
    function GetbyParams(aIdUsuario : Variant)     : iDAOPedido; overload;
    function GetbyParams(aIdPessoa : Integer)      : iDAOPedido; overload;
    function GetbyParams(aNomePessoa : String)     : iDAOPedido; overload;
    function Post                                  : iDAOPedido;
    function Put                                   : iDAOPedido;
    function Delete                                : iDAOPedido;
    function QuantidadeRegistro                    : Integer;

    function This : iEntidadePedido<iDAOPedido>;
  end;

implementation

end.
