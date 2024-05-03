{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 05/04/2024 09:19           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2004/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Imp.Telefone.Empresa;

interface

uses
  Data.DB,

  System.SysUtils,

  Uteis.Tratar.Mensagens,

  Model.DAO.Telefone.Empresa.Interfaces,
  Model.Entidade.Telefone.Empresa.Interfaces,
  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces;
type
  TDAOTelefoneEmpresa = class(TInterfacedObject, iDAOTelefoneEmpresa)
    private
      FTelefoneEmpresa : iEntidadeTelefoneEmpresa<iDAOTelefoneEmpresa>;
      FConexao         : iConexao;
      FQuery           : iQuery;
      FMSG             : TMensagens;
      FDataSet         : TDataSet;

      FKey      : String;
      FValue    : String;

      const
        FSQL=('select '+
              'te.id, '+
              'te.idempresa, '+
              'te.operadora, '+
              'te.ddd, '+
              'te.numerotelefone, '+
              'te.tipotelefone, '+
              'te.ativo '+
              'from telefoneempresa te ');

      function LoopRegistro (Value : Integer): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOTelefoneEmpresa;

      function DataSet(DataSource : TDataSource) : iDAOTelefoneEmpresa; overload;
      function DataSet                           : TDataSet;            overload;
      function GetAll                            : iDAOTelefoneEmpresa;
      function GetbyId(Id : Variant)             : iDAOTelefoneEmpresa; overload;
      function GetbyId(IdEmpresa : Integer)      : iDAOTelefoneEmpresa; overload;
      function GetbyParams                       : iDAOTelefoneEmpresa; overload;
      function Post                              : iDAOTelefoneEmpresa;
      function Put                               : iDAOTelefoneEmpresa;
      function Delete                            : iDAOTelefoneEmpresa;
      function QuantidadeRegistro                : Integer;

      function This : iEntidadeTelefoneEmpresa<iDAOTelefoneEmpresa>;
  end;

implementation

uses
  Model.Entidade.Imp.Telefone.Empresa,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp;

{ TDAOTelefoneEmpresa }

constructor TDAOTelefoneEmpresa.Create;
begin
  FTelefoneEmpresa := TEntidadeTelefoneEmpresa<iDAOTelefoneEmpresa>.New(Self);
  FConexao         := TModelConexaoFiredacMySQL.New;
  FQuery           := TQuery.New;
  FMSG             := TMensagens.Create;
end;

destructor TDAOTelefoneEmpresa.Destroy;
begin
  FreeAndNil(FMSG);
  inherited;
end;

class function TDAOTelefoneEmpresa.New: iDAOTelefoneEmpresa;
begin
  Result := Self.Create;
end;

function TDAOTelefoneEmpresa.DataSet(DataSource: TDataSource): iDAOTelefoneEmpresa;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAOTelefoneEmpresa.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAOTelefoneEmpresa.GetAll: iDAOTelefoneEmpresa;
begin
  Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL)
                    .Open
                  .DataSet;
    except
     on E: Exception do
     raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
   if not FDataSet.IsEmpty then
   begin
     FTelefoneEmpresa.Id(FDataSet.FieldByName('id').AsInteger);
     QuantidadeRegistro;
   end
   else
     FTelefoneEmpresa.Id(0);
  end;
end;

function TDAOTelefoneEmpresa.GetbyId(Id: Variant): iDAOTelefoneEmpresa;
begin
  Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL)
                    .Add('where te.id=:id')
                    .Add('te.idempresa=te.idempresa')
                    .Params('Id', Id)
                    .Open
                  .DataSet;
    except
      on E: Exception do
      raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
    if not FDataSet.IsEmpty then
      FTelefoneEmpresa.Id(FDataSet.FieldByName('id').AsInteger)
    else
      FTelefoneEmpresa.Id(0);
  end;
end;

//uso para listar no json junto com a tabela pai(empresa)
function TDAOTelefoneEmpresa.GetbyId(IdEmpresa : Integer): iDAOTelefoneEmpresa;
begin
  Result := Self;
  try
   try
     FDataSet := FQuery
                   .SQL(FSQL)
                     .Add('where te.idempresa=:idempresa')
                     .Params('idempresa' , IdEmpresa)
                   .Open
                 .DataSet;
   except
     on E: Exception do
     raise exception.Create(FMSG.MSGerroGet+E.Message);
   end;
  finally
   if not FDataSet.IsEmpty then
   begin
     FTelefoneEmpresa.Id(FDataSet.FieldByName('id').AsInteger);
     QuantidadeRegistro;
   end
   else
     FTelefoneEmpresa.Id(0);
  end;
end;

