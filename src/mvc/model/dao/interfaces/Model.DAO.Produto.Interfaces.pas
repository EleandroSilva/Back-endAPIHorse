{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 19/03/2024 22:59           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Produto.Interfaces;

interface

uses
  Data.DB,

  Model.Entidade.Produto.Interfaces;

Type
  iDAOProduto= interface
    ['{EF37767E-DD3E-40BB-98CB-4A4793D2DA4F}']
    function DataSet(DataSource : TDataSource) : iDAOProduto; overload;
    function DataSet                           : TDataSet;    overload;
    function GetAll                            : iDAOProduto;
    function GetbyId(Id : Variant)             : iDAOProduto;
    function GetbyParams                       : iDAOProduto;
    function Post                              : iDAOProduto;
    function Put                               : iDAOProduto;
    function Delete                            : iDAOProduto;

    function QuantidadeRegistro : Integer;
    function This : iEntidadeProduto<iDAOProduto>;
  end;

implementation

end.
