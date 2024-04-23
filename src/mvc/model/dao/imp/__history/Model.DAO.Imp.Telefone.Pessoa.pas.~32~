{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 05/04/2024 09:19           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2004/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Imp.Telefone.Pessoa;

interface

uses
  Data.DB,

  System.SysUtils,

  Uteis.Tratar.Mensagens,

  Model.DAO.Telefone.Pessoa.Interfaces,
  Model.Entidade.Telefone.Pessoa.Interfaces,
  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces;
type
  TDAOTelefonePessoa = class(TInterfacedObject, iDAOTelefonePessoa)
    private
      FTelefonePessoa : iEntidadeTelefonePessoa<iDAOTelefonePessoa>;
      FConexao        : iConexao;
      FQuery          : iQuery;
      FMSG            : TMensagens;
      FDataSet        : TDataSet;

      const
        FSQL=('select '+
              'tp.id, '+
              'tp.idempresa, '+
              'tp.idpessoa, '+
              'tp.operadora, '+
              'tp.ddd, '+
              'tp.numerotelefone, '+
              'tp.tipotelefone, '+
              'tp.ativo '+
              'from telefonepessoa tp ');
      function LoopRegistro (Value : Integer): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOTelefonePessoa;

      function DataSet(DataSource : TDataSource) : iDAOTelefonePessoa; overload;
      function DataSet                           : TDataSet;            overload;
      function GetAll                            : iDAOTelefonePessoa;
      function GetbyId(Id : Variant)             : iDAOTelefonePessoa;
      function GetbyParams                       : iDAOTelefonePessoa;
      function Post                              : iDAOTelefonePessoa;
      function Put                               : iDAOTelefonePessoa;
      function Delete                            : iDAOTelefonePessoa;
      function QuantidadeRegistro                : Integer;

      function This : iEntidadeTelefonePessoa<iDAOTelefonePessoa>;
  end;

implementation

uses
  Model.Entidade.Imp.Telefone.Pessoa,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp;

constructor TDAOTelefonePessoa.Create;
begin
  FTelefonePessoa := TEntidadeTelefonePessoa<iDAOTelefonePessoa>.New(Self);
  FConexao        := TModelConexaoFiredacMySQL.New;
  FQuery          := TQuery.New;
  FMSG            := TMensagens.Create;
end;

destructor TDAOTelefonePessoa.Destroy;
begin
  FreeAndNil(FMSG);
  inherited;
end;

class function TDAOTelefonePessoa.New: iDAOTelefonePessoa;
begin
  Result := Self.Create;
end;

function TDAOTelefonePessoa.DataSet(DataSource: TDataSource): iDAOTelefonePessoa;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAOTelefonePessoa.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAOTelefonePessoa.GetAll: iDAOTelefonePessoa;
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
      FTelefonePessoa.Id(FDataSet.FieldByName('tp.id').AsInteger);
      QuantidadeRegistro;
    end
    else
      FTelefonePessoa.Id(0);
  end;
end;

function TDAOTelefonePessoa.GetbyId(Id: Variant): iDAOTelefonePessoa;
begin
  Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL)
                    .Add('where tp.id=:id')
                    .Params('Id', Id)
                    .Open
                  .DataSet;
    except
      on E: Exception do
      raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
    if not FDataSet.IsEmpty then
      FTelefonePessoa.Id(FDataSet.FieldByName('tp.id').AsInteger)
      else
      FTelefonePessoa.Id(0);
  end;
end;

function TDAOTelefonePessoa.GetbyParams: iDAOTelefonePessoa;
begin
  Result := Self;
  try
   try
     FDataSet := FQuery
                   .SQL(FSQL)
                   .Add('where tp.idempresa=:idempresa')
                   .Add('and tp.ddd=ddd')
                   .Add('and tp.numerotelefone=:numerotelefone')
                   .Params('idempresa'      , FTelefonePessoa.IdEmpresa)
                   .Params('ddd'            , FTelefonePessoa.NumeroTelefone)
                   .Params('numerotelefone' , FTelefonePessoa.NumeroTelefone)
                   .Open
                 .DataSet;
   except
     on E: Exception do
     raise exception.Create(FMSG.MSGerroGet+E.Message);
   end;
  finally
    if not FDataSet.IsEmpty then
    begin
      FTelefonePessoa.Id(FDataSet.FieldByName('tp.id').AsInteger);
      QuantidadeRegistro;
    end
    else
      FTelefonePessoa.Id(0);
  end;
end;

function TDAOTelefonePessoa.Post: iDAOTelefonePessoa;
const
  LSQL=('insert into telefonepessoa( '+
                                 'idempresa, ' +
                                 'idpessoa, '+
                                 'operadora, '+
                                 'ddd, '+
                                 'numerotelefone, '+
                                 'tipotelefone, '+
                                 'ativo '+
                                 ')'+
                                 ' values '+
                                 '('+
                                 ':idpessoa, '+
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
          .Params('idpessoa'       , FTelefonePessoa.IdPessoa)
          .Params('idempresa'      , FTelefonePessoa.IdEmpresa)
          .Params('operadora'      , FTelefonePessoa.Operadora)
          .Params('ddd'            , FTelefonePessoa.DDD)
          .Params('numerotelefone' , FTelefonePessoa.NumeroTelefone())
          .Params('tipotelefone'   , FTelefonePessoa.TipoTelefone())
          .Params('ativo'          , FTelefonePessoa.Ativo)
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
    FTelefonePessoa.Id(FDataSet.FieldByName('id').AsInteger);
  end;
end;

function TDAOTelefonePessoa.Put: iDAOTelefonePessoa;
const
  LSQL=('update telefonepessoa set '+
                               'idpessoa      =:idpessoa, '+
                               'idempresa     =:idempresa, '+
                               'operadora     =:operadora, '+
                               'ddd           =:ddd, '+
                               'numerotelefone=:numerotelefone, '+
                               'tipotelefone  =:tipotelefone, '+
                               'ativo         =:ativo '+
                               'where id=:id '
       );
begin
  Result := Self;

  FConexao.StartTransaction;
  try
    try
      FQuery
        .SQL(LSQL)
          .Params('id'             , FTelefonePessoa.Id)
          .Params('idpessoa'       , FTelefonePessoa.IdPessoa)
          .Params('idempresa'      , FTelefonePessoa.IdEmpresa)
          .Params('operadora'      , FTelefonePessoa.Operadora)
          .Params('ddd'            , FTelefonePessoa.DDD)
          .Params('numerotelefone' , FTelefonePessoa.NumeroTelefone)
          .Params('tipotelefone'   , FTelefonePessoa.TipoTelefone)
          .Params('ativo'          , FTelefonePessoa.Ativo)
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

function TDAOTelefonePessoa.Delete: iDAOTelefonePessoa;
const
  LSQL=('delete from telefonepessoa where id=:id ');
begin
  Result := self;
  FConexao.StartTransaction;
  try
    try
      FQuery.SQL(LSQL)
               .Params('id', FTelefonePessoa.Id)
            .ExecSQL;
    except
      on E: Exception do
      begin
        FConexao.Rollback;
        raise Exception.Create(FMSG.MSGerroDelete+E.Message);
      end;
    end;
  finally
    FConexao.Commit;
  end;
end;

function TDAOTelefonePessoa.LoopRegistro(Value : Integer): Integer;
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

function TDAOTelefonePessoa.QuantidadeRegistro : Integer;
begin
  Result := LoopRegistro(0);
end;

function TDAOTelefonePessoa.This: iEntidadeTelefonePessoa<iDAOTelefonePessoa>;
begin
  Result := FTelefonePessoa;
end;

end.
