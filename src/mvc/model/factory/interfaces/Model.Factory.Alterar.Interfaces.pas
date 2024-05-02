{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 30/04/2024 21:33           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Factory.Alterar.Interfaces;

interface

uses
  Model.Alterar.Empresa.Interfaces,
  Model.Alterar.Email.Empresa.Interfaces,
  Model.Alterar.Telefone.Empresa.Interfaces,
  Model.Alterar.Endereco.Interfaces,
  Model.Alterar.Numero.Interfaces,
  Model.Alterar.Usuario.Interfaces,
  Model.Alterar.Pessoa.Interfaces,
  Model.Alterar.Email.Pessoa.Interfaces,
  Model.Alterar.Telefone.Pessoa.Interfaces;

type
  iFactoryAlterar = Interface
    ['{08E351DA-D72C-47A6-AECC-87280E5BE683}']
    function AlterarEmpresa         : iAlterarEmpresa;
    function AlterarEmailEmpresa    : iAlterarEmailEmpresa;
    function AlterarTelefoneEmpresa : iAlterarTelefoneEmpresa;
    function AlterarEndereco        : iAlterarEndereco;
    function AlterarNumero          : iAlterarNumero;
    function AlterarUsuario         : iAlterarUsuario;
    function AlterarPessoa          : iAlterarPessoa;
    function AlterarEmailPessoa     : iAlterarEmailPessoa;
    function AlterarTelefonePessoa  : iAlterarTelefonePessoa;
  End;

implementation

end.
