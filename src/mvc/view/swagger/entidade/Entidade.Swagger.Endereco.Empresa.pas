{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{            Início do projeto 09/04/2024               }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2023                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Entidade.Swagger.Endereco.Empresa;

interface

uses
  GBSwagger.Model.Attributes;

//Tabela com relacionamento com a tabela endereco <-Id=IdEndereco->tabela enderecoempresa
//                                tabela empresa  <-Id=IdEmpresa ->tabela enderecoempresa

type
  TEnderecoEmpresa = class
    private
      FId         : Integer;{bigint->Primary Key}
      FIdEndereco : Integer;{bigint-> Foreign Key->Tabela endereco(Id)-Excluír=Cascade; Alterar=Cascade}
      FIdEmpresa  : Integer;{bigint-> Foreign Key->Tabela Empresa(Id)-Excluír=Cascade; Alterar=Cascade}
    public
      [SwagProp('PRIMARY KEY (auto_increment)', False)]
      property id         : Integer read FId         write FId;
      [SwagProp('Foreign Key->Tabela (endereco<-Id=idendereco->Tabela enderecoempresa)) Excluír=Cascade; Alterar=Cascade', True)]
      property idendereco : Integer read FIdEndereco write FIdEndereco;
      [SwagProp('Foreign Key->Tabela (endereco<-Idempresa=id->Tabela empresa)) Excluír=Cascade; Alterar=Cascade', True)]
      property idempresa  : Integer read FIdEmpresa  write FIdEmpresa;
  end;

implementation

end.
