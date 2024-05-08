unit Model.DAO.Imp.Fechar.Caixa;

interface

uses
  Data.DB,
  System.SysUtils,

  Uteis.Interfaces,
  Uteis,
  Uteis.Tratar.Mensagens,

  Model.DAO.Fechar.Caixa.Interfaces,
  Model.Entidade.Fechar.Caixa.Interfaces,
  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces;

type
  TDAOFecharCaixa= class(TInterfacedObject, iDAOFecharCaixa)
    private
      FFecharCaixa : iEntidadeFecharCaixa<iDAOFecharCaixa>;
      FConexao     : iConexao;
      FDataSet     : TDataSet;
      FQuery       : iQuery;
      FUteis       : iUteis;
      FMSG         : TMensagens;

    const
      FSQL=('select '+
            'cde.id, '+
            'cde.idcaixa, '+
            'cde.idusuario, '+
            'u.nomeusuario, '+
            'cde.valorlancado, '+
            'cde.datahoraemissao, '+
            'cde.observacao '+
            'from fecharcaixa cde '+
            'inner join usuario u on u.id = cde.idusuario '
            );
      function LoopRegistro(Value : Integer): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOFecharCaixa;

      function DataSet    (DataSource : TDataSource) : iDAOFecharCaixa; overload;
      function DataSet                               : TDataSet;                    overload;
      function GetAll                                : iDAOFecharCaixa;
      function GetbyId    (Id : Variant)             : iDAOFecharCaixa;
      function GetbyParams                           : iDAOFecharCaixa; overload;
      function GetbyParams(IdUsuario : Variant)      : iDAOFecharCaixa; overload;
      function GetbyParams(NomeUsuario : String)     : iDAOFecharCaixa; overload;
      function GetbyParams(IdPedido : Integer)       : iDAOFecharCaixa; overload;
      function Post                                  : iDAOFecharCaixa;
      function Put                                   : iDAOFecharCaixa;
      function Delete                                : iDAOFecharCaixa;

      function QuantidadeRegistro : Integer;
      function This : iEntidadeFecharCaixa<iDAOFecharCaixa>;
  end;

implementation

uses
  Model.Entidade.Imp.Fechar.Caixa,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp;

constructor TDAOFecharCaixa.Create;
begin
  FFecharCaixa := TEntidadefecharCaixa<iDAOFecharCaixa>.New(Self);
  FConexao     := TModelConexaoFiredacMySQL.New;
  FQuery       := TQuery.New;
  FUteis       := TUteis.New;
  FMSG         := TMensagens.Create;
end;

destructor TDAOFecharCaixa.Destroy;
begin
  FreeAndNil(FMSG);
  inherited;
end;

class function TDAOFecharCaixa.New: iDAOFecharCaixa;
begin
  Result := Self.Create;
end;

function TDAOFecharCaixa.DataSet(DataSource: TDataSource): iDAOFecharCaixa;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAOFecharCaixa.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAOFecharCaixa.GetAll: iDAOFecharCaixa;
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
      WriteLn('Erro no TDAOFecharCaixa.GetAll - ao tentar encontrar fecharcaixa todos: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FFecharCaixa.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FFecharCaixa.Id(0);
end;

function TDAOFecharCaixa.GetbyId(Id: Variant): iDAOFecharCaixa;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL+' where cde.Id=:Id')
                    .Params('Id', Id)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOFecharCaixa.GetbyId - ao tentar encontrar fecharcaixa por Id: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FFecharCaixa.Id(FDataSet.FieldByName('id').AsInteger)
  else
    FFecharCaixa.Id(0);
end;

function TDAOFecharCaixa.GetbyParams(IdPedido: Integer): iDAOFecharCaixa;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL+' where cde.idpedido=:Idpedido')
                    .Params('Idpedido', IdPedido)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOFecharCaixa.GetbyParams - ao tentar encontrar fecharcaixa por Idpedido: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FFecharCaixa.Id(FDataSet.FieldByName('id').AsInteger)
  else
    FFecharCaixa.Id(0);
