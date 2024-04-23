{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 22/04/2024 11:46           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Condicao.Pagamento.Item.Interfaces;

interface

type
  iEntidadeCondicaoPagamentoItem<T> = interface
    ['{4446EE5D-438F-4BA5-819C-6D06467D3753}']
    function Id                 (Value : Integer) : iEntidadeCondicaoPagamentoItem<T>; overload;
    function Id                                   : Integer;                           overload;
    function IdCondicaoPagamento(Value : Integer) : iEntidadeCondicaoPagamentoItem<T>; overload;
    function IdCondicaoPagamento                  : Integer;                           overload;
    function NumeroPagamento    (Value : Integer) : iEntidadeCondicaoPagamentoItem<T>; overload;
    function NumeroPagamento                      : Integer;                           overload;
    function QuantidadeDias     (Value : Integer) : iEntidadeCondicaoPagamentoItem<T>; overload;
    function QuantidadeDias                       : Integer;                           overload;

    function &End : T;
  end;

implementation

end.
