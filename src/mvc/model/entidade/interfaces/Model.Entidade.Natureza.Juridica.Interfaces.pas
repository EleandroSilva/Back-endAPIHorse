{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 15/04/2024 15:37           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Natureza.Juridica.Interfaces;

interface

type
  iEntidadeNaturezaJuridica<T> = interface
    ['{360B2824-2FF6-4B29-823D-83DA6D34F7FC}']
    function Id                 (Value : Integer) : iEntidadeNaturezaJuridica<T>; overload;
    function Id                                   : Integer;                      overload;
    function NomeNaturezaJuridica(Value : String) : iEntidadeNaturezaJuridica<T>; overload;
    function NomeNaturezaJuridica                 : String;                       overload;

    function &End : T;
  end;

implementation

end.
