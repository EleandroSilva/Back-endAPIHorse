{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 02/05/2024 10:23           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Pesquisar.Email.Pessoa.Interfaces;

interface

uses
  Data.DB,
  System.JSON,
  Model.Entidade.Email.Pessoa.Interfaces;

type
  iPesquisarEmailPessoa = Interface
    ['{38A8C4E5-BE96-4EF7-8E33-B041DD62A3A3}']
    function GetBy(IdPessoa : Integer; Email: String) : iPesquisarEmailPessoa;
    function LoopEmailPessoa : TJSONValue;
    function Found : Boolean;
    function Error : Boolean;

    function EmailPessoa : iEntidadeEmailPessoa<iPesquisarEmailPessoa>;
    function &End  : iPesquisarEmailPessoa;
  End;

implementation

end.
