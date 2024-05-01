{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 26/04/2024 17:41           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Factory.Cadastrar.Interfaces;

interface

uses
  Model.Cadastrar.Empresa.Interfaces,
  Model.Cadastrar.Usuario.Interfaces,
  Model.Cadastrar.Endereco.Interfaces,
  Model.Cadastrar.Numero.Interfaces,
  Model.Cadastrar.Endereco.Empresa.Interfaces,
  Model.Cadastrar.Email.Empresa.Interfaces,
  Model.Cadastrar.Telefone.Empresa.Interfaces;

type
  iFactoryCadastrar = Interface
    ['{AA0EA18A-6CC0-442C-8F61-D8B8740A66CB}']
    function CadastrarEmpresa  : iCadastrarEmpresa;
    function CadastrarUsuario  : iCadastrarUsuario;
    function CadastrarEndereco : iCadastrarEndereco;
    function CadastrarNumero   : iCadastrarNumero;
    function CadastrarEnderecoEmpresa : iCadastrarEnderecoEmpresa;
    function CadastrarEmailEmpresa    : iCadastrarEmailEmpresa;
    function CadastrarTelefoneEmpresa : iCadastrarTelefoneEmpresa;
  End;

implementation

end.