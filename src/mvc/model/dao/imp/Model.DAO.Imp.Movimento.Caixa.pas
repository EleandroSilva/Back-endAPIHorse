{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 22/04/2024 14:46           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Imp.Movimento.Caixa;

interface

uses
  Data.DB,
  System.SysUtils,

  Uteis.Interfaces,
  Uteis,
  Uteis.Tratar.Mensagens,

  Model.DAO.Movimento.Caixa.Interfaces,
  Model.Entidade.Movimento.Caixa.Interfaces,
  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces;

type
  TDAOMovimentoCaixa= class(TInterfacedObject, iDAOMovimentoCaixa)
    private
      FMovimentoCaixa : iEntidadeMovimentoCaixa<iDAOMovimentoCaixa>;
      FConexao     : iConexao;
      FDataSet     : TDataSet;
      FQuery       : iQuery;
      FUteis       : iUteis;
      FMSG         : TMensagens;

    const
      FSQL=('select '+
            'mc.id, '+
            'mc.idcaixa, '+
            'mc.idpedido, '+
            'mc.idformapagamento, '+
            'mc.idusuario, '+
            'u.nomeusuario, '+
            'mc.valorlancado, '+
            'mc.datahoraemissao, '+
            'mc.tipolancamento '+
            'from movimentocaixa mc '+
            'inner join usuario u on u.id = mc.idusuario '
            );
      function LoopRegistro(Value : Integer): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOMovimentoCaixa;

      function DataSet    (DataSource : TDataSource) : iDAOMovimentoCaixa; overload;
      function DataSet                               : TDataSet;           overload;
      function GetAll                                : iDAOMovimentoCaixa;
      function GetbyId    (Id : Variant)             : iDAOMovimentoCaixa;
      function GetbyParams                           : iDAOMovimentoCaixa; overload;
      function GetbyParams(aIdUsuario : Variant)     : iDAOMovimentoCaixa; overload;
      function GetbyParams(aNomeUsuario : String)    : iDAOMovimentoCaixa; overload;
      function GetbyParams(aIdPedido : Integer)      : iDAOMovimentoCaixa; overload;
      function Post                                  : iDAOMovimentoCaixa;
      function Put                                   : iDAOMovimentoCaixa;
      function Delete                                : iDAOMovimentoCaixa;
      function QuantidadeRegistro                    : Integer;

      function This : iEntidadeMovimentoCaixa<iDAOMovimentoCaixa>;
  end;

implementation

uses
  Model.Entidade.Imp.Movimento.Caixa,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp;

{ TDAOMovimentoCaixa }

constructor TDAOMovimentoCaixa.Create;
begin
  FMovimentoCaixa := TEntidadeMovimentoCaixa<iDAOMovimentoCaixa>.New(Self);
  FConexao        := TModelConexaoFiredacMySQL.New;
  FQuery          := TQuery.New;
  FUteis          := TUteis.New;
  FMSG            := TMensagens.Create;
end;

destructor TDAOMovimentoCaixa.Destroy;
begin
  FreeAndNil(FMSG);
  inherited;
end;

class function TDAOMovimentoCaixa.New: iDAOMovimentoCaixa;
begin
  Result := Self.Create;
end;

function TDAOMovimentoCaixa.DataSet(DataSource: TDataSource): iDAOMovimentoCaixa;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAOMovimentoCaixa.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAOMovimentoCaixa.GetAll: iDAOMovimentoCaixa;
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
      FMovimentoCaixa.Id(FDataSet.FieldByName('id').AsInteger);
      QuantidadeRegistro;
    end
    else
      FMovimentoCaixa.Id(0);
  end;
end;

function TDAOMovimentoCaixa.GetbyId(Id: Variant): iDAOMovimentoCaixa;
begin
  Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL+' where cdm.Id=:Id')
                    .Params('Id', Id)
                    .Open
                  .DataSet;
    except
      on E: Exception do
      raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
    if not FDataSet.IsEmpty then
      FMovimentoCaixa.Id(FDataSet.FieldByName('id').AsInteger)
    else
      FMovimentoCaixa.Id(0);
  end;
end;

function TDAOMovimentoCaixa.GetbyParams(aIdPedido: Integer): iDAOMovimentoCaixa;
begin
  Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL+' where cdm.idpedido=:Idpedido')
                    .Params('Idpedido', aIdPedido)
                    .Open
                  .DataSet;
    except
      on E: Exception do
      raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
    if not FDataSet.IsEmpty then
      FMovimentoCaixa.Id(FDataSet.FieldByName('id').AsInteger)
    else
      FMovimentoCaixa.Id(0);
  end;
end;

function TDAOMovimentoCaixa.GetbyParams: iDAOMovimentoCaixa;
begin
   Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL)
                    .Add('where u.nomeusuario=:nomeusuario')
                    .Params('nomeusuario', FMovimentoCaixa.Usuario.NomeUsuario)
                    .Open
                  .DataSet;
    except
      on E: Exception do
      raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
    if not FDataSet.IsEmpty then
    begin
      FMovimentoCaixa.Id(FDataSet.FieldByName('id').AsInteger);
      QuantidadeRegistro;
    end
    else
      FMovimentoCaixa.Id(0);
  end;
