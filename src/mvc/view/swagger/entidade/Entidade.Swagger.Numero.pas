unit Entidade.Swagger.Numero;

interface

uses
  GBSwagger.Model.Attributes;

type
  TNumero = class
    private
      FId                  : Integer;{bigint->Primary Key}
      FIdEndereco          : Integer;{bigint-> Foreign Key->Tabela endereco(Id)-Excluír=Cascade; Alterar=Cascade}
      FNumeroEndereco      : String;{|Varchar(10)->Mot Null }
      FComplementoEndereco : String;
    public
      [SwagProp('PRIMARY KEY (auto_increment)', True, False)]
      property id                  : Integer read FId                  write FId;
      [SwagProp('FOREIGN KEY - Tabela(endereco<-id=idendereco->Tabela numero)Excluír=Cascade; Alterar=Cascade', True)]
      property idendereco          : Integer read FIdEndereco          write FIdEndereco;
      [SwagProp(True)]
      property numeroendereco      : String  read FNumeroEndereco      write FNumeroEndereco;
      [SwagProp(False)]
      property complementoendereco : String  read FComplementoEndereco write FComplementoEndereco;
  end;

implementation

end.
