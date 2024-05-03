{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 25/04/2024 20:00           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Entidade.Swagger.Pedido.Item;

interface

uses
  GBSwagger.Model.Attributes;

type
  TPedidoItem = class
    private
      FId                : Integer;
      FIdPedido          : Integer;
      FIdProduto         : Integer;
      FQuantidade        : Currency;
      FValorUnitario     : Currency;
      FValorProduto      : Currency;
      FValorDescontoItem : Currency;
      FValorFinalItem    : Currency;
    public
      [SwagIgnore]
      property id                : Integer  read FId                write FId;
      [SwagProp('API cuida desta coluna; FOREIGN KEY Tabela->pedido id-idpedido', True)]
      property idpedido          : Integer  read FIdPedido          write FIdPedido;
      [SwagProp('FOREIGN KEY Tabela->produto id-idproduto', True)]
      property idproduto         : Integer  read FIdProduto         write FIdProduto;
      [SwagProp('Quantidade vendida', True)]
      property quantidade        : Currency read FQuantidade        write FQuantidade;
      [SwagProp('Vem do cadastro do produto, com parâmetro por empresa, se pode ser alterado na hora do pedido', True)]
      property valorunitario     : Currency read FValorUnitario     write FValorUnitario;
      [SwagProp('API faz a soma, qtde*valorunitario', True)]
      property valorproduto      : Currency read FValorProduto      write FValorProduto;
      [SwagProp('quando houver obrigatório usuário informar', True)]
      property valordescontoitem : Currency read FValorDescontoItem write FValorDescontoItem;
      [SwagProp('Cálculo feito pela API', True)]
      property valorfinalitem    : Currency read FValorFinalItem    write FValorFinalItem;
  end;

implementation

end.
