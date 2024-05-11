{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 13/03/2024 10:28           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Imp.Controller;

interface

uses
  Controller.Interfaces,
  Model.Factory.DAO.Interfaces,
  Model.Factory.Cadastrar.Interfaces,
  Model.Factory.Pesquisar.Interfaces,
  Model.Factory.Alterar.Interfaces,
  Model.Factory.Deletar.Interfaces,
  Model.Factory.Consultar.API.Interfaces,
  Model.Factory.Uteis.Interfaces,
  Model.Factory.De.Para.Interfaces;

type
  TController = class(TInterfacedObject, iController)
    private
      FFactoryDAO          : iFactoryDAO;
      FFactoryCadastrar    : iFactoryCadastrar;
      FFactoryPesquisar    :  iFactoryPesquisar;
      FFactoryAlterar      : iFactoryAlterar;
      FFactoryDeletar      : iFactoryDeletar;
      FFactoryConsultarAPI : iFactoryConsultarAPI;
      FFactoryUteis        : iFactoryUteis;
      FFactoryDePara       : iFactoryDePara;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iController;

      function FactoryDAO          : iFactoryDAO;
      function FactoryCadastrar    : iFactoryCadastrar;
      function FactoryPesquisar    : iFactoryPesquisar;
      function FactoryAlterar      : iFactoryAlterar;
      function FactoryDeletar      : iFactoryDeletar;
      function FactoryConsultarAPI : iFactoryConsultarAPI;
      function FactoryUteis        : iFactoryUteis;
      function FactoryDePara       : iFactoryDePara;
  end;

implementation

uses
  Model.Factory.Imp.DAO,
  Model.Factory.Imp.Cadastrar,
  Model.Factory.Imp.Pesquisar,
  Model.Factory.Imp.Alterar,
  Model.Factory.Imp.Deletar,
  Model.Factory.Imp.Consultar.API,
  Model.Factory.Imp.Uteis,
  Model.Factory.Imp.De.Para;

{ TController }

constructor TController.Create;
begin
  //
end;

destructor TController.Destroy;
begin
  //
  inherited;
end;

class function TController.New: iController;
begin
  Result := Self.Create;
end;

function TController.FactoryDAO: iFactoryDAO;
begin
  if not Assigned(FFactoryDAO) then
    FFactoryDAO := TFactoryDAO.New;

  Result := FFactoryDAO;
end;

function TController.FactoryCadastrar: iFactoryCadastrar;
begin
  if not Assigned(FFactoryCadastrar) then
    FFactoryCadastrar := TFactoryCadastrar.New;

  Result := FFactoryCadastrar;
end;

function TController.FactoryPesquisar: iFactoryPesquisar;
begin
  if not Assigned(FFactoryPesquisar) then
    FFactoryPesquisar := TFactoryPesquisar.New;

  Result := FFactoryPesquisar;
end;

function TController.FactoryAlterar: iFactoryAlterar;
begin
  if not Assigned(FFactoryAlterar) then
    FFactoryAlterar := TFactoryAlterar.New;

  Result := FFactoryAlterar;
end;

function TController.FactoryDeletar: iFactoryDeletar;
begin
  if not Assigned(FFactoryDeletar) then
    FFactoryDeletar := TFactoryDeletar.New;

  Result := FFactoryDeletar;
end;

function TController.FactoryConsultarAPI: iFactoryConsultarAPI;
begin
  if not Assigned(FFactoryConsultarAPI) then
    FFactoryConsultarAPI := TFactoryConsultarAPI.New;

  Result := FFactoryConsultarAPI;
end;

function TController.FactoryUteis: iFactoryUteis;
begin
  if not Assigned(FFactoryUteis) then
    FFactoryUteis := TFactoryUteis.New;

  Result := FFactoryUteis;
end;

function TController.FactoryDePara: iFactoryDePara;
begin
  if not Assigned(FFactoryDePara) then
    FFactoryDePara := TFactoryDePara.New;

  Result := FFactoryDePara;
end;

end.
