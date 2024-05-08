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
      FIdCondicaoPagamento : Integer;
      FDataVencimento : TDateTime;
      FValorParcela   : Currency;
      FValorReceber : Currency;
    public
      [SwagIgnore]
      property id             : Integer   read FID             write FId;
      [SwagProp('FOREIGN KEY Tabela->pedido id-idpedido', True)]
      property idpedido       : Integer   read FIdPedido       write FIdPedido;
      [SwagProp('FOREIGN KEY Tabela->condicaopagamento id-idcondicaopagamento', True)]
      property idcondicaopagamento : Integer   read FIdCondicaoPagamento write FIdCondicaoPagamento;
      [SwagProp,True]
      [SwagProp('YYYY-MM-DD hh:mm:ss'),True]
      property datavencimento : TDateTime read FDataVencimento write FDataVencimento;
      [SwagProp('API faz o parcelamento de acordo com o idpagamento, selecionado', True)]
      property valorparcela   : Currency  read FValorParcela   write FValorParcela;
      [SwagProp('Valor final do pedido', True)]
      property valorreceber   : Currency  read FValorReceber write FValorReceber;
  end;

implementation

end.
