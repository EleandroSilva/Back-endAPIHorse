{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 03/04/2024 16:03           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Imp.Email.Empresa;

interface

uses
  Data.DB,

  System.SysUtils,

  Uteis.Tratar.Mensagens,

  Model.DAO.Email.Empresa.Interfaces,
  Model.Entidade.Email.Empresa.Interfaces,
  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces;

type
  TDAOEmailEmpresa = class(TInterfacedObject, iDAOEmailEmpresa)
    private
      FEmailEmpresa : iEntidadeEmailEmpresa<iDAOEmailEmpresa>;
      FConexao      : iConexao;
      FQuery        : iQuery;
      FMSG          : TMensagens;
      FDataSet      : TDataSet;

      const
        FSQL=('select '+
              'ee.id, '+
              'ee.idempresa, '+
              'ee.email, '+
              'ee.tipoemail, '+
              'ee.ativo '+
              'from emailempresa ee ');
      function  LoopRegistro(Value: Integer): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOEMailEmpresa;
      function DataSet(DataSource : TDataSource) : iDAOEmailEmpresa; overload;
      function DataSet                           : TDataSet;         overload;
      function GetAll                            : iDAOEmailEmpresa;
      function GetbyId(Id : Variant)             : iDAOEmailEmpresa;  overload;
      function GetbyId(IdEmpresa : Integer)      : iDAOEmailEmpresa;  overload;
      function GetbyParams                       : iDAOEmailEmpresa;  overload;
      function Post                              : iDAOEmailEmpresa;
      function Put                               : iDAOEmailEmpresa;
      function Delete                            : iDAOEmailEmpresa;

      function QuantidadeRegistro : Integer;
      function This : iEntidadeEmailEmpresa<iDAOEmailEmpresa>;
  end;

implementation

uses
  Model.Entidade.Imp.Email.Empresa,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp;

{ TDAOEmailEmpresa }

constructor TDAOEmailEmpresa.Create;
begin
  FEmailEmpresa := TEntidadeEmailEmpresa<iDAOEmailEmpresa>.New(Self);
  FConexao      := TModelConexaoFiredacMySQL.New;
  FQuery        := TQuery.New;
  FMSG          := TMensagens.Create;
end;

destructor TDAOEmailEmpresa.Destroy;
begin
  FreeAndNil(FMSG);
  inherited;
end;

class function TDAOEmailEmpresa.New: iDAOEMailEmpresa;
begin
  Result := Self.Create;
end;

function TDAOEmailEmpresa.DataSet(DataSource: TDataSource): iDAOEmailEmpresa;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAOEmailEmpresa.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAOEmailEmpresa.GetAll: iDAOEmailEmpresa;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOEmailEmpresa.GetAll - ao tentar encontrar emailempresa: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FEmailEmpresa.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FEmailEmpresa.Id(0);
end;

function TDAOEmailEmpresa.GetbyId(Id: Variant): iDAOEmailEmpresa;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where ee.id=:id')
                    .Add('and ee.ideempresa=ee.idempresa')
                    .Params('Id', Id)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOEmailEmpresa.GetId - ao tentar encontrar emailempresa por Id: ' + E.Message);
      Abort;
    end;
  end;
    if not FDataSet.IsEmpty then
      FEmailEmpresa.Id(FDataSet.FieldByName('id').AsInteger)
    else
      FEmailEmpresa.Id(0);
end;

function TDAOEmailEmpresa.GetbyId(IdEmpresa : Integer) : iDAOEmailEmpresa;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where ee.idempresa=:idempresa')
                    .Params('idempresa', IdEmpresa)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOEmailEmpresa.GetId - ao tentar encontrar emailempresa por IdEmpresa: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FEmailEmpresa.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
     FEmailEmpresa.Id(0);
end;

function TDAOEmailEmpresa.GetbyParams: iDAOEmailEmpresa;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where ee.idempresa=:idempresa')
                    .Add('and ee.email=:email')
                    .Params('idempresa', FEmailEmpresa.IdEmpresa)
                    .params('email'    , FEmailEmpresa.Email)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOEmailEmpresa.GetParams - ao tentar encontrar emailempresa idempresa+email: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FEmailEmpresa.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FEmailEmpresa.Id(0);
end;

function TDAOEmailEmpresa.Post: iDAOEmailEmpresa;
const
  LSQL=('insert into emailempresa( '+
                                 'idempresa, ' +
                                 'email, '+
                                 'tipoemail, '+
                                 'ativo '+
                                 ') '+
                                 ' values '+
                                 '('+
                                 ':idempresa, ' +
                                 ':email, '+
                                 ':tipoemail, '+
                                 ':ativo '+
                                 ')'
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('idempresa' , FEmailEmpresa.IdEmpresa)
        .Params('email'     , FEmailEmpresa.Email)
        .Params('tipoemail' , FEmailEmpresa.TipoEmail)
        .Params('ativo'     , FEmailEmpresa.Ativo)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOEmailEmpresa.GetParams - ao tentar encontrar incluir emailempresa: ' + E.Message);
      Abort;
    end;
  end;
  FConexao.Commit;
  FDataSet := FQuery
                .SQL('select LAST_INSERT_ID () as id')
                  .Open
                .DataSet;
  FEmailEmpresa.Id(FDataSet.FieldByName('id').AsInteger);
end;

function TDAOEmailEmpresa.Put: iDAOEmailEmpresa;
const
  LSQL=('update emailempresa set '+
                               'idempresa =:idempresa, '+
                               'email     =:email, '+
                               'tipoemail =:tipoemail, '+
                               'ativo     =:ativo '+
                               'where id=:id '
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('id'        , FEmailEmpresa.Id)
        .Params('idempresa' , FEmailEmpresa.IdEmpresa)
        .Params('email'     , FEmailEmpresa.Email)
        .Params('tipoemail' , FEmailEmpresa.TipoEmail)
        .Params('ativo'     , FEmailEmpresa.Ativo)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOEmailEmpresa.GetParams - ao tentar encontrar alterar emailempresa: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOEmailEmpresa.Delete: iDAOEmailEmpresa;
const
  LSQL=('delete from emailempresa where id=:id ');
begin
  Result := self;
  FConexao.StartTransaction;
  try
    FQuery.SQL(LSQL)
                .Params('id', FEmailEmpresa.Id)
               .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOEmailEmpresa.GetParams - ao tentar encontrar excluír emailempresa: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOEmailEmpresa.LoopRegistro(Value: Integer): Integer;
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

function TDAOEmailEmpresa.QuantidadeRegistro: Integer;
begin
  Result := LoopRegistro(0);
end;

function TDAOEmailEmpresa.This: iEntidadeEmailEmpresa<iDAOEmailEmpresa>;
begin
  Result := FEmailEmpresa;
end;

end.
