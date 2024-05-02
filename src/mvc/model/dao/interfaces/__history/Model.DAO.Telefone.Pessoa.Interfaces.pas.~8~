{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 05/04/2024 09:19           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2004/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Telefone.Pessoa.Interfaces;

interface

uses
  Data.DB,

  Model.Entidade.Telefone.Pessoa.Interfaces;

type
  iDAOTelefonePessoa = interface
    ['{98302B83-72D5-43FF-9398-23D73BE52AEA}']
    function DataSet(DataSource : TDataSource) : iDAOTelefonePessoa; overload;
    function DataSet                           : TDataSet;           overload;
    function GetAll                            : iDAOTelefonePessoa;
    function GetbyId(Id : Variant)             : iDAOTelefonePessoa;
    function GetbyParams                       : iDAOTelefonePessoa;
    function Post                              : iDAOTelefonePessoa;
    function Put                               : iDAOTelefonePessoa;
    function Delete                            : iDAOTelefonePessoa;
    function QuantidadeRegistro                : Integer;

    function This : iEntidadeTelefonePessoa<iDAOTelefonePessoa>;
  end;

implementation

end.
