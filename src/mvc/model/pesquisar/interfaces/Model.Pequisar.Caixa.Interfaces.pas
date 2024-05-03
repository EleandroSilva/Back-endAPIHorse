{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 02/05/2024 19:57           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Pequisar.Caixa.Interfaces;

interface

uses
  Data.DB,
  System.JSON,
  Model.Entidade.Caixa.Interfaces;

type
  iPesquisarCaixa = Interface
    ['{FF9B4F5E-DFC9-4F10-8DB6-01DD0F8D9BC6}']
    function JSONValue(Value : TJSONValue) : iPesquisarCaixa; overload;
    function JSONValue                     : TJSONValue;      overload;
    function GetbyId(Id : Variant)         : iPesquisarCaixa;
    function GetbyParams(Value : String)   : iPesquisarCaixa;
    function GetAll                        : iPesquisarCaixa;
    function Found : Boolean;
    function Error : Boolean;
    function Caixa : iEntidadeCaixa<iPesquisarCaixa>;
    function &End  : iPesquisarCaixa;
  End;

implementation

end.
