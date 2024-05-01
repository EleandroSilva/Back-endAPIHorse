{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 22/04/2024 11:12           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Condicao.Pagamento.Interfaces;

interface

type
  iEntidadeCondicaoPagamento<T> = interface
    ['{45D63033-35E5-4FF1-8216-555B92137C8F}']
    function Id                   (Value : Integer)   : iEntidadeCondicaoPagamento<T>; overload;
    function Id                                       : Integer;                       overload;
    function IdEmpresa            (Value : Integer)   : iEntidadeCondicaoPagamento<T>; overload;
    function IdEmpresa                                : Integer;                       overload;
    function IdUsuario            (Value : Integer)   : iEntidadeCondicaoPagamento<T>; overload;
    function IdUsuario                                : Integer;                       overload;
    function NomeCondicaoPagamento(Value : String)    : iEntidadeCondicaoPagamento<T>; overload;
    function NomeCondicaoPagamento                    : String;                        overload;
    function QuantidadePagamento  (Value : Integer)   : iEntidadeCondicaoPagamento<T>; overload;
    function QuantidadePagamento                      : Integer;                       overload;
    function TotalDias            (Value : Integer)   : iEntidadeCondicaoPagamento<T>; overload;
    function TotalDias                                : Integer;                       overload;
    function PrazoMedio           (Value : Integer)   : iEntidadeCondicaoPagamento<T>; overload;
    function PrazoMedio                               : Integer;                       overload;
    function DataHoraEmissao      (Value : TDateTime) : iEntidadeCondicaoPagamento<T>; overload;
    function DataHoraEmissao                          : TDateTime;                     overload;

    function &End : T;
  end;

implementation

end.
