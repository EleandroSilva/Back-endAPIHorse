{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 15/04/2024 15:37           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Numero.Interfaces;

interface

type
  iEntidadeNumero<T> = interface
    ['{3D1B2EA4-DC0B-4607-946C-C17887D9218D}']
    function Id                 (Value : Integer) : iEntidadeNumero<T>; overload;
    function Id                                   : Integer;            overload;
    function IdEndereco         (Value : Integer) : iEntidadeNumero<T>; overload;
    function IdEndereco                           : Integer;            overload;
    function NumeroEndereco     (Value : String)  : iEntidadeNumero<T>; overload;
    function NumeroEndereco                       : String;             overload;
    function ComplementoEndereco(Value : String)  : iEntidadeNumero<T>; overload;
    function ComplementoEndereco                  : String;             overload;

    function &End : T;
  end;

implementation

end.
