unit Model.Factory.Imp.Pesquisar;

interface

uses
  Model.Factory.Pesquisar.Interfaces,
  Model.Pesquisar.Empresa.Interfaces,
  Model.Pesquisar.Endereco.Empresa.Interfaces,
  Model.Pesquisar.Email.Empresa.Interfaces,
  Model.Pesquisar.Endereco.Interfaces,
  Model.Pesquisar.Numero.Interfaces,
  Model.Pesquisar.Telefone.Empresa.Interfaces,
  Model.Pesquisar.Usuario.Interfaces;



type
  TFactoryPesquisar = class(TInterfacedObject, iFactoryPesquisar)
    private
      FPesquisarEmpresa         : iPesquisarEmpresa;
      FPesquisarEnderecoEmpresa : iPesquisarEnderecoEmpresa;
      FPesquisarEmailEmpresa    : iPesquisarEmailEmpresa;
      FPesquisarEndereco        : iPesquisarEndereco;
      FPesquisarNumero          : iPesquisarNumero;
      FPesquisarTelefoneEmpresa : iPesquisarTelefoneEmpresa;
      FPesquisarUsuario         : iPesquisarUsuario;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iFactoryPesquisar;

      function PesquisarEmpresa         : iPesquisarEmpresa;
      function PesquisarEnderecoEmpresa : iPesquisarEnderecoEmpresa;
      function PesquisarEmailEmpresa    : iPesquisarEmailEmpresa;
      function PesquisarEndereco        : iPesquisarEndereco;
      function PesquisarNumero          : iPesquisarNumero;
      function PesquisarTelefoneEmpresa : iPesquisarTelefoneEmpresa;
      function PesquisarUsuario         : iPesquisarUsuario;
  end;

implementation

uses
  Model.Imp.Pesquisar.Empresa,
  Model.Imp.Pesquisar.Endereco.Empresa,
  Model.Imp.Pesquisar.Email.Empresa,
  Model.Imp.Pesquisar.Endereco,
  Model.Pesquisar.Numero,
  Model.Pesquisar.Telefone.Empresa,
  Model.Pesquisar.Usuario;

{ TFactoryPesquisar }

constructor TFactoryPesquisar.Create;
begin
  //
end;

destructor TFactoryPesquisar.Destroy;
begin
  inherited;
end;

class function TFactoryPesquisar.New: iFactoryPesquisar;
begin
  Result := Self.Create;
end;

function TFactoryPesquisar.PesquisarEmpresa: iPesquisarEmpresa;
begin
  if not Assigned(FPesquisarEmpresa) then
    FPesquisarEmpresa := TPesquisarEmpresa.New;

  Result := FPesquisarEmpresa;
end;

function TFactoryPesquisar.PesquisarEnderecoEmpresa: iPesquisarEnderecoEmpresa;
begin
  if not Assigned(FPesquisarEnderecoEmpresa) then
    FPesquisarEnderecoEmpresa := TPesquisarEnderecoEmpresa.New;

  Result := FPesquisarEnderecoEmpresa;
end;

function TFactoryPesquisar.PesquisarEmailEmpresa: iPesquisarEmailEmpresa;
begin
  if not Assigned(FPesquisarEmailEmpresa) then
    FPesquisarEmailEmpresa := TPesquisarEmailEmpresa.New;

  Result := FPesquisarEmailEmpresa;
end;

function TFactoryPesquisar.PesquisarEndereco: iPesquisarEndereco;
begin
  if not Assigned(FPesquisarEndereco) then
    FPesquisarEndereco := TPesquisarEndereco.New;

  Result := FPesquisarEndereco;
end;

function TFactoryPesquisar.PesquisarNumero: iPesquisarNumero;
begin
  if not Assigned(FPesquisarNumero) then
    FPesquisarNumero := TPesquisarNumero.New;

  Result := FPesquisarNumero;
end;

function TFactoryPesquisar.PesquisarTelefoneEmpresa: iPesquisarTelefoneEmpresa;
begin
  if not Assigned(FPesquisarTelefoneEmpresa) then
    FPesquisarTelefoneEmpresa := TPesquisarTelefoneEmpresa.New;

  Result := FPesquisarTelefoneEmpresa;
end;

function TFactoryPesquisar.PesquisarUsuario: iPesquisarUsuario;
begin
  if not Assigned(FPesquisarUsuario) then
    FPesquisarUsuario := TPesquisarUsuario.New;

  Result := FPesquisarUsuario;
end;

end.