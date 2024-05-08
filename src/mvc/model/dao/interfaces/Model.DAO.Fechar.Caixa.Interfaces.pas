{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 22/04/2024 14:46           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Fechar.Caixa.Interfaces;

interface

uses
  Data.DB,

  Model.Entidade.Fechar.Caixa.Interfaces;

type
  iDAOFecharCaixa = interface
    ['{34E2F218-8023-45CA-B868-2E77D83ACF68}']
    function DataSet    (DataSource : TDataSource) : iDAOFecharCaixa; overload;
    function DataSet                               : TDataSet;        overload;
    function GetAll                                : iDAOFecharCaixa;
    function GetbyId    (Id : Variant)             : iDAOFecharCaixa;
    function GetbyParams                           : iDAOFecharCaixa; overload;
    function GetbyParams(IdUsuario : Variant)      : iDAOFecharCaixa; overload;
    function GetbyParams(NomeUsuario : String)     : iDAOFecharCaixa; overload;
    function GetbyParams(IdPedido : Integer)       : iDAOFecharCaixa; overload;
    function Post                                  : iDAOFecharCaixa;
    function Put                                   : iDAOFecharCaixa;
    function Delete                                : iDAOFecharCaixa;

    function QuantidadeRegistro : Integer;
    function This : iEntidadeFecharCaixa<iDAOFecharCaixa>;
  end;

implementation

end.
