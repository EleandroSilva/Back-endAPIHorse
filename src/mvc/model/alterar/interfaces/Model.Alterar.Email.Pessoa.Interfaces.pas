{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 02/05/2024 13:42           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Alterar.Email.Pessoa.Interfaces;

interface
uses
  System.JSON,
  Model.Entidade.Email.Pessoa.Interfaces;

type
  iAlterarEmailPessoa = Interface
    ['{AB9B2F91-FACE-45DF-B826-24036E62BE03}']
    function JSONObject(Value : TJSONObject) : iAlterarEmailPessoa; overload;
    function JSONObject                      : TJSONObject;         overload;
    function Put    : iAlterarEmailPessoa;
    function Found  : Boolean;
    function Error  : Boolean;

    //injeção de dependência
    function EmailPessoa : iEntidadeEmailPessoa<iAlterarEmailPessoa>;
    function &End        : iAlterarEmailPessoa;
  End;

implementation

end.
