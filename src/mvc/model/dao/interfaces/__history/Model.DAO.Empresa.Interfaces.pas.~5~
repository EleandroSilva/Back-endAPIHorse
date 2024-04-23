{*******************************************************}
{                    API PDV - JSON                     }
{                      ES Sistemas                      }
{          Início do projeto 18/03/2024 13:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Empresa.Interfaces;

interface

uses
  Data.DB,

  Model.Entidade.Empresa.Interfaces;

type
  iDAOEmpresa = interface
    ['{D0039C56-072A-4099-825B-1E07FC70CFC3}']
    function DataSet(DataSource : TDataSource) : iDAOEmpresa; overload;
    function DataSet                           : TDataSet;    overload;
    function GetAll                            : iDAOEmpresa;
    function GetbyId(Id : Variant)             : iDAOEmpresa;
    function GetbyParams                       : iDAOEmpresa;
    function Post                              : iDAOEmpresa;
    function Put                               : iDAOEmpresa;
    function Delete                            : iDAOEmpresa;

    function This : iEntidadeEmpresa<iDAOEmpresa>;
  end;

implementation

end.
