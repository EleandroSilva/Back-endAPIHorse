{*******************************************************}
{                    API PDV - JSON                     }
{                      ES Sistemas                      }
{          In�cio do projeto 13/03/2024 10:43           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Factory.Imp.Entidade;

interface

uses
  Model.Factory.Entidade.Interfaces,
  Model.DAO.Usuario.Interfaces,
  Model.DAO.Imp.Usuario,
  Model.DAO.Empresa.Interfaces,
  Model.DAO.IMp.Empresa,
  Model.DAO.Grupo.Produto.Interfaces,
  Model.DAO.Imp.Grupo.Produto,
  Model.DAO.Marca.Produto.Interfaces,
  Model.DAO.Imp.Marca.Produto,
  Model.DAO.Unidade.Produto.Interfaces, Model.DAO.Imp.Unidade.Produto;

type
  TFactoryEntidade = class(TInterfacedObject, iFactoryEntidade)
    private
      FDAOUsuario        : iDAOUsuario;
      FDAOEmpresa        : iDAOEmpresa;
      FDAOGrupoProduto   : iDAOGrupoProduto;
      FDAOMarcaProduto   : iDAOMarcaProduto;
      FDAOUnidadeProduto : iDAOUnidadeProduto;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iFactoryEntidade;

      function DAOUsuario        : iDAOUsuario;
      function DAOEmpresa        : iDAOEmpresa;
      function DAOGrupoProduto   : iDAOGrupoProduto;
      function DAOMarcaProduto   : iDAOMarcaProduto;
      function DAOUnidadeProduto : iDAOUnidadeProduto;
  end;

implementation

{ TFactoryEntidade }

constructor TFactoryEntidade.Create;
begin
  //
end;

destructor TFactoryEntidade.Destroy;
begin
  //
  inherited;
end;

class function TFactoryEntidade.New: iFactoryEntidade;
begin
  Result := Self.Create;
end;

function TFactoryEntidade.DAOUsuario: iDAOUsuario;
begin
  if not Assigned(FDAOUsuario) then
    FDAOUsuario := TDAOUsuario.New;

  Result := FDAOUsuario;
end;

function TFactoryEntidade.DAOEmpresa: iDAOEmpresa;
begin
  if not Assigned(FDAOEmpresa) then
    FDAOEmpresa := TDAOEmpresa.New;

  Result := FDAOEmpresa;
end;

function TFactoryEntidade.DAOGrupoProduto: iDAOGrupoProduto;
begin
  if not Assigned(FDAOGrupoProduto) then
    FDAOGrupoProduto := TDAOGrupoProduto.New;

  Result := FDAOGrupoProduto;
end;

function TFactoryEntidade.DAOMarcaProduto: iDAOMarcaProduto;
begin
  if not Assigned(FDAOMarcaProduto) then
    FDAOMarcaProduto := TDAOMarcaProduto.New;

  Result := FDAOMarcaProduto;
end;

function TFactoryEntidade.DAOUnidadeProduto: iDAOUnidadeProduto;
begin
  if not Assigned(FDAOUnidadeProduto) then
    FDAOUnidadeProduto := TDAOUnidadeProduto.New;

  Result := FDAOUnidadeProduto;
end;

end.
