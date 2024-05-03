{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 02/05/2024 08:57           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Cadastrar.Pessoa.Interfaces;

interface

uses
  System.JSON,
  Model.Entidade.Pessoa.Interfaces;

type
  iCadastrarPessoa = interface
    ['{545CF3C4-48EF-4B44-96FC-85EFDD4EB1E0}']
    function JSONObject(Value : TJSONObject) : iCadastrarPessoa; overload;
    function JSONObject                      : TJSONObject;       overload;
    function Post   : iCadastrarPessoa;

    function Found  : Boolean;
    function Error  : Boolean;
    //injeção de dependência
    function Pessoa : iEntidadePessoa<iCadastrarPessoa>;
    function &End   : iCadastrarPessoa;
  end;

implementation

end.
