{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 26/04/2024 17:41           }
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
  Model.Cadastrar.Telefone.Empresa.Interfaces,
  Model.Cadastrar.Pessoa.Interfaces,
  Model.Cadastrar.Email.Pessoa.Interfaces,
  Model.Cadastrar.Telefone.Pessoa.Interfaces,
  Model.Cadastrar.Pedido.Interfaces,
  Model.Cadastrar.Pedido.Item.Interfaces,
  Model.Cadastrar.Pedido.Pagamento.Interfaces,
  Model.Cadastrar.Caixa.Pedido.Interfaces;

type
  iFactoryCadastrar = Interface
    ['{0B168459-6789-4612-A4D8-3227E93A49F8}']
    function CadastrarEmpresa  : iCadastrarEmpresa;
    function CadastrarUsuario  : iCadastrarUsuario;
    function CadastrarEndereco : iCadastrarEndereco;
    function CadastrarNumero   : iCadastrarNumero;
    function CadastrarEnderecoEmpresa : iCadastrarEnderecoEmpresa;
    function CadastrarEmailEmpresa    : iCadastrarEmailEmpresa;
    function CadastrarTelefoneEmpresa : iCadastrarTelefoneEmpresa;
    function CadastrarPessoa          : iCadastrarPessoa;
    function CadastrarEmailPessoa     : iCadastrarEmailPessoa;
    function CadastrarTelefonePessoa  : iCadastrarTelefonePessoa;
    function CadastrarPedido          : iCadastrarPedido;
    function CadastrarPedidoItem      : iCadastrarPedidoItem;
    function CadastrarPedidoPagamento : iCadastrarPedidoPagamento;
    function CadastrarCaixaPedido     : iCadastrarCaixaPedido;
  End;

implementation

end.
