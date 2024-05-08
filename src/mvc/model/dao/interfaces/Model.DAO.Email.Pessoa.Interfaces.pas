{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 03/04/2024 16:03           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Email.Pessoa.Interfaces;


interface

uses
  Data.DB,

  Model.Entidade.Email.Pessoa.Interfaces;

type
  iDAOEmailPessoa = interface
    ['{8A6A473E-E1DB-4D16-811D-95C95F8A2E8B}']
    function DataSet(DataSource : TDataSource) : iDAOEmailPessoa; overload;
    function DataSet                           : TDataSet;        overload;
    function GetAll                            : iDAOEmailPessoa;
    function GetbyId(Id : Variant)             : iDAOEmailPessoa; overload;
    function GetbyId(IdEmpresa : Integer)      : iDAOEmailPessoa; overload;
    function GetbyParams                       : iDAOEmailPessoa;
    function Post                              : iDAOEmailPessoa;
    function Put                               : iDAOEmailPessoa;
    function Delete                            : iDAOEmailPessoa;

    function QuantidadeRegistro : Integer;
    function This : iEntidadeEmailPessoa<iDAOEmailPessoa>;
  end;


implementation

end.
