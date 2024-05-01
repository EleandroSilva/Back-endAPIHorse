{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 01/05/2024 19:12           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Alterar.Usuario.Interfaces;

interface

uses
  System.JSON,
  Model.Entidade.Usuario.Interfaces;

type
  iAlterarUsuario = Interface
    ['{9DF68107-F8E9-4152-AE31-80BB787F5D82}']
    function JSONObjectPai(Value : TJSONObject) : iAlterarUsuario; overload;
    function JSONObjectPai                      : TJSONObject;     overload;
    function Put    : iAlterarUsuario;
    function Found  : Boolean;
    function Error  : Boolean;

    //injeção de dependência
    function Usuario : iEntidadeUsuario<iAlterarUsuario>;
    function &End    : iAlterarUsuario;
  End;

implementation

end.
