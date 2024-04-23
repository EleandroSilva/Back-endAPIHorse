{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 22/04/2024 21:14           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Imp.Pedido.Pagamento;

interface

uses
  Data.DB,
  System.SysUtils,

  Uteis.Tratar.Mensagens,
  Uteis.Interfaces,

  Model.DAO.Pedido.Pagamento.Interfaces,
  Model.Entidade.Pedido.Pagamento.Interfaces,
  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces;

Type
  TPedidoPagamento = class(TInterfacedObject, iDAOPedidoPagamento)
    private
      FPedidoPagamento : iEntidadePedidoPagamento<iDAOPedidoPagamento>;
      FConexao     : iConexao;
      FDataSet     : TDataSet;
      FQuery       : iQuery;
      FUteis       : iUteis;
      FMSG         : TMensagens;

    const
      FSQL=('select '+
            'pp.id, '+
            'pp.idpedido, '+
            'pp.idpagamento, '+
            'pp.datavencimento, '+
            'pp.valorparcela '+
            'from pedidopagamento pp '
            );
      function LoopRegistro(Value : Integer): Integer;

    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOPedidoPagamento;

      function DataSet    (DataSource : TDataSource) : iDAOPedidoPagamento; overload;
      function DataSet                               : TDataSet;            overload;
      function GetAll                                : iDAOPedidoPagamento;
      function GetbyId    (Id : Variant)             : iDAOPedidoPagamento;
      function GetbyParams                           : iDAOPedidoPagamento; overload;
      function Post                                  : iDAOPedidoPagamento;
      function Put                                   : iDAOPedidoPagamento;
      function Delete                                : iDAOPedidoPagamento;
      function QuantidadeRegistro                    : Integer;

      function This : iEntidadePedidoPagamento<iDAOPedidoPagamento>;
  end;

implementation

uses
  Uteis,
  Model.Entidade.Imp.Pedido.Pagamento,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp;

{ TPedidoPagamento }

constructor TPedidoPagamento.Create;
begin
  FPedidoPagamento  := TEntidadePedidoPagamento<iDAOPedidoPagamento>.New(Self);
  FConexao := TModelConexaoFiredacMySQL.New;
  FQuery   := TQuery.New;
  FUteis   := TUteis.New;
  FMSG     := TMensagens.Create;
end;

destructor TPedidoPagamento.Destroy;
begin
  FreeAndNil(FMSG);
  inherited;
end;

class function TPedidoPagamento.New: iDAOPedidoPagamento;
begin
  Result := Self.Create;
end;

function TPedidoPagamento.DataSet(DataSource: TDataSource): iDAOPedidoPagamento;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TPedidoPagamento.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TPedidoPagamento.GetAll: iDAOPedidoPagamento;
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
      FPedidoPagamento.Id(FDataSet.FieldByName('idpedido').AsInteger);
      QuantidadeRegistro;
    end
    else
      FPedidoPagamento.Id(0);
  end;
end;

function TPedidoPagamento.GetbyId(Id: Variant): iDAOPedidoPagamento;
begin
  Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL+' where pp.Id=:Id')
                    .Params('Id', Id)
                    .Open
                  .DataSet;
    except
      on E: Exception do
      raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
    if not FDataSet.IsEmpty then
      FPedidoPagamento.Id(FDataSet.FieldByName('idpedido').AsInteger)
    else
      FPedidoPagamento.Id(0);
  end;
end;

function TPedidoPagamento.GetbyParams: iDAOPedidoPagamento;
begin
  Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL)
                    .Add('where pp.Idpedido=:Idpedido')
                    .Params('Idpedido', FPedidoPagamento.IdPedido)
                    .Open
                  .DataSet;
    except
      on E: Exception do
      raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
    if not FDataSet.IsEmpty then
      FPedidoPagamento.Id(FDataSet.FieldByName('idpedido').AsInteger)
    else
      FPedidoPagamento.Id(0);
  end;
end;

function TPedidoPagamento.Post: iDAOPedidoPagamento;
const
  LSQL=('insert into pedidoitem( '+
                             'idpedido, '+
                             'idpagamento, '+
                             'datavencimento, '+
                             'valorparcela '+
                           ')'+
                             ' values '+
                           '('+
                             ':idpedido, '+
                             ':idpagamento, '+
                             ':datavencimento, '+
                             ':valorparcela '+
                            ')'
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    try
      FQuery
        .SQL(LSQL)
          .Params('idpedido'       , FPedidoPagamento.IdPedido)
          .Params('idpagamento'    , FPedidoPagamento.IdPagamento)
          .Params('datavencimento' , FPedidoPagamento.DataVencimento)
          .Params('valorparcela'   , FPedidoPagamento.ValorParcela)
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
    FPedidoPagamento.Id(FDataSet.FieldByName('id').AsInteger);
  end;
end;

function TPedidoPagamento.Put: iDAOPedidoPagamento;
const
  LSQL=('update pedidoitem set '+
                       'idpedido      =:idpedido, '+
                       'idpagamento   =:idpagamento, '+
                       'datavencimento=:datavencimento, '+
                       'valorparcela  =:valorparcela '+
                       'where id      =:id '
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    try
      FQuery
        .SQL(LSQL)
          .Params('id'             , FPedidoPagamento.Id)
          .Params('idpedido'       , FPedidoPagamento.IdPedido)
          .Params('idpagamento'    , FPedidoPagamento.IdPagamento)
          .Params('datavencimento' , FPedidoPagamento.DataVencimento)
          .Params('valorparcela'   , FPedidoPagamento.ValorParcela)
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
    FDataSet := FQuery
                    .SQL('select LAST_INSERT_ID () as id')
                    .Open
                    .DataSet;
    FPedidoPagamento.Id(FDataSet.FieldByName('id').AsInteger);
  end;
end;

function TPedidoPagamento.Delete: iDAOPedidoPagamento;
const
  LSQL=('delete from pedidopagamento where id=:id ');
begin
  Result := self;
  FConexao.StartTransaction;
  try
    try
      FQuery.SQL(LSQL)
              .Params('id', FPedidoPagamento.Id)
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

function TPedidoPagamento.LoopRegistro(Value: Integer): Integer;
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

function TPedidoPagamento.QuantidadeRegistro: Integer;
begin
  Result := LoopRegistro(0);
end;

function TPedidoPagamento.This: iEntidadePedidoPagamento<iDAOPedidoPagamento>;
begin
  Result := FPedidoPagamento;
end;

end.
