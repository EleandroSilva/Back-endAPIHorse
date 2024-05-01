{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 30/04/2024 20:04           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Pesquisar.Empresa;

interface

uses
  Data.DB,
  System.SysUtils,

  Model.Pesquisar.Empresa.Interfaces,
  Model.Entidade.Empresa.Interfaces,
  Controller.Interfaces;

type
  TPesquisarEmpresa = class(TInterfacedObject, iPesquisarEmpresa)
    private
      FController : iController;
      FEmpresa    : iEntidadeEmpresa<iPesquisarEmpresa>;

      FDSEmpresa  : TDataSource;

      //
      FFound : Boolean;
      FError : Boolean;
    public
      constructor Create;
      Destructor Destroy; override;
      class function New : iPesquisarEmpresa;

      function GetbyId             (Id : Variant)             : iPesquisarEmpresa;
      function GetbyCNPJ           (CNPJ: String)             : iPesquisarEmpresa;
      function GetbyNomeEmpresarial(NomeEmpresarial : String) : iPesquisarEmpresa;

      //
      function Found   : Boolean;
      function Error   : Boolean;
      function Empresa : iEntidadeEmpresa<iPesquisarEmpresa>;
      function &End    : iPesquisarEmpresa;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Empresa,
  Model.Cadastrar.Empresa.Interfaces;

{ TPesquisarEmpresa }

constructor TPesquisarEmpresa.Create;
begin
  FController := TController.New;
  FEmpresa    := TEntidadeEmpresa<iPesquisarEmpresa>.New(Self);
  FDSEmpresa  := TDataSource.Create(nil);

  //Variáveis
  FFound := False;
  FError := False;
end;

destructor TPesquisarEmpresa.Destroy;
begin
  inherited;
end;

class function TPesquisarEmpresa.New: iPesquisarEmpresa;
begin
  Result := Self.Create;
end;

function TPesquisarEmpresa.GetbyId(Id: Variant): iPesquisarEmpresa;
begin
  Result := Self;
  try
    FController
      .FactoryDAO
        .DAOEmpresa
          .GetbyId(Id)
        .DataSet(FDSEmpresa);
  except
    on E: Exception do
    begin
      WriteLn('Erro ao tentar filtrar tabela empresa pelo ID:' + E.Message);
      FError := True;
    end;
  end;
  FFound := Not FDSEmpresa.DataSet.IsEmpty;
end;

function TPesquisarEmpresa.GetbyCNPJ(CNPJ: String): iPesquisarEmpresa;
begin
  Result := Self;
  try
    FController
      .FactoryDAO
        .DAOEmpresa
          .GetbyCNPJ(CNPJ)
        .DataSet(FDSEmpresa);
  except
    on E: Exception do
    begin
      WriteLn('Erro ao tentar filtrar tabela empresa pelo CNPJ: ' + E.Message);
      FError := True;
    end;
  end;
  FFound := Not FDSEmpresa.DataSet.IsEmpty;
end;

function TPesquisarEmpresa.GetbyNomeEmpresarial(NomeEmpresarial: String): iPesquisarEmpresa;
begin
  //
end;

//quando True-Sim Encontrado-Encontrada
function TPesquisarEmpresa.Found: Boolean;
begin
  Result := FFound;
end;

//quando True sim com erro
function TPesquisarEmpresa.Error: Boolean;
begin
  Result := FError;
end;

//Injeção de dependência
function TPesquisarEmpresa.Empresa: iEntidadeEmpresa<iPesquisarEmpresa>;
begin
  Result := FEmpresa;
end;

function TPesquisarEmpresa.&End: iPesquisarEmpresa;
begin
  Result := Self;
end;



end.
