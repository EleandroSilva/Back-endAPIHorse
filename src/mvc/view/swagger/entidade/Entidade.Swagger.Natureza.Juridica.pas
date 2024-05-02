unit Entidade.Swagger.Natureza.Juridica;

interface

uses
  GBSwagger.Model.Attributes;

type
  TNaturezaJuridica = class
    private
      FId                   : Integer;{bigint-Primary Key}
      FNomeNaturezaJuridica : String; {Varchar(60)-> Not Null}
    public
      [SwagProp('PRIMARY KEY (auto_increment)', False)]
      property id                   : Integer read FId                   write FId;
      [SwagProp('Varchar(60)-Not Null', True)]
      property nomenaturezaJuridica : String  read FNomeNaturezaJuridica write FNomeNaturezaJuridica;
  end;

implementation

end.
