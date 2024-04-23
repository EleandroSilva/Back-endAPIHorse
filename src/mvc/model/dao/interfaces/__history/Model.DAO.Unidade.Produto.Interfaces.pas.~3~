{*******************************************************}
{                    API PDV - JSON                     }
{                      ES Sistemas                      }
{          Início do projeto 18/03/2024 13:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Unidade.Produto.Interfaces;

interface

uses
  Data.DB,
  Model.Entidade.Unidade.Produto.Interfaces;

type
  iDAOUnidadeProduto = interface
    ['{28CE0214-2446-44D5-A197-9492222AABA7}']
    function DataSet(DataSource : TDataSource) : iDAOUnidadeProduto; overload;
    function DataSet                           : TDataSet;           overload;
    function GetAll                            : iDAOUnidadeProduto;
    function GetbyId(Id : Variant)             : iDAOUnidadeProduto;
    function GetbyParams                       : iDAOUnidadeProduto;
    function Post                              : iDAOUnidadeProduto;
    function Put                               : iDAOUnidadeProduto;
    function Delete                            : iDAOUnidadeProduto;

    function This : iEntidadeUnidadeProduto<iDAOUnidadeProduto>;
  end;

implementation

end.
