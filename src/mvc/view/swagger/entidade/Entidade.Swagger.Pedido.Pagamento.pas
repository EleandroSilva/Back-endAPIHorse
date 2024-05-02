{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 25/04/2024 20:00           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Entidade.Swagger.Pedido.Pagamento;

interface

uses
  GBSwagger.Model.Attributes;

type
  TPedidoPagamento = class
    private
      FId             : Integer;
      FIdPedido       : Integer;
      FDataVencimento : TDateTime;
      FValorParcela   : Currency;
    public
      [SwagIgnore]
      property id             : Integer   read FID             write FId;
      [SwagProp('FOREIGN KEY Tabela->produto id-idproduto', True)]
      property idpedido       : Integer   read FIdPedido       write FIdPedido;
      [SwagProp,True]
      [SwagProp('YYYY-MM-DD hh:mm:ss'),True]
      property datavencimento : TDateTime read FDataVencimento write FDataVencimento;
      [SwagProp('API faz o parcelamento de acordo com o idpagamento, selecionado', True)]
      property valorparcela   : Currency  read FValorParcela   write FValorParcela;
  end;

implementation

end.
