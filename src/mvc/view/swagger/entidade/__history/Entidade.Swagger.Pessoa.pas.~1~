{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{            Início do projeto 09/04/2024               }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2023                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Tabela.Swagger.Pessoa;

interface

uses
  GBSwagger.Model.Attributes,
  System.Generics.Collections,
  Tabela.Swagger.Endereco,
  Tabela.Swagger.Numero,
  Tabela.Swagger.Email.Pessoa,
  Tabela.Swagger.Telefone.Pessoa,
  Tabela.Swagger.Natureza.Juridica;

//Tabela que salva pessoa(Cliente-Fornecedor-Transportes-Ambos)
type
  TPessoa = class
    private
      FId              : Integer;{bigint-Primary Key}
      FIdEmpresa       : Integer;{bigint-> Foreign Key->Tabela Empresa(Id)-Excluír=Cascade; Alterar=Cascade}
      FIdUsuario       : Integer;
      FCPFCNPJ         : String; {Varchar(20)->  Salvar CPF ou CNPJ(Coluna FisicaJurica quem define) Unique Key-Not Null}
      FRGIE            : String; {Varchar(20)->  Salvar RG ou Inscrição Estadual(Caso não tenha(ISENTO))(Coluna FisicaJurica quem define)}
      FNomePessoa      : String; {Varchar(120)-> Not Null}
      FSobreNome       : String; {Varchar(120)}
      FTipoPessoa      : String; {Char(1)->A - Ambos; C - Clientes; F - Fornecedor; T - Transporte}
      FFisicaJuridica  : String; {Char(1)-> F- Física; J-Júridica}
      FSexo            : String; {Char(1)-  M-Masculino; F-Feminino->Not Null}
      FDataHoraEmissao : TDate;  {TDate-Data que foi cadastrada no sistema-Not Null}
      FDataNascimento  : TDate;  {TDate-Data nascimento}
      FAtivo           : Integer;{Integer->0-Inativo; 1-Ativo-Not Null}
      FEndereco        : TObjectList<TEndereco>;//crio a classe endereco
      FNumero          : TObjectList<TNumero>;
      FEMailPessoa     : TObjectList<TEmailPessoa>;//crio a classe emailempresa
      FTelefonePessoa  : TObjectList<TTelefonePessoa>;
    public
      [SwagParamQuery('id', true)]
      [SwagProp('PRIMARY KEY (auto_increment)', True)]
      [SwagProp(False, True)]
      property id             : Integer read FId             write FId;
      [SwagProp(True)]
      property idEmpresa      : Integer read FIdEmpresa      write FIdEmpresa;
      [SwagProp(True)]
      property idUsuario      : Integer read FIdUsuario      write FIdUsuario;
      [SwagProp('Varchar(18) Max18-Min18->Formato CPF 999.999.999-99 ou CNPJ 99.999.999/9999-99', True)]
      property cpfcnpj        : String  read FCPFCNPJ        write FCPFCNPJ;
      [SwagProp('Varchar(20) RG - Pessoa Física Inscrição Estadual-Pessoa Jurídica Caso não existir informar em maiúsculo (ISENTO)', True)]
      property rgie           : String  read FRGIE           write FRGIE;
      [SwagProp('Varchar(120) Max120-Min20->Nome da pessoa Not Null', True)]
      property nomepessoa     : String  read FNomePessoa     write FNomePessoa;
      [SwagProp('Varchar(120) Max120-Min20->Sobre Nome da pessoa Not Null', True)]
      property sobrenome      : String  read FSobreNome      write FSobreNome;
      [SwagProp('char(1) Max1-Min1->A - Ambos;C - Clientes;F - Fornecedor Not Null', True)]
      property tipopessoa     : String  read FTipoPessoa     write FTipoPessoa;
      property fisicajuridica : String  read FFisicaJuridica write FFisicaJuridica;
      property sexo           : String  read FSexo           write FSexo;
      [SwagDate('TDate YYYY-MM-DD')]
      [SwagRequired]
      [SwagProp('Data que esta cadastrando a pessoa, not null ', True)]
      property datahoraemissao    : TDate read FDataHoraEmissao write FDataHoraEmissao;
      [SwagDate('TDate YYYY-MM-DD')]
      [SwagRequired]
      [SwagProp('Data de nascimento, not null ', True)]
      property datanascimento : TDate   read FDataNascimento  write FDataNascimento;
      [SwagProp('(0-Intativo ou 1-Ativo)', True)]
      property ativo          : Integer read FAtivo           write FAtivo;
      //campos pertencem a tabela endereco
      property endereco        : TObjectList<TEndereco>       read FEndereco       write FEndereco;
      property numero          : TObjectList<TNumero>         read FNumero         write FNumero;
      //campos tabela email da empresa
      property emailpessoa     : TObjectList<TEmailPessoa>    read FEMailpessoa    write FEmailPessoa;
      //campos tabela telefone da empresa
      property telefonepessoa  : TObjectList<TTelefonePessoa> read FTelefonepessoa write FTelefonePessoa;
  end;

implementation

end.
