{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 22/04/2024 12:08           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Pedido.Pagamento.Interfaces;

interface

uses
  Model.Entidade.Condicao.Pagamento.Interfaces;

type
  iEntidadePedidoPagamento<T> = interface
    ['{EEF6F7DC-FC27-4E38-BC0E-FA4F603CEC25}']
    function Id                 (Value : Integer)   : iEntidadePedidoPagamento<T>; overload;
    function Id                                     : Integer;                     overload;
    function IdPedido           (Value : Integer)   : iEntidadePedidoPagamento<T>; overload;
    function IdPedido                               : Integer;                     overload;
    function IdCondicaoPagamento(Value : Integer)   : iEntidadePedidoPagamento<T>; overload;
    function IdCondicaoPagamento                    : Integer;                     overload;
    function DataVencimento     (Value : TDateTime) : iEntidadePedidoPagamento<T>; overload;
    function DataVencimento                         : TDateTime;                   overload;
    function ValorParcela       (Value : Currency)  : iEntidadePedidoPagamento<T>; overload;
    function ValorParcela                           : Currency;                    overload;
    function ValorReceber       (Value : Currency)  : iEntidadePedidoPagamento<T>; overload;
    function ValorReceber                           : Currency;                    overload;

    //Injeção de dependência
    function CondicaoPagamento : iEntidadeCondicaoPagamento<iEntidadePedidoPagamento<T>>;
    function &End : T;
  end;


implementation

end.
