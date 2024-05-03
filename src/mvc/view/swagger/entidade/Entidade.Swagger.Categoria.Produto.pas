{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{            Início do projeto 09/04/2024               }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2023                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Entidade.Swagger.Categoria.Produto;

interface

uses
  GBSwagger.Model.Attributes;

type
  TCategoriaProduto = class
    private
      FId              : Integer;{bigint-Primary Key}
      FIdEmpresa       : Integer;
      FIdUsuario       : Integer;
      FNomeCategoria   : String; {Varchar(120)-> Not Null}
      FDataHoraEmissao : TDateTime;
      FAtivo           : Integer; {Varchar(2)}
    public
      [SwagParamQuery('id', true)]
      [SwagProp('PRIMARY KEY (auto_increment)', True)]
      [SwagProp(False, True)]
      property id            : Integer read FId            write FId;
      [SwagProp('Foreign Key->Tabela (categoriaproduto<-Idempresa=id->Tabela empresa)) Excluír=Cascade; Alterar=Cascade', True)]
      property idempresa     : Integer read FIdEmpresa     write FIdEmpresa;
      [SwagProp('Foreign Key->Tabela (categoriaproduto<-Idusuario=id->Tabela usuario))', True)]
      property idusuario     : Integer read FIdEmpresa     write FIdEmpresa;
      [Swagpro, true]
      property datahoraemissao : TDateTime read FDataHoraEmissao write FDataHoraEmissao;
      [SwagProp('Varchar(60)Max60-Min10-Unique Key', True)]
      property nomecategoria : String  read FNomeCategoria write FNomeCategoria;
      [SwagProp('No POST não precisa precher, somente no PUT-Caso se tornar Ativo=0', True)]
      property ativo         : Integer read FAtivo         write FAtivo;
  end;

implementation

end.
