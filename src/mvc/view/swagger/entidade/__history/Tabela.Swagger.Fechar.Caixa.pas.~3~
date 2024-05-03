unit Tabela.Swagger.Fechar.Caixa;

interface

type
  TFecharCaixa = class
    private
      FId              : Integer;
      FIdCaixa         : Integer;
      FIdUsuario       : Integer;
      FValorlancado    : Currency;
      FDataHoraEmissao : TDateTime;
      Fobservacao      : String;
    public
      [SwagProp('PRIMARY KEY (auto_increment)', True, False)]
      property id              : Integer   read FId              write FId;
      [SwagProp('FOREIGN KEY Tabela caixadiario->id=idcaixadiario->Tabela caixadiarioencerramento',True)]
      property idcaixa         : Integer   read FIdCaixa         write FIdCaixa;
      [SwagProp('FOREIGN KEY Tabela usuario->id=idusuario->Tabela caixadiario',True)]
      property idusuario       : Integer   read FIdUsuario       write FIdUsuario;
      [SwagProp('Valor troco', True)]
      property valorlancado    : Currency  read FValorLancado    write FValorLancado;
      [SwagProp('Data que esta encerrando o caixa', True)]
      property datahoraemissao : TDateTime read FDataHoraEmissao write FDataHoraEmissao;
      [SwagProp('Não obrigatório', False)]
      property observacao      : String    read FObservacao      write FObservacao;
  end;

implementation

end.
