{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 22/04/2024 21:14           }
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
  Model.Conexao.Query.Interfaces,
  Controller.Interfaces;

Type
  TDAOPedidoPagamento = class(TInterfacedObject, iDAOPedidoPagamento)
    private
      FController : iController;
      FPedidoPagamento : iEntidadePedidoPagamento<iDAOPedidoPagamento>;
      FConexao     : iConexao;
      FDataSet     : TDataSet;
      FQuery       : iQuery;
      FQuery1      : iQuery;
      FUteis       : iUteis;
      FMSG         : TMensagens;
      FValorReceber : Currency;
      FValorParcela : Currency;
    const
      FSQL=('select '+
            'pp.id, '+
            'pp.idpedido, '+
            'pp.idcondicaopagamento, '+
            'pp.datavencimento, '+
            'pp.valorparcela, '+
            'pp.valorreceber '+
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
      function GetbyId    (Id : Variant)             : iDAOPedidoPagamento; overload;
      function GetbyId    (IdParent : Integer)       : iDAOPedidoPagamento; overload;
      function GetbyParams                           : iDAOPedidoPagamento; overload;
      function Post                                  : iDAOPedidoPagamento;
      function Put                                   : iDAOPedidoPagamento;
      function Delete                                : iDAOPedidoPagamento;
      function CalcularVencimentoValorParcela        : iDAOPedidoPagamento;
      function ValorReceber(Value : Currency)        : iDAOPedidoPagamento; overload;
      function ValorReceber                          : Currency;            overload;
      function ValorParcela(Value : Currency)        : iDAOPedidoPagamento; overload;
      function ValorParcela                          : Currency;            overload;

      function QuantidadeRegistro : Integer;
      function This : iEntidadePedidoPagamento<iDAOPedidoPagamento>;
  end;

implementation

uses
  Uteis,
  Model.Entidade.Imp.Pedido.Pagamento,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp,
  Imp.Controller;

{ TDAOPedidoPagamento }

constructor TDAOPedidoPagamento.Create;
begin
  FController := TController.New;
  FPedidoPagamento  := TEntidadePedidoPagamento<iDAOPedidoPagamento>.New(Self);
  FConexao := TModelConexaoFiredacMySQL.New;
  FQuery   := TQuery.New;
  FQuery1  := TQuery.New;
  FUteis   := TUteis.New;
  FMSG     := TMensagens.Create;
end;

destructor TDAOPedidoPagamento.Destroy;
begin
  FreeAndNil(FMSG);
  inherited;
end;

class function TDAOPedidoPagamento.New: iDAOPedidoPagamento;
begin
  Result := Self.Create;
end;

function TDAOPedidoPagamento.DataSet(DataSource: TDataSource): iDAOPedidoPagamento;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAOPedidoPagamento.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAOPedidoPagamento.GetAll: iDAOPedidoPagamento;
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
      WriteLn('Erro no TDAOPedidoPagamento.GetAll - ao tentar encontrar pedidopagamento todas: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FPedidoPagamento.Id(FDataSet.FieldByName('idpedido').AsInteger);
    QuantidadeRegistro;
  end
  else
    FPedidoPagamento.Id(0);
end;

function TDAOPedidoPagamento.GetbyId(Id: Variant): iDAOPedidoPagamento;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL+' where pp.Id=:Id')
                    .Params('Id', Id)
                    .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      WriteLn('Erro no TDAOPedidoPagamento.GetbyId - ao tentar encontrar pagamento pedido por Id: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FPedidoPagamento.Id(FDataSet.FieldByName('idpedido').AsInteger)
    else
    FPedidoPagamento.Id(0);
end;

function TDAOPedidoPagamento.GetbyId(IdParent: Integer): iDAOPedidoPagamento;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where pp.Idpedido=:Idpedido')
                    .Params('Idpedido', IdParent)
                    .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      WriteLn('Erro TDAOPedidoPagamento.GetbyId - ao tentar encontrar pagamento pedido por IdParent: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FPedidoPagamento.Id(FDataSet.FieldByName('idpedido').AsInteger)
    else
    FPedidoPagamento.Id(0);
end;

function TDAOPedidoPagamento.GetbyParams: iDAOPedidoPagamento;
begin
  {analisar como vai ser este filtro
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
  end;}
end;

function TDAOPedidoPagamento.Post: iDAOPedidoPagamento;
const
  LSQL=('insert into pedidopagamento( '+
                                      'idpedido, '+
                                      'idcondicaopagamento, '+
                                      'datavencimento, '+
                                      'valorparcela, '+
                                      'valorreceber '+
                                    ')'+
                                      ' values '+
                                    '('+
                                      ':idpedido, '+
                                      ':idcondicaopagamento, '+
                                      ':datavencimento, '+
                                      ':valorparcela, '+
                                      ':valorreceber '+
                                     ')'
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('idpedido'            , FPedidoPagamento.IdPedido)
        .Params('idcondicaopagamento' , FPedidoPagamento.IdCondicaoPagamento)
        .Params('datavencimento'      , FPedidoPagamento.DataVencimento)
        .Params('valorparcela'        , FPedidoPagamento.ValorParcela)
        .Params('valorreceber'        , FPedidoPagamento.valorreceber)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro TDAOPedidoPagamento.Post - ao tentar incluir pagamento do pedido: ' + E.Message);
      Abort;
    end;
  end;
  FConexao.Commit;
  FDataSet := FQuery
                .SQL('select LAST_INSERT_ID () as id')
                  .Open
                .DataSet;
  FPedidoPagamento.Id(FDataSet.FieldByName('id').AsInteger);
end;

function TDAOPedidoPagamento.Put: iDAOPedidoPagamento;
const
  LSQL=('update pedidopagamento set '+
                       'idpedido           =:idpedido, '+
                       'idcondicaopagamento=:idcondicaopagamento, '+
                       'datavencimento     =:datavencimento, '+
                       'valorparcela       =:valorparcela, '+
                       'valorreceber       =:valorreceber '+
                       'where      idpedido=:idpedido '
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('idpedido'            , FPedidoPagamento.IdPedido)
        .Params('idpedido'            , FPedidoPagamento.IdPedido)
        .Params('idcondicaopagamento' , FPedidoPagamento.IdCondicaoPagamento)
        .Params('datavencimento'      , FPedidoPagamento.DataVencimento)
        .Params('valorparcela'        , FPedidoPagamento.ValorParcela)
        .Params('valorreceber'        , FPedidoPagamento.valorreceber)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro TDAOPedidoPagamento.Put - ao tentar alterar pagamento do pedido: ' + E.Message);
      Abort;
    end;
  end;
  FConexao.Commit;
  FDataSet := FQuery
                .SQL('select LAST_INSERT_ID () as id')
                  .Open
                .DataSet;
  FPedidoPagamento.Id(FDataSet.FieldByName('id').AsInteger);
end;

function TDAOPedidoPagamento.Delete: iDAOPedidoPagamento;
const
  LSQL=('delete from pedidopagamento where id=:id ');
begin
  Result := self;
  FConexao.StartTransaction;
  try
    FQuery.SQL(LSQL)
             .Params('id', FPedidoPagamento.Id)
          .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro TDAOPedidoPagamento.Delete - ao tentar excluír pagamento do pedido: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOPedidoPagamento.CalcularVencimentoValorParcela: iDAOPedidoPagamento;
const
   lSQL=('select '+
         'cp.id, '+
         'cp.quantidadepagamento, '+
         'cp1.numeropagamento, '+
         'cp1.quantidadedias, '+
         'date_add(curdate(), interval cp1.quantidadedias day) as datavencimento '+
         'from condicaopagamento cp '+
         'inner join condicaopagamentoitem cp1 on cp.id = cp1.idcondicaopagamento '
        );
begin
  Result := Self;
  try
    FDataSet := FQuery1
                  .SQL(lSQL)
                    .Add('where cp.id=:id')
                    .Params('Id', FPedidoPagamento.IdCondicaoPagamento)
                    .Add('order by cp.id asc, cp1.quantidadedias asc')
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      WriteLn('Erro ao tentar incluir itens do pedido: ' + E.Message);
      Abort;
    end;
  end;
end;

function TDAOPedidoPagamento.ValorReceber(Value: Currency): iDAOPedidoPagamento;
begin
  Result := Self;
  FValorReceber := Value;
end;

function TDAOPedidoPagamento.ValorReceber: Currency;
begin
  Result := FValorReceber;
end;

function TDAOPedidoPagamento.ValorParcela(Value: Currency): iDAOPedidoPagamento;
begin
  Result := Self;
  FValorParcela := Value;
end;

function TDAOPedidoPagamento.ValorParcela: Currency;
begin
  Result := FValorParcela;
end;

function TDAOPedidoPagamento.LoopRegistro(Value: Integer): Integer;
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

function TDAOPedidoPagamento.QuantidadeRegistro: Integer;
begin
  Result := LoopRegistro(0);
end;

function TDAOPedidoPagamento.This: iEntidadePedidoPagamento<iDAOPedidoPagamento>;
begin
  Result := FPedidoPagamento;
end;

end.
