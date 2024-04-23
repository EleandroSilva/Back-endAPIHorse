unit Tabela.Swagger.Caixa;

interface

type
  TCaixa = class
    private
      FId              : Integer;
      FIdEmpresa       : Integer;
      FIdUsuario       : Integer;
      FValorInicial    : Currency;
      FDataHoraEmissao : TDateTime;
      FStatus          : String;
    public
      [SwagProp('PRIMARY KEY (auto_increment)', True, False)]
      property id              : Integer   read FId              write FId;
      [SwagProp('FOREIGN KEY Tabela empresa->id=idempresa->Tabela caixadiario',True)]
      property idempresa       : Integer   read FIdEmpresa       write FIdEmpresa;
      [SwagProp('FOREIGN KEY Tabela usuario->id=idusuario->Tabela caixadiario',True)]
      property idusuario       : Integer   read FIdUsuario       write FIdUsuario;
      [SwagProp('Valor troco', True)]
      property valorinicial    : Currency  read FValorInicial    write FValorInicial;
      [SwagProp('Data Abertura', True)]
      property datahoraemissao : TDateTime read FDataHoraEmissao write FDataHoraEmissao;
      [SwagProp('Já vem com A-Aberto', True)]
      property status          : String    read FStatus          write FStatus;
  end;

implementation

end.
