{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 22/04/2024 11:12           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Fechar.Caixa.Interfaces;

interface

uses
  Model.Entidade.Usuario.Interfaces;

type
  iEntidadeFecharCaixa<T> = interface
    ['{7895FB5B-D1A2-4CEF-9041-0732D2CD8558}']
    function Id              (Value : Integer)   : iEntidadeFecharCaixa<T>; overload;
    function Id                                  : Integer;                 overload;
    function IdCaixa         (Value : Integer)   : iEntidadeFecharCaixa<T>; overload;
    function IdCaixa                             : Integer;                 overload;
    function IdUsuario       (Value : Integer)   : iEntidadeFecharCaixa<T>; overload;
    function IdUsuario                           : Integer;                 overload;
    function ValorLancado    (Value : Currency)  : iEntidadeFecharCaixa<T>; overload;
    function ValorLancado                        : Currency;                overload;
    function DataHoraEmissao (Value : TDateTime) : iEntidadeFecharCaixa<T>; overload;
    function DataHoraEmissao                     : TDateTime;               overload;
    function Observacao      (Value : String)    : iEntidadeFecharCaixa<T>; overload;
    function Observacao                          : String;                  overload;

    //Injeção de dependência
    function Usuario  : iEntidadeUsuario<iEntidadeFecharCaixa<T>>;

    function &End : T;
  end;

implementation

end.
