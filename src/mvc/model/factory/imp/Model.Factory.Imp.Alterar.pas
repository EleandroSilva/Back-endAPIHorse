{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 30/04/2024 21:49           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Factory.Imp.Alterar;

interface

uses
  Model.Factory.Alterar.Interfaces,
  Model.Alterar.Empresa.Interfaces,
  Model.Alterar.Email.Empresa.Interfaces,
  Model.Alterar.Telefone.Empresa.Interfaces,
  Model.Alterar.Endereco.Interfaces,
  Model.Alterar.Numero.Interfaces,
  Model.Alterar.Usuario.Interfaces,
  Model.Alterar.Pessoa.Interfaces,
  Model.Alterar.Email.Pessoa.Interfaces,
  Model.Alterar.Telefone.Pessoa.Interfaces,
  Model.Alterar.Pedido.Interfaces,
  Model.Alterar.Pedido.Item.Interfaces,
  Model.Alterar.Pedido.Pagamento.Interfaces;

type
  TFactoryAlterar = class(TInterfacedObject, iFactoryAlterar)
    private
      FAlterarEmpresa         : iAlterarEmpresa;
      FAlterarEmailEmpresa    : iAlterarEmailEmpresa;
      FAlterarTelefoneEmpresa : iAlterarTelefoneEmpresa;
      FAlterarEndereco        : iAlterarEndereco;
      FAlterarNumero          : iAlterarNumero;
      FAlterarUsuario         : iAlterarUsuario;
      FAlterarPessoa          : iAlterarPessoa;
      FAlterarEmailPessoa     : iAlterarEmailPessoa;
      FAlterarTelefonePessoa  : iAlterarTelefonePessoa;
      FAlterarPedido          : iAlterarPedido;
      FAlterarPedidoItem      : iAlterarPedidoItem;
      FAlterarPedidoPagamento : iAlterarPedidoPagamento;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iFactoryAlterar;

      function AlterarEmpresa         : iAlterarEmpresa;
      function AlterarEmailEmpresa    : iAlterarEmailEmpresa;
      function AlterarTelefoneEmpresa : iAlterarTelefoneEmpresa;
      function AlterarEndereco        : iAlterarEndereco;
      function AlterarNumero          : iAlterarNumero;
      function AlterarUsuario         : iAlterarUsuario;
      function AlterarPessoa          : iAlterarPessoa;
      function AlterarEmailPessoa     : iAlterarEmailPessoa;
      function AlterarTelefonePessoa  : iAlterarTelefonePessoa;
      function AlterarPedido          : iAlterarPedido;
      function AlterarPedidoItem      : iAlterarPedidoItem;
      function AlterarPedidoPagamento : iAlterarPedidoPagamento;
  end;

implementation

uses
  Model.Imp.Alterar.Empresa,
  Model.Imp.Alterar.Email.Empresa,
  Model.Imp.Alterar.Telefone.Empresa,
  Model.Imp.Alterar.Endereco,
  Model.Imp.Alterar.Numero,
  Model.Imp.Alterar.Usuario,
  Model.Imp.Alterar.Email.Pessoa,
  Model.Imp.Alterar.Pessoa,
  Model.Imp.Alterar.Telefone.Pessoa,
  Model.Imp.Alterar.Pedido,
  Model.Imp.Alterar.Pedido.Item,
  Model.Imp.Alterar.Pedido.Pagamento;

{ TFactoryAlterar }

constructor TFactoryAlterar.Create;
begin
  //
end;

destructor TFactoryAlterar.Destroy;
begin
  inherited;
end;

class function TFactoryAlterar.New: iFactoryAlterar;
begin
  Result := Self.Create;
end;



function TFactoryAlterar.AlterarEmpresa: iAlterarEmpresa;
begin
  if not Assigned(FAlterarEmpresa) then
    FAlterarEmpresa := TAlterarEmpresa.New;

  Result := FAlterarEmpresa;
end;

function TFactoryAlterar.AlterarEmailEmpresa: iAlterarEmailEmpresa;
begin
  if not Assigned(FAlterarEmailEmpresa) then
    FAlterarEmailEmpresa := TAlterarEmailEmpresa.New;

  Result := FAlterarEmailEmpresa;
end;

function TFactoryAlterar.AlterarTelefoneEmpresa: iAlterarTelefoneEmpresa;
begin
  if not Assigned(FAlterarTelefoneEmpresa) then
    FAlterarTelefoneEmpresa := TAlterarTelefoneEmpresa.New;

  Result := FAlterarTelefoneEmpresa;
end;

function TFactoryAlterar.AlterarEndereco: iAlterarEndereco;
begin
  if not Assigned(FAlterarEndereco) then
    FAlterarEndereco := TAlterarEndereco.New;

  Result := FAlterarEndereco;
end;

function TFactoryAlterar.AlterarNumero: iAlterarNumero;
begin
  if not Assigned(FAlterarNumero) then
    FAlterarNumero := TAlterarNumero.New;

  Result := FAlterarNumero;
end;

function TFactoryAlterar.AlterarUsuario: iAlterarUsuario;
begin
  if not Assigned(FAlterarUsuario) then
    FAlterarUsuario := TAlterarUsuario.New;

  Result := FAlterarUsuario;
end;

function TFactoryAlterar.AlterarPessoa: iAlterarPessoa;
begin
  if not Assigned(FAlterarPessoa) then
    FAlterarPessoa := TAlterarPessoa.New;

  Result := FAlterarPessoa;
end;

function TFactoryAlterar.AlterarTelefonePessoa: iAlterarTelefonePessoa;
begin
  if not Assigned(FAlterarTelefonePessoa) then
    FAlterarTelefonePessoa := TAlterarTelefonePessoa.New;

  Result := FAlterarTelefonePessoa;
end;

function TFactoryAlterar.AlterarEmailPessoa: iAlterarEmailPessoa;
begin
  if not Assigned(FAlterarEmailPessoa) then
    FAlterarEmailPessoa := TAlterarEmailPessoa.New;

  Result := FAlterarEmailPessoa;
end;

function TFactoryAlterar.AlterarPedido: iAlterarPedido;
begin
  if not Assigned(FAlterarPedido) then
    FAlterarPedido := TAlterarPedido.New;

  Result := FAlterarPedido;
end;

function TFactoryAlterar.AlterarPedidoItem: iAlterarPedidoItem;
begin
  if not Assigned(FAlterarPedidoItem) then
    FAlterarPedidoItem := TAlterarPedidoItem.New;

  Result := FAlterarPedidoItem;
end;

function TFactoryAlterar.AlterarPedidoPagamento: iAlterarPedidoPagamento;
begin
  if not Assigned(FAlterarPedidoPagamento) then
    FAlterarPedidoPagamento := TAlterarPedidoPagamento.New;

  Result := FAlterarPedidoPagamento;
end;

end.
