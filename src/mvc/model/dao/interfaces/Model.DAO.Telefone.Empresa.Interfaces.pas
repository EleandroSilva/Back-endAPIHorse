{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 05/04/2024 09:19           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2004/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Telefone.Empresa.Interfaces;

interface

uses
  Data.DB,

  Model.Entidade.Telefone.Empresa.Interfaces;

type
  iDAOTelefoneEmpresa = interface
    ['{A97FF857-2667-454B-930B-F9EABBA6A1F7}']
    function DataSet(DataSource : TDataSource) : iDAOTelefoneEmpresa; overload;
    function DataSet                           : TDataSet;            overload;
    function GetAll                            : iDAOTelefoneEmpresa;
    function GetbyId(Id : Variant)             : iDAOTelefoneEmpresa; overload;
    function GetbyId(IdEmpresa : Integer)      : iDAOTelefoneEmpresa; overload;
    function GetbyParams                       : iDAOTelefoneEmpresa; overload;
    function Post                              : iDAOTelefoneEmpresa;
    function Put                               : iDAOTelefoneEmpresa;
    function Delete                            : iDAOTelefoneEmpresa;

    function QuantidadeRegistro : Integer;
    function This : iEntidadeTelefoneEmpresa<iDAOTelefoneEmpresa>;
  end;

implementation

end.
