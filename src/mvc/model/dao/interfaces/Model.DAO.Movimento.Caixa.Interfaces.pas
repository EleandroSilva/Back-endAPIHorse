{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 22/04/2024 14:46           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Movimento.Caixa.Interfaces;

interface

uses
  Data.DB,

  Model.Entidade.Movimento.Caixa.Interfaces;

type
  iDAOMovimentoCaixa = interface
    ['{34E2F218-8023-45CA-B868-2E77D83ACF68}']
    function DataSet    (DataSource : TDataSource) : iDAOMovimentoCaixa; overload;
    function DataSet                               : TDataSet;           overload;
    function GetAll                                : iDAOMovimentoCaixa;
    function GetbyId    (Id : Variant)             : iDAOMovimentoCaixa;
    function GetbyParams                           : iDAOMovimentoCaixa; overload;
    function GetbyParams(aIdUsuario : Variant)     : iDAOMovimentoCaixa; overload;
    function GetbyParams(aNomeUsuario : String)    : iDAOMovimentoCaixa; overload;
    function GetbyParams(aIdPedido : Integer)      : iDAOMovimentoCaixa; overload;
    function Post                                  : iDAOMovimentoCaixa;
    function Put                                   : iDAOMovimentoCaixa;
    function Delete                                : iDAOMovimentoCaixa;
    function QuantidadeRegistro                    : Integer;

    function This : iEntidadeMovimentoCaixa<iDAOMovimentoCaixa>;
  end;

implementation

end.