end;

function TDAOFecharCaixa.GetbyParams: iDAOFecharCaixa;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where u.nomeusuario=:nomeusuario')
                    .Params('nomeusuario', FFecharCaixa.Usuario.NomeUsuario)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOFecharCaixa.GetbyParams - ao tentar encontrar fecharcaixa por nomeusuario: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FFecharCaixa.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FFecharCaixa.Id(0);
end;

function TDAOFecharCaixa.GetbyParams(IdUsuario: Variant): iDAOFecharCaixa;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where cde.idusuario=:idusuario')
                    .Params('idusuario', IdUsuario)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOFecharCaixa.GetbyParams - ao tentar encontrar fecharcaixa por idusuario: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FFecharCaixa.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FFecharCaixa.Id(0);
end;

function TDAOFecharCaixa.GetbyParams(NomeUsuario: String): iDAOFecharCaixa;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL+' where ' + FUteis.Pesquisar('u.nomeusuario', ';' + NomeUsuario))
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOFecharCaixa.GetbyParams - ao tentar encontrar fecharcaixa por nomeusuario: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FFecharCaixa.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FFecharCaixa.Id(0);
end;

function TDAOFecharCaixa.Post: iDAOFecharCaixa;
const
  LSQL=('insert into fecharcaixa( '+
                                'idcaixa, '+
                                'idusuario, '+
                                'valorlancado, '+
                                'datahoraemissao, '+
                                'observacao '+
                                ')'+
                                ' values '+
                                '('+
                                ':idcaixa, '+
                                ':idusuario, '+
                                ':valorlancado, '+
                                ':datahoraemissao, '+
                                ':observacao '+
                                ')'
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('idcaixa'         , FFecharCaixa.IdCaixa)
        .Params('idusuario'       , FFecharCaixa.IdUsuario)
        .Params('valorlancado'    , FFecharCaixa.ValorLancado)
        .Params('datahoraemissao' , FFecharCaixa.DataHoraEmissao)
        .Params('observacao'      , FFecharCaixa.Observacao)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOFecharCaixa.Post - ao tentar incluir fecharcaixa: ' + E.Message);
      Abort;
    end;
  end;
  FConexao.Commit;
  FDataSet := FQuery
                .SQL('select LAST_INSERT_ID () as id')
                .Open
                .DataSet;
  FFecharCaixa.Id(FDataSet.FieldByName('id').AsInteger);
end;

function TDAOFecharCaixa.Put: iDAOFecharCaixa;
const
  LSQL=('update fecharcaixa set '+
                          'idcaixa     =:idcaixa, '+
                          'idusuario   =:idusuario, '+
                          'valorlancado=:valorlancado, '+
                          'observacao  =:observacao '+
                          'where id    =:id '
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('id'           , FFecharCaixa.Id)
        .Params('idcaixa'      , FFecharCaixa.IdCaixa)
        .Params('idusuario'    , FFecharCaixa.IdUsuario)
        .Params('valorlancado' , FFecharCaixa.ValorLancado)
        .Params('observacao'   , FFecharCaixa.Observacao)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOFecharCaixa.Put - ao tentar alterar fecharcaixa: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOFecharCaixa.Delete: iDAOFecharCaixa;
const
  LSQL=('delete from fecharcaixa where id=:id ');
begin
  Result := self;
  FConexao.StartTransaction;
  try
    FQuery.SQL(LSQL)
                .Params('id', FFecharCaixa.Id)
               .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOFecharCaixa.Delete - ao tentar excluír fecharcaixa: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOFecharCaixa.LoopRegistro(Value: Integer): Integer;
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

function TDAOFecharCaixa.QuantidadeRegistro: Integer;
begin
  Result := LoopRegistro(0);
end;

function TDAOFecharCaixa.This: iEntidadeFecharCaixa<iDAOFecharCaixa>;
begin
  Result := FFecharCaixa;
end;

end.
