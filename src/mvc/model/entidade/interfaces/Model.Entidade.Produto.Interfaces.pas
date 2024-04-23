{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 19/03/2024 11:08           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Produto.Interfaces;

interface

type
  iEntidadeProduto<T> = interface
    ['{FAFE6C47-FCAB-4C31-AB1D-A23134816BDA}']
    function Id                   (Value : Integer)   : iEntidadeProduto<T>; overload;
    function Id                                       : Integer;             overload;
    function IdEmpresa            (Value : Integer)   : iEntidadeProduto<T>; overload;
    function IdEmpresa                                : Integer;             overload;
    function IdUsuario            (Value : Integer)   : iEntidadeProduto<T>; overload;
    function IdUsuario                                : Integer;             overload;
    function IdCategoria          (Value : Integer)   : iEntidadeProduto<T>; overload;
    function IdCategoria                              : Integer;             overload;
    function IdUnidade            (Value : Integer)   : iEntidadeProduto<T>; overload;
    function IdUnidade                                : Integer;             overload;
    function Gtin                 (Value : String)    : iEntidadeProduto<T>; overload;
    function Gtin                                     : String;              overload;
    function cEanTrib             (Value : String)    : iEntidadeProduto<T>; overload;
    function cEanTrib                                 : String;              overload;
    function cEan                 (Value : String)    : iEntidadeProduto<T>; overload;
    function cEan                                     : String;              overload;
    function NomeProduto          (Value : String)    : iEntidadeProduto<T>; overload;
    function NomeProduto                              : String;              overload;
    function NCM                  (Value : integer)   : iEntidadeProduto<T>; overload;
    function NCM                                      : Integer;             overload;
    function ValorCusto           (Value : Currency)  : iEntidadeProduto<T>; overload;
    function ValorCusto                               : Currency;            overload;
    function AliquotaLucro        (Value : Currency)  : iEntidadeProduto<T>; overload;
    function AliquotaLucro                            : Currency;            overload;
    function ValorVendaGelado     (Value : Currency)  : iEntidadeProduto<T>; overload;
    function ValorVendaGelado                         : Currency;            overload;
    function ValorVendaNatural    (Value : Currency)  : iEntidadeProduto<T>; overload;
    function ValorVendaNatural                        : Currency;            overload;
    function ValorVendaPromocional(Value : Currency)  : iEntidadeProduto<T>; overload;
    function ValorVendaPromocional                    : Currency;            overload;
    function EstoqueAnterior      (Value : Currency)  : iEntidadeProduto<T>; overload;
    function EstoqueAnterior                          : Currency;            overload;
    function EstoqueMaximo        (Value : Currency)  : iEntidadeProduto<T>; overload;
    function EstoqueMaximo                            : Currency;            overload;
    function EstoqueMinimo        (Value : Currency)  : iEntidadeProduto<T>; overload;
    function EstoqueMinimo                            : Currency;            overload;
    function EstoqueAtual         (Value : Currency)  : iEntidadeProduto<T>; overload;
    function EstoqueAtual                             : Currency;            overload;
    function Origem               (Value : Integer)   : iEntidadeProduto<T>; overload;
    function Origem                                   : Integer;             overload;
    function Volume               (Value : Integer)   : iEntidadeProduto<T>; overload;
    function Volume                                   : Integer;             overload;
    function QuantidadeEmbalagem  (Value : Integer)   : iEntidadeProduto<T>; overload;
    function QuantidadeEmbalagem                      : Integer;             overload;
    function Balanca              (Value : Integer)   : iEntidadeProduto<T>; overload;
    function Balanca                                  : Integer;             overload;
    function PesoLiquido          (Value : Currency)  : iEntidadeProduto<T>; overload;
    function PesoLiquido                              : Currency;            overload;
    function PesoBruto            (Value : Currency)  : iEntidadeProduto<T>; overload;
    function PesoBruto                                : Currency;            overload;
    function DataHoraEmissao      (Value : TDateTime) : iEntidadeProduto<T>; overload;
    function DataHoraEmissao                          : TDateTime;           overload;
    function Ativo                (Value : Integer)   : iEntidadeProduto<T>; overload;
    function Ativo                                    : Integer;             overload;

    function &End : T;
  end;

implementation

end.
