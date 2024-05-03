{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 02/05/2024 11:44           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Cadastrar.Telefone.Pessoa.Interfaces;

interface

uses
  System.JSON,
  Model.Entidade.Telefone.Pessoa.Interfaces;

type
  iCadastrarTelefonePessoa = Interface
    ['{4959666E-DE3A-4E16-93FB-5E72A8F236D1}']
    function JSONObjectPai(Value : TJSONObject) : iCadastrarTelefonePessoa; overload;
    function JSONObjectPai                      : TJSONObject;              overload;
    function Post  : iCadastrarTelefonePessoa;
    function Error : Boolean;
    //injeção de dependência
    function TelefonePessoa : iEntidadeTelefonePessoa<iCadastrarTelefonePessoa>;
    function &End : iCadastrarTelefonePessoa;
  End;

implementation

end.
