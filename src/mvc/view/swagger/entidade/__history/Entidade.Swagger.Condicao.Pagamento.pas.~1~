{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 24/04/2024 09:57           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2023                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Tabela.Swagger.Condicao.Pagamento;

interface

uses
  GBSwagger.Model.Attributes,
  System.Generics.Collections,
  Tabela.Swagger.Condicao.Pagamento.Item;

type
  TCondicaoPagamento = class
    private
      FId                    : Integer;
      FIdEmpresa             : Integer;
      FIdUsuario             : Integer;
      FNomeCondicaoPagamento : String;
      FQuantidadePagamento   : Integer;
      FTotalDias             : Integer;
      FPrazoMedio            : Integer;
      FDataHoraEmissao       : TDateTime;
      FTipoLancamento        : String;
      FCondicaoPagamentoItem : TObjectList<TCondicaoPagamentoItem>;
    public
      [SwagProp('PRIMARY KEY (auto_increment)', True, False)]
      property id                     : Integer   read FId                    write FId;
      [SwagProp('FOREIGN KEY Tabela empresa->id=idempresa ',True)]
      property idempresa              : Integer   read FIdEmpresa             write FIdEmpresa;
      [SwagProp('FOREIGN KEY Tabela usuário->id=idusuario ',True)]
      property idusuario              : Integer   read FIdUsuario             write FIdUsuario;
      [SwagProp('Varchar(60) -Minimo 5 Máximo 60-Exemplo caso condição for 30/60 informe apenas esta descrição 30/60DD', True)]
      property nomecondicaopagamento  : String    read FNomeCondicaoPagamento write FNomeCondicaoPagamento;
      [SwagProp('qtde de parcelas no geral-Exemplo caso esta condição for dividir em 2 parcela informa 2, se for 3 informar 3', True)]
      property quantidadepagamento    : Integer   read FQuantidadePagamento   write FQuantidadePagamento;
      [SwagProp('Total dia exemplo 30/60 =90- API Preencherá esta coluna ', True)]
      property totaldias              : Integer   read FTotalDias             write FTotalDias;
      [SwagProp('API Preencherá esta coluna - Exemplo 30/60 =45', True)]
      property prazomedio             : Integer   read FPrazoMedio            write FPrazoMedio;
      [SwagProp('Data do cadastro Now', True)]
      property datahoraemissao        : TDateTime read FDataHoraEmissao       write FDataHoraEmissao;

      //campos tabela condicaopagamentoitem
      property condicaopagamentoitem  : TObjectList<TCondicaoPagamentoItem> read FCondicaoPagamentoItem write FCondicaoPagamentoItem;
  end;

implementation

end.
