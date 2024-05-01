unit Model.Entidade.Imp.Endereco.Empresa;

interface

uses
  Model.Entidade.Endereco.Empresa.Interfaces,
  Model.Entidade.Endereco.Interfaces,
  Model.Entidade.Numero.Interfaces;

type
  TEntidadeEnderecoEmpresa<T : iInterface> = class(TInterfacedObject, iEntidadeEnderecoEmpresa<T>)
    private
      [weak]
      FParent     : T;
      FId         : Integer;
      FIdEmpresa  : Integer;
      FIdEndereco : Integer;

      FEndereco   : iEntidadeEndereco<iEntidadeEnderecoEmpresa<T>>;//EnderecoEmpresa
      FNumero     : iEntidadeNumero  <iEntidadeEnderecoEmpresa<T>>;//Numero
    public
      constructor Create(Parent : T);
      destructor Destroy; override;
      class function New(Parent : T)       : iEntidadeEnderecoEmpresa<T>;
      function Id        (Value : Integer) : iEntidadeEnderecoEmpresa<T>; overload;
      function Id                          : Integer;                     overload;
      function IdEmpresa (Value : Integer) : iEntidadeEnderecoEmpresa<T>; overload;
      function IdEmpresa                   : Integer;                     overload;
      function IdEndereco(Value : Integer) : iEntidadeEnderecoEmpresa<T>; overload;
      function IdEndereco                  : Integer;                     overload;

      //Injeção de dependência
      function Endereco : iEntidadeEndereco<iEntidadeEnderecoEmpresa<T>>;
      function Numero   : iEntidadeNumero<iEntidadeEnderecoEmpresa<T>>;

      function &End : T;
  end;

implementation

Uses
  Model.Entidade.Imp.Endereco,
  Model.Entidade.Imp.Numero;

{ TEntidadeEnderecoEmpresa<T> }

constructor TEntidadeEnderecoEmpresa<T>.Create(Parent: T);
begin
  FParent   := Parent;
  FEndereco := TEntidadeEndereco<iEntidadeEnderecoEmpresa<T>>.New(Self);
  FNumero   := TEntidadeNumero<iEntidadeEnderecoEmpresa<T>>.New(Self);
end;

destructor TEntidadeEnderecoEmpresa<T>.Destroy;
begin
  inherited;
end;

class function TEntidadeEnderecoEmpresa<T>.New(Parent: T): iEntidadeEnderecoEmpresa<T>;
begin
  Result := Self.Create(Parent);
end;

function TEntidadeEnderecoEmpresa<T>.Id(Value: Integer): iEntidadeEnderecoEmpresa<T>;
begin
  Result := Self;
  FId    := Value;
end;

function TEntidadeEnderecoEmpresa<T>.Id: Integer;
begin
  Result := FId;
end;

function TEntidadeEnderecoEmpresa<T>.IdEmpresa(Value: Integer): iEntidadeEnderecoEmpresa<T>;
begin
  Result := Self;
  FIdEmpresa := Value;
end;

function TEntidadeEnderecoEmpresa<T>.IdEmpresa: Integer;
begin
  Result := FIdEmpresa;
end;

function TEntidadeEnderecoEmpresa<T>.IdEndereco(Value: Integer): iEntidadeEnderecoEmpresa<T>;
begin
  Result := Self;
  FIdEndereco := Value;
end;

function TEntidadeEnderecoEmpresa<T>.IdEndereco: Integer;
begin
  Result := FIdEndereco;
end;

//Injeção de dependência
function TEntidadeEnderecoEmpresa<T>.Endereco: iEntidadeEndereco<iEntidadeEnderecoEmpresa<T>>;
begin
  Result := FEndereco;
end;

function TEntidadeEnderecoEmpresa<T>.Numero: iEntidadeNumero<iEntidadeEnderecoEmpresa<T>>;
begin
  Result := FNumero;
end;
//Fim injeção de dependência

function TEntidadeEnderecoEmpresa<T>.&End: T;
begin
  Result := FParent;
end;

end.
