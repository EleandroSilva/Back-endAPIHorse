{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 18/03/2024 13:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Unidade.Produto.Interfaces;

interface

type
  iEntidadeUnidadeProduto<T> = interface
    ['{A9AF512C-E8EB-4153-88A1-C2D51DBF6F20}']
    function Id         (Value : Integer) : iEntidadeUnidadeProduto<T>; overload;
    function Id                           : Integer;                    overload;
    function Unidade    (Value : String)  : iEntidadeUnidadeProduto<T>; overload;
    function Unidade                      : String;                     overload;
    function NomeUnidade(Value : String)  : iEntidadeUnidadeProduto<T>; overload;
    function NomeUnidade                  : String;                     overload;
    function Ativo      (Value : Integer) : iEntidadeUnidadeProduto<T>; overload;
    function Ativo                        : Integer;                    overload;

    function &End : T;
  end;

implementation

end.
