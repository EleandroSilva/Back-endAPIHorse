unit Model.Factory.Imp.Deletar;

interface

uses
  Model.Factory.Deletar.Interfaces,
  Model.Deletar.Empresa.Interfaces,
  Model.Deletar.Pessoa.Interfaces;

type
  TFactoryDeletar = class(TInterfacedObject, iFactoryDeletar)
    private
      FDeletarEmpresa : iDeletarEmpresa;
      FDeletarPessoa  : iDeletarPessoa;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iFactoryDeletar;

      function DeletarEmpresa : iDeletarEmpresa;
      function DeletarPessoa  : iDeletarPessoa;
  end;

implementation

uses
  Model.Imp.Deletar.Empresa,
  Model.Deletar.Pessoa;

{ TFactoryDeletar }

constructor TFactoryDeletar.Create;
begin
  //
end;

destructor TFactoryDeletar.Destroy;
begin
  inherited;
end;

class function TFactoryDeletar.New: iFactoryDeletar;
begin
  Result := Self.Create;
end;

function TFactoryDeletar.DeletarEmpresa: iDeletarEmpresa;
begin
  if not Assigned(FDeletarEmpresa) then
    FDeletarEmpresa := TDeletarEmpresa.New;

  Result := FDeletarEmpresa;
end;

function TFactoryDeletar.DeletarPessoa: iDeletarPessoa;
begin
  if not Assigned(FDeletarPessoa) then
    FDeletarPessoa := TDeletarPessoa.New;

  Result := FDeletarPessoa;
end;

end.
