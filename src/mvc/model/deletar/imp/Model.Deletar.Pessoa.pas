{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 02/05/2024 19:27           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Deletar.Pessoa;

interface

uses
  Data.DB,
  System.SysUtils,

  Model.Deletar.Pessoa.Interfaces,
  Model.Entidade.Pessoa.Interfaces,
  Controller.Interfaces;

type
  TDeletarPessoa = class(TInterfacedObject, iDeletarPessoa)
    private
      FController : iController;
      FPessoa    : iEntidadePessoa<iDeletarPessoa>;
      FDSPessoa  : TDataSource;

      FFound : Boolean;
      FError : Boolean;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDeletarPessoa;

      function Delete : iDeletarPessoa;

      function Found  : Boolean;
      function Error  : Boolean;
      //injeção de dependência
      function Pessoa : iEntidadePessoa<iDeletarPessoa>;
      function &End    : iDeletarPessoa;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Pessoa;

{ TDeletarPessoa }

constructor TDeletarPessoa.Create;
begin
  FController := TController.New;
  FPessoa    := TEntidadePessoa<iDeletarPessoa>.New(Self);
  FDSPessoa  := TDataSource.Create(nil);

  FFound := False;
  FError := False;
end;

destructor TDeletarPessoa.Destroy;
begin
  inherited;
end;

class function TDeletarPessoa.New: iDeletarPessoa;
begin
  Result := Self.Create;
end;

function TDeletarPessoa.Delete: iDeletarPessoa;
begin
  Result := Self;
  FError := False;
  try
    FController
      .FactoryDAO
        .DAOPessoa
          .This
            .Id(FPessoa.Id)
          .&End
          .Delete
          .DataSet(FDSPessoa);
  except
    on E: Exception do
    begin
      WriteLn('Erro ao tentar excluír registro: ' + E.Message);
      FError := True;
    end;
  end;
end;

function TDeletarPessoa.Error: Boolean;
begin
  Result := FError;
end;

function TDeletarPessoa.Found: Boolean;
begin
  Result := FFound;
end;

//Injeção de dependência
function TDeletarPessoa.Pessoa: iEntidadePessoa<iDeletarPessoa>;
begin
  Result := FPessoa;
end;

function TDeletarPessoa.&End: iDeletarPessoa;
begin
  Result := Self;
end;

end.
