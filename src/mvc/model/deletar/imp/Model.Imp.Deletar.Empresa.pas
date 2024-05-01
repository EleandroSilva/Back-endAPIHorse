{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 30/04/2024 14:18           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Deletar.Empresa;

interface

uses
  Data.DB,
  System.SysUtils,

  Model.Deletar.Empresa.Interfaces,
  Model.Entidade.Empresa.Interfaces,
  Controller.Interfaces;

type
  TDeletarEmpresa = class(TInterfacedObject, iDeletarEmpresa)
    private
      FController : iController;
      FEmpresa    : iEntidadeEmpresa<iDeletarEmpresa>;
      FDSEmpresa  : TDataSource;

      FFound : Boolean;
      FError : Boolean;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDeletarEmpresa;

      function Delete : iDeletarEmpresa;

      function Found  : Boolean;
      function Error  : Boolean;
      //injeção de dependência
      function Empresa : iEntidadeEmpresa<iDeletarEmpresa>;
      function &End    : iDeletarEmpresa;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Empresa;

{ TDeletarEmpresa }

constructor TDeletarEmpresa.Create;
begin
  FController := TController.New;
  FEmpresa    := TEntidadeEmpresa<iDeletarEmpresa>.New(Self);
  FDSEmpresa  := TDataSource.Create(nil);

  FFound := False;
  FError := False;
end;

destructor TDeletarEmpresa.Destroy;
begin
  inherited;
end;

class function TDeletarEmpresa.New: iDeletarEmpresa;
begin
  Result := Self.Create;
end;

function TDeletarEmpresa.Delete: iDeletarEmpresa;
begin
  Result := Self;
  FError := False;
  try
    FController
      .FactoryDAO
        .DAOEmpresa
          .This
            .Id(FEmpresa.Id)
          .&End
          .Delete
          .DataSet(FDSEmpresa);
  except
    on E: Exception do
    begin
      WriteLn('Erro ao tentar excluír registro: ' + E.Message);
      FError := True;
    end;
  end;
end;

function TDeletarEmpresa.Error: Boolean;
begin
  Result := FError;
end;

function TDeletarEmpresa.Found: Boolean;
begin
  Result := FFound;
end;

//Injeção de dependência
function TDeletarEmpresa.Empresa: iEntidadeEmpresa<iDeletarEmpresa>;
begin
  Result := FEmpresa;
end;

function TDeletarEmpresa.&End: iDeletarEmpresa;
begin
  Result := Self;
end;

end.
