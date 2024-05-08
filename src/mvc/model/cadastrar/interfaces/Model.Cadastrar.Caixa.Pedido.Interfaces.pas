{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 03/05/2024 14:57           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Cadastrar.Caixa.Pedido.Interfaces;

interface

uses
  System.JSON,
  Model.Entidade.Caixa.Pedido.Interfaces;

type
  iCadastrarCaixaPedido = Interface
    ['{8C161547-B0AE-4A62-9841-14CB78E71B46}']
    function JSONObjectPai(Value : TJSONObject) : iCadastrarCaixaPedido; overload;
    function JSONObjectPai                      : TJSONObject;           overload;
    function Post   : iCadastrarCaixaPedido;
    function Error  : Boolean;
    //injeção de dependência
    function This : iEntidadeCaixaPedido<iCadastrarCaixaPedido>;
  End;

implementation

end.
