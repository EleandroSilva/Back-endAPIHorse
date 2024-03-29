{*******************************************************}
{                    API PDV - JSON                     }
{                      ES Sistemas                      }
{          In�cio do projeto 18/03/2024 13:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Grupo.Produto.Interfaces;

interface

type
  iEntidadeGrupoProduto<T> = interface
    ['{8EAA1FED-0229-492C-B7EB-1FCC725B9C7D}']
    function Id(Value : Integer)        : iEntidadeGrupoProduto<T>; overload;
    function Id                         : Integer;                  overload;
    function IdEmpresa(Value : Integer) : iEntidadeGrupoProduto<T>; overload;
    function IdEmpresa                  : Integer;                  overload;
    function Nome(Value : String)       : iEntidadeGrupoProduto<T>; overload;
    function Nome                       : String;                   overload;
    function Ativo(Value : Integer)     : iEntidadeGrupoProduto<T>; overload;
    function Ativo                      : Integer;                  overload;

    function &End : T;
  end;

implementation

end.
