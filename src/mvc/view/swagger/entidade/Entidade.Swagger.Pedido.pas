{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 25/04/2024 20:00           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Entidade.Swagger.Pedido;

interface

uses
  GBSwagger.Model.Attributes,
  System.Generics.Collections,
  Entidade.Swagger.Pedido.Item,
  Entidade.Swagger.Pedido.Pagamento;

type
  TPedido = class
    private
      FId              : Integer;
      FIdEmpresa       : Integer;
      FIdCaixa         : Integer;
      FIdPessoa        : Integer;
      FIdCondicaoPagamento : Integer;
      FIdUsuario       : Integer;
      FValorProduto    : Currency;
      FValorDesconto   : Currency;
      FValorReceber    : Currency;
      FValorDescontoItem : Currency;
      FDataHoraEmissao : TDateTime;
      FStatus          : Integer;
      FExcluido        : Boolean;
      FPedidoItem      : TObjectList<TPedidoItem>;
      FPedidoPagamento : TObjectList<TPedidoPagamento>;
    public
      [SwagParamQuery('id', true)]
      [SwagProp('PRIMARY KEY (auto_increment)', True)]
      [SwagProp(False, True)]
      property id              : Integer  read FId               write FId;
      [SwagProp('Foreign Key->Tabela empresa-Id=idempresa Excluír=Cascade; Alterar=Cascade', True)]
      property idempresa       : Integer   read FIdEmpresa       write FIdEmpresa;
      [SwagProp('Foreign Key->Tabela caixa-Id=idcaixa', True)]
      property idCaixa        : Integer   read FIdCaixa          write FIdCaixa;
      [SwagProp('Foreign Key->Tabela pessoa<-Id=idpessoa', True)]
      property idpessoa        : Integer   read FIdPessoa        write FIdPessoa;
      [SwagProp('Foreign Key->Tabela condicaopagamento<-Id=idcondicaopagamento', True)]
      property idcondicaopagamento : Integer   read FIdCondicaoPagamento write FIdCondicaoPagamento;
      [SwagProp('Foreign Key->Tabela (usuario<-Idusuario=id->Tabela usuario))', True)]
      property idusuario       : Integer   read FIdUsuario       write FIdUsuario;
      [SwagProp('Soma da tabela pedidoitem- API Calcula 0,01)', True)]
      property valorproduto    : Currency  read FValorProduto    write FValorProduto;
      [SwagProp('preencher caso houver desconto no final- API Calcula 0,01)', True)]
      property valordesconto   : Currency  read FValorProduto    write FValorProduto;
      [SwagProp('Soma valorproduto-valordesconto=valorreceber - API Calcula 0,01)', True)]
      property valorreceber    : Currency  read FValorProduto    write FValorProduto;
      [SwagProp('Soma valordescontoitem - API Calcula 0,01)', True)]
      property valordescontoitem : Currency  read FValorDescontoItem write FValorDescontoItem;
      [SwagProp('YYYY-MM-DD hh:mm:ss ', True)]
      property datahoraemissao : TDateTime read FDataHoraEmissao write FDataHoraEmissao;
      [SwagProp('0-Pedido como orçamento;1-Pedido faturado;3-Pedido Cancelado ', True)]
      property status          : Integer   read FStatus          write FStatus;
      [SwagProp('true = excluido; false= não excluido ', True)]
      property excluido        : Boolean   read FExcluido          write FExcluido;
      //Injeção de dependência
      property pedidoitem      : TObjectList<TPedidoItem>      read FPedidoItem      write FPedidoItem;
      property pedidopagamento : TObjectList<TPedidoPagamento> read FPedidoPagamento write FPedidoPagamento;
  end;

implementation

end.
