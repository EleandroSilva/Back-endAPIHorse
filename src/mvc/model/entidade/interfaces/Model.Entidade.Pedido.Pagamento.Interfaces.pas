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

type
  iEntidadePedidoPagamento<T> = interface
    ['{9F0EF96D-4DC6-47DC-90E3-EB9523EF1909}']
    function Id            (Value : Integer)   : iEntidadePedidoPagamento<T>; overload;
    function Id                                : Integer;                     overload;
    function IdPedido      (Value : Integer)   : iEntidadePedidoPagamento<T>; overload;
    function IdPedido                          : Integer;                     overload;
    function IdPagamento   (Value : Integer)   : iEntidadePedidoPagamento<T>; overload;
    function IdPagamento                       : Integer;                     overload;
    function DataVencimento(Value : TDateTime) : iEntidadePedidoPagamento<T>; overload;
    function DataVencimento                    : TDateTime;                   overload;
    function ValorParcela  (Value : Currency)  : iEntidadePedidoPagamento<T>; overload;
    function ValorParcela                      : Currency;                    overload;

    function &End : T;
  end;


implementation

end.
