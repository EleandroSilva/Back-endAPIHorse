{*******************************************************}
{                    API PDV - JSON                     }
{                     Be More Web                       }
{          Início do projeto 03/04/2024 16:03           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Imp.Numero;

interface

uses
  System.SysUtils,
  Data.DB,

  Uteis.Tratar.Mensagens,

  Model.DAO.Numero.Interfaces,
  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces,
  Model.Entidade.Numero.Interfaces;

type
  TDAONumero = class(TInterfacedObject, iDAONumero)
    private
      FNumero  : iEntidadeNumero<iDAONumero>;
      FConexao : iConexao;
      FQuery   : iQuery;
      FMSG     : TMensagens;
      FDataSet : TDataSet;

      const
        FSQL= ('select '+
               'n.id, '+
               'n.idendereco, '+
               'n.numeroendereco, '+
               'n.complementoendereco '+
               'from numero n '
               );
      function LoopRegistro (Value : Integer): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAONumero;
      function DataSet(DataSource : TDataSource) : iDAONumero; overload;
      function DataSet                           : TDataSet;   overload;
      function GetAll                            : iDAONumero;
      function GetbyId(Id : Variant)             : iDAONumero;
      function GetbyParams                       : iDAONumero;
      function Post                              : iDAONumero;
      function Put                               : iDAONumero;
      function Delete                            : iDAONumero;
      function QuantidadeRegistro                : Integer;
      function This : iEntidadeNumero<iDAONumero>;
  end;

implementation

uses
  Model.Entidade.Imp.Numero,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp;

{ TDAONumero }

constructor TDAONumero.Create;
begin
  FNumero  := TEntidadeNumero<iDAONumero>.New(Self);
  FConexao := TModelConexaoFiredacMySQL.New;
  FQuery   := TQuery.New;
  FMSG     := TMensagens.Create;
end;

destructor TDAONumero.Destroy;
begin
  FreeAndNil(FMSG);
  inherited;
end;

class function TDAONumero.New: iDAONumero;
begin
  Result := Self.Create;
end;

function TDAONumero.DataSet(DataSource: TDataSource): iDAONumero;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAONumero.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAONumero.GetAll: iDAONumero;
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
      FNumero.Id(FDataSet.FieldByName('id').AsInteger);
      QuantidadeRegistro;
    end
    else
      FNumero.Id(0);
  end;
end;

function TDAONumero.GetbyId(Id: Variant): iDAONumero;
begin
  Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL)
                    .Add('where e.id=:id')
                    .Params('Id', Id)
                    .Open
                  .DataSet;
    except
      on E: Exception do
      raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
    if not FDataSet.IsEmpty then
      FNumero.Id(FDataSet.FieldByName('e.id').AsInteger)
      else
      FNumero.Id(0);
  end;
end;

function TDAONumero.GetbyParams: iDAONumero;
begin
  Result := Self;
  try
   try
     FDataSet := FQuery
                   .SQL(FSQL)
                   .Add('where n.idendereco    =:idendereco')
                   .Add('and   n.numeroendereco=:numeroendereco')
                   .Params('idendereco'     , FNumero.IdEndereco)
                   .Params('numeroendereco' , FNumero.NumeroEndereco)
                   .Open
                 .DataSet;
   except
     on E: Exception do
     raise exception.Create(FMSG.MSGerroGet+E.Message);
   end;
  finally
   if not FDataSet.IsEmpty then
   begin
     FNumero.Id(FDataSet.FieldByName('n.id').AsInteger);
     QuantidadeRegistro;
   end
   else
     FNumero.Id(0);
  end;
end;

function TDAONumero.Post: iDAONumero;
const
  LSQL=('insert into numero( '+
                            'idendereco, '+
                            'numeroendereco, '+
                            'complementoendereco '+
                            ')'+
                            ' values '+
                            '('+
                            ':idendereco, '+
                            ':numeroendereco, '+
                            ':complementoendereco '+
                             ') '
       );
begin
  Result := Self;

  FConexao.StartTransaction;
  try
    try
      FQuery
        .SQL(LSQL)
          .Params('idendereco'          , FNumero.IdEndereco)
          .Params('numeroendereco'      , FNumero.NumeroEndereco)
          .Params('complementoendereco' , FNumero.ComplementoEndereco)
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
                    .SQL('select LAST_INSERT_ID () as id ')
                    .Open
                    .DataSet;
    FNumero.Id(FDataSet.FieldByName('id').AsInteger);
  end;
end;

function TDAONumero.Put: iDAONumero;
const
  LSQL=('update numero set '+
                      'idendereco         =:idendereco, '+
                      'numeroendereco     =:numeroendereco, '+
                      'complementoendereco=:complementoendereco '+
                      'where            id=:id '
       );
begin
  Result := Self;

  FConexao.StartTransaction;
  try
    try
      FQuery
        .SQL(LSQL)
          .Params('id'                  , FNumero.Id)
          .Params('idendereco'          , FNumero.IdEndereco)
          .Params('numeroendereco'      , FNumero.NumeroEndereco)
          .Params('complementoendereco' , FNumero.ComplementoEndereco)
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

function TDAONumero.Delete: iDAONumero;
const
  LSQL=('delete from numero where id=:id ');
begin
  Result := self;
  FConexao.StartTransaction;
  try
    try
      FQuery.SQL(LSQL)
               .Params('id', FNumero.Id)
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

function TDAONumero.LoopRegistro(Value : Integer): Integer;
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

function TDAONumero.QuantidadeRegistro : Integer;
begin
  Result := LoopRegistro(0);
end;

function TDAONumero.This: iEntidadeNumero<iDAONumero>;
begin
  Result := FNumero;
end;

end.