end;

function TDAOMovimentoCaixa.GetbyParams(aIdUsuario: Variant): iDAOMovimentoCaixa;
begin
  Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL)
                    .Add('where cdm.idusuario=:idusuario')
                    .Params('idusuario', FMovimentoCaixa.IdUsuario)
                    .Open
                  .DataSet;
    except
      on E: Exception do
      raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
    if not FDataSet.IsEmpty then
    begin
      FMovimentoCaixa.Id(FDataSet.FieldByName('id').AsInteger);
      QuantidadeRegistro;
    end
    else
      FMovimentoCaixa.Id(0);
  end;
end;

function TDAOMovimentoCaixa.GetbyParams(aNomeUsuario: String): iDAOMovimentoCaixa;
begin
  Result := Self;
  try
   try
     FDataSet := FQuery
                   .SQL(FSQL+' where ' + FUteis.Pesquisar('u.nomeusuario', ';' + aNomeUsuario))
                   .Open
                 .DataSet;
   except
     on E: Exception do
     raise exception.Create(FMSG.MSGerroGet+E.Message);
   end;
  finally
    if not FDataSet.IsEmpty then
    begin
      FMovimentoCaixa.Id(FDataSet.FieldByName('id').AsInteger);
      QuantidadeRegistro;
    end
    else
      FMovimentoCaixa.Id(0);
  end;
end;

function TDAOMovimentoCaixa.Post: iDAOMovimentoCaixa;
const
  LSQL=('insert into caixadiariomovimento( '+
                                         'idcaixa, '+
                                         'idpedido, '+
                                         'idformapagamento, '+
                                         'idusuario, '+
                                         'valorlancado, '+
                                         'datahoraemissao, '+
                                         'tipolancamento '+
                                       ')'+
                                         ' values '+
                                       '('+
                                         ':idcaixa, '+
                                         ':idpedido, '+
                                         ':idformapagamento, '+
                                         ':idusuario, '+
                                         ':valorlancado, '+
                                         ':datahoraemissao, '+
                                         ':tipolancamento '+
                                        ')'
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    try
      FQuery
        .SQL(LSQL)
          .Params('idcaixa'          , FMovimentoCaixa.IdCaixa)
          .Params('idpedido'         , FMovimentoCaixa.IdPedido)
          .Params('idformapagamento' , FMovimentoCaixa.IdFormaPagamento)
          .Params('idusuario'        , FMovimentoCaixa.IdUsuario)
          .Params('valorlancado'     , FMovimentoCaixa.ValorLancado)
          .Params('datahoraemissao'  , FMovimentoCaixa.DataHoraEmissao)
          .Params('tipolancamento'   , FMovimentoCaixa.TipoLancamento)
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
    FMovimentoCaixa.Id(FDataSet.FieldByName('id').AsInteger);
  end;
end;

function TDAOMovimentoCaixa.Put: iDAOMovimentoCaixa;
const
  LSQL=('update movimentocaixa set '+
                              'idcaixa         =:idcaixa, '+
                              'idpedido        =:idpedido, '+
                              'idformapagamento=:idformapagamento, '+
                              'idusuario       =:idusuario, '+
                              'valorlancado    =:valorlancado '+
                              'tipolancamento  =:tipolancamento '+
                              'where id        =:id '
       );
begin
  Result := Self;

  FConexao.StartTransaction;
  try
    try
      FQuery
        .SQL(LSQL)
          .Params('id'               , FMovimentoCaixa.Id)
          .Params('idcaixa'          , FMovimentoCaixa.IdCaixa)
          .Params('idpedido'         , FMovimentoCaixa.IdPedido)
          .Params('idformapagamento' , FMovimentoCaixa.IdFormaPagamento)
          .Params('idusuario'        , FMovimentoCaixa.IdUsuario)
          .Params('valorlancado'     , FMovimentoCaixa.ValorLancado)
          .Params('tipolancamento'   , FMovimentoCaixa.TipoLancamento)
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

function TDAOMovimentoCaixa.Delete: iDAOMovimentoCaixa;
const
  LSQL=('delete from movimentocaixa where id=:id ');
begin
   Result := self;
  FConexao.StartTransaction;
  try
    try
      FQuery.SQL(LSQL)
              .Params('id', FMovimentoCaixa.Id)
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

function TDAOMovimentoCaixa.LoopRegistro(Value: Integer): Integer;
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

function TDAOMovimentoCaixa.QuantidadeRegistro: Integer;
begin
  Result := LoopRegistro(0);
end;

function TDAOMovimentoCaixa.This: iEntidadeMovimentoCaixa<iDAOMovimentoCaixa>;
begin
  Result := FMovimentoCaixa;
end;

end.
