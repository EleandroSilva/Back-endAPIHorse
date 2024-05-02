{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{            Início do projeto 09/04/2024               }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2023                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Entidade.Swagger.Endereco.Pessoa;

interface

uses
  GBSwagger.Model.Attributes;

//Tabela com relacionamento com a tabela endereco <-Id=IdEndereco->tabela enderecoempresa
//                                tabela empresa  <-Id=IdEmpresa ->tabela enderecoempresa

type
  TEnderecoPessoa = class
    private
      FId         : Integer;{bigint->Primary Key}
      FIdEndereco : Integer;{bigint-> Foreign Key->Tabela enderecopessoa(Id)-Excluír=Cascade; Alterar=Cascade}
      FIdEmpresa  : Integer;{bigint-> Foreign Key->Tabela Empresa(Id)-Excluír=Cascade; Alterar=Cascade}
      FIdPessoa   : Integer;{bigint-> Foreign Key->Tabela Pessoa(Id)-Excluír=Cascade; Alterar=Cascade}
    public
      [SwagProp('PRIMARY KEY (auto_increment)', False)]
      property id         : Integer read FId         write FId;
      [SwagProp('Foreign Key->Tabela (enderecopessoa<-Idempresa=id->Tabela empresa)) Excluír=Cascade; Alterar=Cascade', True)]
      property idempresa  : Integer read FIdEmpresa  write FIdEmpresa;
      [SwagProp('Foreign Key->Tabela (enderecopessoa<-Id=idendereco->Tabela enderecopessoa)) Excluír=Cascade; Alterar=Cascade', True)]
      property idendereco : Integer read FIdEndereco write FIdEndereco;
      [SwagProp('Foreign Key->Tabela (enderecopessoa<-Idpessoa=id->Tabela pessoa)) Excluír=Cascade; Alterar=Cascade', True)]
      property idpessoa   : Integer read FIdPessoa   write FIdPessoa;
  end;

implementation

end.
