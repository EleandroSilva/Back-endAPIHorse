{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 03/04/2024 16:03           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Email.Empresa.Interfaces;

interface

uses
  Data.DB,

  Model.Entidade.Email.Empresa.Interfaces;

type
  iDAOEmailEmpresa = interface
    ['{F78668F7-F22F-4D73-96DB-C244BBC29BB9}']
    function DataSet(DataSource : TDataSource) : iDAOEmailEmpresa; overload;
    function DataSet                           : TDataSet;         overload;
    function GetAll                            : iDAOEmailEmpresa;
    function GetbyId(Id : Variant)             : iDAOEmailEmpresa;
    function GetbyParams                       : iDAOEmailEmpresa;
    function Post                              : iDAOEmailEmpresa;
    function Put                               : iDAOEmailEmpresa;
    function Delete                            : iDAOEmailEmpresa;
    function QuantidadeRegistro                : Integer;

    function This : iEntidadeEmailEmpresa<iDAOEmailEmpresa>;
  end;

implementation

end.
