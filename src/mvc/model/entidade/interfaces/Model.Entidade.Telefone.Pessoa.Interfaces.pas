{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 03/04/2024 13:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2004/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Telefone.Pessoa.Interfaces;

interface

type
  iEntidadeTelefonePessoa<T> = interface
    ['{1D03E283-1D1F-46A4-B087-5F9EE908B24E}']
    function Id          (Value : Integer)  : iEntidadeTelefonePessoa<T>; overload;
    function Id                             : Integer;                    overload;
    function IdPessoa    (Value : Integer)  : iEntidadeTelefonePessoa<T>; overload;
    function IdPessoa                       : Integer;                    overload;
    function IdEmpresa   (Value : Integer)  : iEntidadeTelefonePessoa<T>; overload;
    function IdEmpresa                      : Integer;                    overload;
    function Operadora   (Value : String)   : iEntidadeTelefonePessoa<T>; overload;
    function Operadora                      : String;                     overload;
    function DDD         (Value : String)   : iEntidadeTelefonePessoa<T>; overload;
    function DDD                            : String;                     overload;
    function NumeroTelefone(Value : String) : iEntidadeTelefonePessoa<T>; overload;
    function NumeroTelefone                 : String;                     overload;
    function TipoTelefone  (Value : String) : iEntidadeTelefonePessoa<T>; overload;
    function TipoTelefone                   : String;                     overload;
    function Ativo         (Value : Integer): iEntidadeTelefonePessoa<T>; overload;
    function Ativo                          : Integer;                    overload;

    function &End : T;
  end;


implementation

end.
