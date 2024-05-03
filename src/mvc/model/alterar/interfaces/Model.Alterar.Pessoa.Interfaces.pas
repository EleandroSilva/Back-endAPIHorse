{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 02/05/2024 13:42           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Alterar.Pessoa.Interfaces;

interface

uses
  System.JSON,
  Model.Entidade.Pessoa.Interfaces,
  Model.Entidade.Endereco.Interfaces;

type
  iAlterarPessoa = Interface
    ['{EC95F7CC-6EF7-40D9-9DAE-07B674C34D46}']
    function JSONObject(Value : TJSONObject) : iAlterarPessoa; overload;
    function JSONObject                      : TJSONObject;    overload;
    function Put    : iAlterarPessoa;
    function Found  : Boolean;
    function Error  : Boolean;

    //injeção de dependência
    function Pessoa   : iEntidadePessoa  <iAlterarPessoa>;
    function Endereco : iEntidadeEndereco<iAlterarPessoa>;
    function &End     : iAlterarPessoa;
  End;

implementation

end.
