{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{            Início do projeto 09/04/2024               }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2023                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Tabela.Swagger.Municipio;

interface

uses
  GBSwagger.Model.Attributes;

type
  TMunicipio = class
    private
      FId        : Integer;{bigint-Primary Key}
      FIBGE      : Integer;{Integer)->Unique Key-Not Null}
      FIdEstado  : Integer;{Integer}
      FMunicipio : String; {Varchar(120)-> Not Null}
      FUF        : String; {Varchar(2)}
    public
      property Id        : Integer read FId        write FId;
      property IBGE      : Integer read FIBGE      write FIBGE;
      property IdEstado  : Integer read FIdEstado  write FIdEstado;
      property Municipio : String  read FMunicipio write FMunicipio;
      property UF        : String  read FUF        write FUF;
  end;


implementation

end.
