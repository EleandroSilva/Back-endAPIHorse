{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 01/05/2024 15:11           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Pesquisar.Usuario;

interface

uses
  Data.DB,

  Model.Pesquisar.Usuario.Interfaces,
  Model.Entidade.Usuario.Interfaces,
  Controller.Interfaces;

type
  TPesquisarUsuario = class(TInterfacedObject, iPesquisarUsuario)
    private
      FController : iController;
      FUsuario    : iEntidadeUsuario<iPesquisarUsuario>;
      FDSUsuario  : TDataSource;
      FFound : Boolean;
      FError : Boolean;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iPesquisarUsuario;

      function Getby(Email, Senha: String) : iPesquisarUsuario;
      function Found : Boolean;
      function Error : Boolean;

      function Usuario : iEntidadeUsuario<iPesquisarUsuario>;
      function &End   : iPesquisarUsuario;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Usuario;

{ TPesquisarUsuario }

constructor TPesquisarUsuario.Create;
begin
  FController := TController.New;
  FUsuario    := TEntidadeUsuario<iPesquisarUsuario>.New(Self);
  FDSUsuario  := TDataSource.Create(nil);
  FFound := False;
  FError := False;
end;

destructor TPesquisarUsuario.Destroy;
begin
  inherited;
end;

class function TPesquisarUsuario.New: iPesquisarUsuario;
begin
  Result := Self.Create;
end;

function TPesquisarUsuario.Getby(Email, Senha: String): iPesquisarUsuario;
begin
  Result := Self;
  FFound := False;
  FController
    .FactoryDAO
      .DAOUsuario
        .This
          .Email(Email)
          .Senha(Senha)
        .&End
        .GetbyParams
        .DataSet(FDSUsuario);
  FFound := not FDSUsuario.DataSet.IsEmpty;
end;

function TPesquisarUsuario.Found: Boolean;
begin
  Result := FFound;
end;

function TPesquisarUsuario.Error: Boolean;
begin
  Result := FError;
end;

//Injeção de dependência
function TPesquisarUsuario.Usuario: iEntidadeUsuario<iPesquisarUsuario>;
begin
  Result := FUsuario;
end;

function TPesquisarUsuario.&End: iPesquisarUsuario;
begin
  Result := Self;
end;

end.
