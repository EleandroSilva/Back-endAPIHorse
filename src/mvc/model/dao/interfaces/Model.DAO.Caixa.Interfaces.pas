{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 22/04/2024 14:46           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Caixa.Interfaces;

interface

uses
  Data.DB,
  Model.Entidade.Caixa.Interfaces;

type
  iDAOCaixa = interface
    ['{DEFD9C2F-531C-4608-BAF1-45FDBCC8810A}']
    function DataSet    (DataSource : TDataSource) : iDAOCaixa; overload;
    function DataSet                               : TDataSet;  overload;
    function GetAll                                : iDAOCaixa;
    function GetbyId    (Id : Variant)             : iDAOCaixa;
    function GetbyParams                           : iDAOCaixa; overload;
    function GetbyParams(IdUsuario : Variant)      : iDAOCaixa; overload;
    function GetbyParams(NomeUsuario : String)     : iDAOCaixa; overload;
    function Post                                  : iDAOCaixa;
    function Put                                   : iDAOCaixa;
    function Delete                                : iDAOCaixa;

    function QuantidadeRegistro : Integer;
    function This : iEntidadeCaixa<iDAOCaixa>;
  end;

implementation

end.
