{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{            Início do projeto 09/04/2024               }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2023                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Entidade.Swagger.Endereco;

interface

uses
  GBSwagger.Model.Attributes;

type
  TEndereco = class
    private
      FId             : Integer;{bigint-Primary Key}
      FCep            : String; {Varchar(18)->Unique Key-Not Null}
      FIBGE           : Integer;{Integer ->Not Null ->Foreign Key Tabela municipio IBGE; Excluír=Cascade; Alterar=Cascade}
      FUF             : String;
      FTipoLogradouro : String; {Varchar(60)-> Comercial-Residencial-Entrega-Cobranca Not Null}
      FLogradouro     : String; {Varchar(60)-> Not Null}
      FBairro         : String; {Varchar(60)->Not Null}
      FGia            : Integer;
      FDDD            : String;
    public
      [SwagProp('PRIMARY KEY (auto_increment)', True)]
      [SwagIgnore]
      property id             : Integer read FId              write FId;
      [SwagProp(True)]
      property cep            : String  read FCep             write FCep;
      [SwagProp(True)]
      property ibge           : Integer read FIBGE            write FIBGE;
      [SwagProp(True)]
      property uf             : String  read FUF              write FUF;
      [SwagProp(True)]
      property tipologradouro : String  read FTipoLogradouro  write FTipoLogradouro;
      [SwagProp(True)]
      property logradouro     : String  read FLogradouro      write FLogradouro;
      [SwagProp(True)]
      property bairro         : String  read FBairro          write FBairro;
      [SwagProp(True)]
      property gia            : Integer  read FGia            write FGia;
      [SwagProp(True)]
      property ddd            : String  read FDDD             write FDDD;
  end;

implementation

end.
