{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 02/05/2024 11:26           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Cadastrar.Email.Pessoa.Interfaces;

interface

uses
  System.JSON,
  Model.Entidade.Email.Pessoa.Interfaces;

type
  iCadastrarEmailPessoa = Interface
    ['{F670D358-DD83-47B4-8EFA-CE874A619149}']
    function JSONObjectPai(Value : TJSONObject) : iCadastrarEmailPessoa; overload;
    function JSONObjectPai                      : TJSONObject;           overload;
    function Post : iCadastrarEmailPessoa;

    function Error     : Boolean;
    //injeção de dependência
    function EmailPessoa : iEntidadeEmailPessoa<iCadastrarEmailPessoa>;
    function &End : iCadastrarEmailPessoa;
  End;

implementation

end.
