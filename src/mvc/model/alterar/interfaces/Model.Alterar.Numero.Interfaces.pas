{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 01/05/2024 11:37           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Alterar.Numero.Interfaces;

interface

uses
  System.JSON,
  Model.Entidade.Numero.Interfaces,
  Model.Entidade.Empresa.Interfaces;

type
  iAlterarNumero = Interface
    ['{3E86F1F8-9BE7-4DC4-A622-46F67F4211DD}']
    function JSONObjectPai(Value : TJSONObject) : iAlterarNumero; overload;
    function JSONObjectPai                      : TJSONObject;    overload;
    function Put    : iAlterarNumero;
    function Found  : Boolean;
    function Error  : Boolean;

    //injeção de dependência
    function Numero  : iEntidadeNumero<iAlterarNumero>;
    function Empresa : iEntidadeEmpresa<iAlterarNumero>;
    function &End    : iAlterarNumero;
  End;

implementation

end.
