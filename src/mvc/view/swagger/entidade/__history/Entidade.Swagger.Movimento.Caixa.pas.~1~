{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{            Início do projeto 24/04/2024               }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2023                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Tabela.Swagger.Movimento.Caixa;

interface

uses
  GBSwagger.Model.Attributes;

type
  TMovimentoCaixa = class
    private
      FId               : Integer;
      FIdCaixa          : Integer;
      FIdPedido         : Integer;
      FIdFormaPagamento : Integer;
      FIdUsuario        : Integer;
      FValorlancado     : Currency;
      FCreditoDebito    : String;
      FDataHoraEmissao  : TDateTime;
      FTipoLancamento   : String;
    public
      [SwagProp('PRIMARY KEY (auto_increment)', True, False)]
      property id              : Integer   read FId              write FId;
      [SwagProp('FOREIGN KEY Tabela caixa->id=idcaixa->Tabela movimentocaixa',True)]
      property idcaixa         : Integer   read FIdCaixa         write FIdCaixa;
      [SwagProp('FOREIGN KEY Tabela pedido->id=idPedido->Tabela movimentocaixa',True)]
      property idpedido        : Integer   read FIdPedido         write FIdPedido;
      [SwagProp('FOREIGN KEY Tabela formapagamento->id=idformapagamento->Tabela movimentocaixa',True)]
      property idformapagamento: Integer   read FIdFormaPagamento write FIdFormaPagamento;
      [SwagProp('FOREIGN KEY Tabela usuario->id=idusuario->Tabela caixadiario',True)]
      property idusuario       : Integer   read FIdUsuario       write FIdUsuario;
      [SwagProp('Valor lançado', True)]
      property valorlancado    : Currency  read FValorLancado    write FValorLancado;
      [SwagProp('char(1) C=Crédito; D=Débito', True)]
      property creditodebito   : String  read FCreditoDebito   write FCreditoDebito;
      [SwagProp('Data que esta encerrando o caixa', True)]
      property datahoraemissao : TDateTime read FDataHoraEmissao write FDataHoraEmissao;
      [SwagProp('Será preenchido pela API', True)]
      property tipolancamento  : String    read FTipoLancamento  write FTipoLancamento;
  end;

implementation

end.
