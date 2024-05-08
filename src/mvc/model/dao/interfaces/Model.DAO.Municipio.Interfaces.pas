{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 08/04/2024 18:12           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Municipio.Interfaces;

interface

uses
  Data.DB,

  Model.Entidade.Municipio.Interfaces;

type
  iDAOMunicipio = interface
    ['{C79E95BF-E9B2-44EE-9DEA-70981317555B}']
    function DataSet(DataSource : TDataSource) : iDAOMunicipio; overload;
    function DataSet                           : TDataSet;      overload;
    function GetAll                            : iDAOMunicipio;
    function GetbyId(Id : Variant)             : iDAOMunicipio;
    function GetbyParams                       : iDAOMunicipio;
    function Post                              : iDAOMunicipio;
    function Put                               : iDAOMunicipio;
    function Delete                            : iDAOMunicipio;

    function QuantidadeRegistro : Integer;
    function This : iEntidadeMunicipio<iDAOMunicipio>;
  end;

implementation

end.
