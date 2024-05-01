unit Model.Factory.Imp.Deletar;

interface

uses
  Model.Factory.Deletar.Interfaces,
  Model.Deletar.Empresa.Interfaces;

type
  TFactoryDeletar = class(TInterfacedObject, iFactoryDeletar)
    private
      FDeletarEmpresa : iDeletarEmpresa;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iFactoryDeletar;

      function DeletarEmpresa : iDeletarEmpresa;
  end;

implementation

uses
  Model.Imp.Deletar.Empresa;

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

end.
