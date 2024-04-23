{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 22/04/2024 11:12           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Caixa.Interfaces;

interface

uses
  Model.Entidade.Usuario.Interfaces;

type
  iEntidadeCaixa<T> = interface
    ['{20798A26-E449-405D-9658-06C0034CAC46}']
    function Id             (Value : Integer)   : iEntidadeCaixa<T>; overload;
    function Id                                 : Integer;                 overload;
    function IdEmpresa      (Value : Integer)   : iEntidadeCaixa<T>; overload;
    function IdEmpresa                          : Integer;                 overload;
    function IdUsuario      (Value : Integer)   : iEntidadeCaixa<T>; overload;
    function IdUsuario                          : Integer;                 overload;
    function ValorInicial   (Value : Currency)  : iEntidadeCaixa<T>; overload;
    function ValorInicial                       : Currency;                overload;
    function DataHoraEmissao(Value : TDateTime) : iEntidadeCaixa<T>; overload;
    function DataHoraEmissao                    : TDateTime;               overload;
    function Status         (Value : String)    : iEntidadeCaixa<T>; overload;
    function Status                             : String;                  overload;

    //Injeção de dependência
    function Usuario  : iEntidadeUsuario<iEntidadeCaixa<T>>;

    function &End : T;
  end;


implementation

end.
