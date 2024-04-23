{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 15/04/2024 15:37           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Natureza.Juridica.Interfaces;

interface

uses
  Data.DB,
  Model.Entidade.Natureza.Juridica.Interfaces;

type
  iDAONaturezaJuridica = interface
    ['{340C0BF6-DCBA-42E6-B22B-57D4A68FA2CE}']
    function DataSet(DataSource : TDataSource) : iDAONaturezaJuridica; overload;
    function DataSet                           : TDataSet;             overload;
    function GetAll                            : iDAONaturezaJuridica;
    function GetbyId(Id : Variant)             : iDAONaturezaJuridica;
    function GetbyParams                       : iDAONaturezaJuridica;
    function Post                              : iDAONaturezaJuridica;
    function Put                               : iDAONaturezaJuridica;
    function Delete                            : iDAONaturezaJuridica;
    function QuantidadeRegistro                : Integer;

    function This : iEntidadeNaturezaJuridica<iDAONaturezaJuridica>;
  end;

implementation

end.
