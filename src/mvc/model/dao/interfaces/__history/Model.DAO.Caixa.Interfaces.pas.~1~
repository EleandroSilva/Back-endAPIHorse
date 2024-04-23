{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 22/04/2024 14:46           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Caixa.Diario.Interfaces;

interface

uses
  Data.DB,
  Model.Entidade.Caixa.Diario.Interfaces;

type
  iDAOCaixaDiario = interface
    ['{DEFD9C2F-531C-4608-BAF1-45FDBCC8810A}']
    function DataSet    (DataSource : TDataSource) : iDAOCaixaDiario; overload;
    function DataSet                               : TDataSet;        overload;
    function GetAll                                : iDAOCaixaDiario;
    function GetbyId    (Id : Variant)             : iDAOCaixaDiario;
    function GetbyParams                           : iDAOCaixaDiario; overload;
    function GetbyParams(aIdUsuario : Variant)     : iDAOCaixaDiario; overload;
    function GetbyParams(aNomeUsuario : String)    : iDAOCaixaDiario; overload;
    function Post                                  : iDAOCaixaDiario;
    function Put                                   : iDAOCaixaDiario;
    function Delete                                : iDAOCaixaDiario;
    function QuantidadeRegistro                    : Integer;

    function This : iEntidadeCaixaDiario<iDAOCaixaDiario>;
  end;

implementation

end.
