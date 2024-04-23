{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{            Início do projeto 09/04/2024               }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2023                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Tabela.Swagger.Regiao.Estado;

interface

type
  TRegiaoEstado = class
    private
      FId     : Integer;{bigint-Primary Key}
      FRegiao : String; {Varchar(60)}
    public
      property id     : Integer read FId     write FId;
      property regiao : String  read FRegiao write FRegiao;
  end;

implementation

end.