//Verifando se consta registro na tabela
function TDAOTelefoneEmpresa.GetbyParams: iDAOTelefoneEmpresa;
begin
  Result := Self;
  try
   try
     FDataSet := FQuery
                   .SQL(FSQL)
                     .Add('where te.idempresa=:idempresa')
                     .Add('and   te.ddd=:ddd')
                     .Add('and   te.numerotelefone=:numerotelefone')
                     .Params('idempresa'      , FTelefoneEmpresa.IdEmpresa)
                     .Params('ddd'            , FTelefoneEmpresa.DDD)
                     .Params('numerotelefone' , FTelefoneEmpresa.NumeroTelefone)
                   .Open
                 .DataSet;
   except
     on E: Exception do
     raise exception.Create(FMSG.MSGerroGet+E.Message);
   end;
  finally
   if not FDataSet.IsEmpty then
   begin
     FTelefoneEmpresa.Id(FDataSet.FieldByName('id').AsInteger);
     QuantidadeRegistro;
   end
   else
     FTelefoneEmpresa.Id(0);
  end;
end;

function TDAOTelefoneEmpresa.Post: iDAOTelefoneEmpresa;
const
  LSQL=('insert into telefoneempresa( '+
                                 'idempresa, ' +
                                 'operadora, '+
                                 'ddd, '+
                                 'numerotelefone, '+
                                 'tipotelefone, '+
                                 'ativo '+
                                 ') '+
                                 ' values '+
                                 '( '+
                                 ':idempresa, ' +
                                 ':operadora, '+
                                 ':ddd, '+
                                 ':numerotelefone, '+
                                 ':tipotelefone, '+
                                 ':ativo '+
                                 ')'
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    try
      FQuery
        .SQL(LSQL)
          .Params('idempresa'      , FTelefoneEmpresa.IdEmpresa)
          .Params('operadora'      , FTelefoneEmpresa.Operadora)
          .Params('ddd'            , FTelefoneEmpresa.DDD)
          .Params('numerotelefone' , FTelefoneEmpresa.NumeroTelefone)
          .Params('tipotelefone'   , FTelefoneEmpresa.TipoTelefone)
          .Params('ativo'          , FTelefoneEmpresa.Ativo)
          .ExecSQL;
    except
      on E: Exception do
      begin
        FConexao.Rollback;
        raise Exception.Create(FMSG.MSGerroPost+E.Message);
      end;
    end;
  finally
    FConexao.Commit;
    FDataSet := FQuery
                    .SQL('select LAST_INSERT_ID () as id')
                    .Open
                    .DataSet;
    FTelefoneEmpresa.Id(FDataSet.FieldByName('id').AsInteger);
  end;
end;

function TDAOTelefoneEmpresa.Put: iDAOTelefoneEmpresa;
const
  LSQL=('update telefoneempresa set '+
                               'idempresa     =:idempresa, '+
                               'operadora     =:operadora, '+
                               'ddd           =:ddd, '+
                               'numerotelefone=:numerotelefone, '+
                               'tipotelefone  =:tipotelefone, '+
                               'ativo         =:ativo '+
                               'where       id=:id '
       );
begin
  Result := Self;

  FConexao.StartTransaction;
  try
    try
      FQuery
        .SQL(LSQL)
          .Params('id'             , FTelefoneEmpresa.Id)
          .Params('idempresa'      , FTelefoneEmpresa.IdEmpresa)
          .Params('operadora'      , FTelefoneEmpresa.Operadora)
          .Params('ddd'            , FTelefoneEmpresa.DDD)
          .Params('numerotelefone' , FTelefoneEmpresa.NumeroTelefone)
          .Params('tipotelefone'   , FTelefoneEmpresa.TipoTelefone)
          .Params('ativo'          , FTelefoneEmpresa.Ativo)
        .ExecSQL;
    except
      on E: Exception do
      begin
        FConexao.Rollback;
        raise Exception.Create(FMSG.MSGerroPut+E.Message);
      end;
    end;
  finally
    FConexao.Commit;
  end;
end;

function TDAOTelefoneEmpresa.Delete: iDAOTelefoneEmpresa;
const
  LSQL=('delete from telefoneempresa where id=:id ');
begin
  Result := self;
  FConexao.StartTransaction;
  try
    try
      FQuery.SQL(LSQL)
               .Params('id', FTelefoneEmpresa.Id)
            .ExecSQL;
    except
      on E: Exception do
      begin
        FConexao.Rollback;
        raise Exception.Create(FMSG.MSGerroDelete+e.Message);
      end;
    end;
  finally
    FConexao.Commit;
  end;
end;

function TDAOTelefoneEmpresa.LoopRegistro(Value : Integer): Integer;
begin
  FDataSet.First;
  try
    while not FDataSet.Eof do
    begin
      Value := Value + 1;
      FDataSet.Next;
    end;
  finally
    Result := Value;
  end;
end;

function TDAOTelefoneEmpresa.QuantidadeRegistro : Integer;
begin
  Result := LoopRegistro(0);
end;

function TDAOTelefoneEmpresa.This: iEntidadeTelefoneEmpresa<iDAOTelefoneEmpresa>;
begin
  Result := FTelefoneEmpresa;
end;

end.
