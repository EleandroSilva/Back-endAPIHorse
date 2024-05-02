{*******************************************************}
{                    API PDV - JSON                     }
{                     Be More Web                       }
{            Início do projeto 09/04/2024               }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2023                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Entidade.Swagger.Unidade.Produto;

//Tabela padrão para todas empresas
interface

uses
  GBSwagger.Model.Attributes;

type
  TUnidadeProduto = class
    private
      FId          : Integer;{bigint-Primary Key}
      FUnidade     : String; {Varchar(5) Unique Key Not Null}
      FNomeUnidade : String; {Varchar(20)-> Unique Key Not Null Not Null}
      FAtivo       : Integer;{Integer 0-Inativo; 1-Ativo}
    public
      [SwagParamQuery('id', true)]
      [SwagProp('PRIMARY KEY (auto_increment)', True)]
      [SwagProp(False, True)]
      property id          : Integer read FId          write FId;
      [SwagProp('Varchar(5)Max5-Min1, Unique Key', True)]
      property unidade     : String  read FUnidade     write FUnidade;
      [SwagProp('Varchar(20)Max20-Min3, Unique Key', True)]
      property nomeunidade : String  read FNomeUnidade write FNomeUnidade;
      [SwagProp('No POST não precisa precher, somente no PUT-Caso se tornar Ativo=0', True)]
      property ativo       : Integer read FAtivo       write FAtivo;
  end;

implementation

end.
