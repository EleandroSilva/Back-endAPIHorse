{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 08/04/2024 18:12           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Regiao.Estado.Interfaces;

interface

uses
  Data.DB,

  Model.Entidade.Regiao.Estado.Interfaces;

type
  iDAORegiaoEstado = interface
    ['{2C676724-64D0-43C7-94B5-79C4E2B04C01}']
    function DataSet(DataSource : TDataSource) : iDAORegiaoEstado; overload;
    function DataSet                           : TDataSet;         overload;
    function GetAll                            : iDAORegiaoEstado;
    function GetbyId(Id : Variant)             : iDAORegiaoEstado;
    function GetbyParams                       : iDAORegiaoEstado;
    function Post                              : iDAORegiaoEstado;
    function Put                               : iDAORegiaoEstado;
    function Delete                            : iDAORegiaoEstado;
    function QuantidadeRegistro                : Integer;

    function This : iEntidadeRegiaoEstado<iDAORegiaoEstado>;
  end;

implementation

end.
