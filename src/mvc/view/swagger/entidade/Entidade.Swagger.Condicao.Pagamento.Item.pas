{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 24/04/2024 10:13           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2023                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Entidade.Swagger.Condicao.Pagamento.Item;

interface

uses
  GBSwagger.Model.Attributes;

type
  TCondicaoPagamentoItem = class
    private
      FId                  : Integer;
      FIdCondicaoPagamento : Integer;
      FNumeroPagamento     : Integer;
      FQuantidadeDias      : Integer;
    public
      [SwagIgnore]
      [SwagProp('PRIMARY KEY (auto_increment)', False, False)]
      property id                  : Integer read FId                  write FId;
      [SwagProp('FOREIGN KEY Tabela condicaopagamento->id=idcondicaopagamento -API Preencher� esta coluna',True, False)]
      property idcondicaopagamento : Integer read FIdCondicaoPagamento write FIdCondicaoPagamento;
      [SwagProp('N�mero do pagamento, API Preencher� esta coluna,True', True)]
      property numeropagamento     : Integer read FNumeroPagamento     write FNumeroPagamento;
      [SwagProp('Quantidade de dias da parcela-> exemplo caso a parcela 1 for 30 dias preencher 30 e assim por diante', True)]
      property quantidadedias      : Integer read FQuantidadeDias      write FQuantidadeDias;
  end;

implementation

end.
