{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 22/04/2024 17:02           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Imp.Pedido;

interface

uses
  Data.DB,
  System.SysUtils,

  Uteis,
  Uteis.Interfaces,
  Uteis.Tratar.Mensagens,

  Model.DAO.Pedido.Interfaces,
  Model.Entidade.Pedido.Interfaces,
  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces;
type
  TDAOPedido= class(TInterfacedObject, iDAOPedido)
    private
      FPedido  : iEntidadePedido<iDAOPedido>;
      FConexao : iConexao;
      FDataSet : TDataSet;
      FQuery   : iQuery;
      FUteis   : iUteis;
      FMSG     : TMensagens;

    const
      FSQL=('select '+
            'p.id, '+
            'p.idempresa, '+
            'p.idcaixa, '+
            'p.idpessoa, '+
            'pp.nomepessoa, '+
            'pp.cpfcnpj, '+
            'p.idcondicaopagamento, '+
            'cpp.nomecondicaopagamento, '+
            'p.idusuario, '+
            'u.nomeusuario, '+
            'p.valorproduto, '+
            'p.valordesconto, '+
            'p.valorreceber, '+
            'p.valordescontoitem, '+
            'p.datahoraemissao, '+
            'p.status, '+
            'p.excluido '+
            'from pedido p '+
            'inner join pessoa             pp on pp.id  = p.idpessoa '+
            'inner join condicaopagamento cpp on cpp.id = p.idcondicaopagamento '+
            'inner join usuario             u on u.id   = p.idusuario '
            );
      function LoopRegistro(Value : Integer): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOPedido;

      function DataSet    (DataSource : TDataSource) : iDAOPedido; overload;
      function DataSet                               : TDataSet;   overload;
      function GetAll                                : iDAOPedido;
      function GetbyId    (Id : Variant)             : iDAOPedido;
      function GetbyParams                           : iDAOPedido; overload;
      function GetbyParams(aIdUsuario : Variant)     : iDAOPedido; overload;
      function GetbyParams(aIdPessoa : Integer)      : iDAOPedido; overload;
      function GetbyParams(aNomePessoa : String)     : iDAOPedido; overload;
      function Post                                  : iDAOPedido;
      function Put                                   : iDAOPedido; overload;
      function Put(Id : Variant)                     : iDAOPedido; overload;
      function Delete                                : iDAOPedido;

      function QuantidadeRegistro : Integer;
      function This : iEntidadePedido<iDAOPedido>;
  end;

implementation

uses
  Model.Entidade.Imp.Pedido,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp;

{ TDAOPedido }

constructor TDAOPedido.Create;
begin
  FPedido  := TEntidadePedido<iDAOPedido>.New(Self);
  FConexao := TModelConexaoFiredacMySQL.New;
  FQuery   := TQuery.New;
  FUteis   := TUteis.New;
  FMSG     := TMensagens.Create;
end;

destructor TDAOPedido.Destroy;
begin
  inherited;
end;

class function TDAOPedido.New: iDAOPedido;
begin
  Result := Self.Create;
end;

function TDAOPedido.DataSet(DataSource: TDataSource): iDAOPedido;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAOPedido.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAOPedido.GetAll: iDAOPedido;
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
      WriteLn('Erro no TDAOPedido.GetAll - ao tentar encontrar pedidos todas: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FPedido.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FPedido.Id(0);
end;

function TDAOPedido.GetbyId(Id: Variant): iDAOPedido;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where p.Id=:Id')
                    .Add('and p.excluido=:excluido')
                    .Params('Id', Id)
                    .params('excluido', FPedido.Excluido)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOPedido.GetbyId - ao tentar encontrar pedido por Id: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FPedido.Id(FDataSet.FieldByName('id').AsInteger)
    else
    FPedido.Id(0);
end;

function TDAOPedido.GetbyParams(aIdPessoa: Integer): iDAOPedido;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where p.Idpessoa=:Idpessoa')
                    .Add('and p.excluido=:excluido')
                    .Params('Idpessoa', aIdPessoa)
                    .params('excluido', FPedido.Excluido)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOPedido.GetbyParams - ao tentar encontrar pedido por Idpessoa: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FPedido.Id(FDataSet.FieldByName('id').AsInteger)
    else
    FPedido.Id(0);
end;

function TDAOPedido.GetbyParams: iDAOPedido;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where pp.cpfcnpj=:cpfcnpj')
                    .Add('and p.excluido=:excluido')
                    .Params('cpfcnpj', FPedido.Pessoa.CPFCNPJ)
                    .params('excluido', FPedido.Excluido)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOPedido.GetbyParams - ao tentar encontrar pedido por cpfcnpj: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FPedido.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FPedido.Id(0);
end;

function TDAOPedido.GetbyParams(aIdUsuario: Variant): iDAOPedido;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where p.idusuario=:idusuario')
                    .Add('and p.excluido=:excluido')
                    .Params('idusuario', FPedido.IdUsuario)
                    .params('excluido',  FPedido.Excluido)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOPedido.GetbyParams - ao tentar encontrar pedido por idusuario: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FPedido.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FPedido.Id(0);
end;

function TDAOPedido.GetbyParams(aNomePessoa: String): iDAOPedido;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL+' where ' + FUteis.Pesquisar('pp.nomepessoa', ';' + aNomePessoa))
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOPedido.GetbyParams - ao tentar encontrar pedido por nomepessoa: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FPedido.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FPedido.Id(0);
end;

function TDAOPedido.Post: iDAOPedido;
const
  LSQL=('insert into pedido( '+
                             'idempresa, '+
                             'idcaixa, '+
                             'idpessoa, '+
                             'idcondicaopagamento, '+
                             'idusuario, '+
                             'valorproduto, '+
                             'valordesconto, '+
                             'valorreceber, '+
                             'valordescontoitem, '+
                             'datahoraemissao, '+
                             'status, '+
                             'excluido '+
                           ')'+
                             ' values '+
                           '('+
                             ':idempresa, '+
                             ':idcaixa, '+
                             ':idpessoa, '+
                             ':idcondicaopagamento, '+
                             ':idusuario, '+
                             ':valorproduto, '+
                             ':valordesconto, '+
                             ':valorreceber, '+
                             ':valordescontoitem, '+
                             ':datahoraemissao, '+
                             ':status, '+
                             ':excluido '+
                            ')'
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('idempresa'           , FPedido.IdEmpresa)
        .Params('idcaixa'             , FPedido.IdCaixa)
        .Params('idpessoa'            , FPedido.IdPessoa)
        .Params('idcondicaopagamento' , FPedido.IdCondicaoPagamento)
        .Params('idusuario'           , FPedido.IdUsuario)
        .Params('valorproduto'        , FPedido.ValorProduto)
        .Params('valordesconto'       , FPedido.ValorDesconto)
        .Params('valorreceber'        , FPedido.ValorReceber)
        .Params('valordescontoitem'   , FPedido.ValorDescontoItem)
        .Params('datahoraemissao'     , FPedido.DataHoraEmissao)
        .Params('status'              , FPedido.Status)
        .Params('excluido'            , FPedido.Excluido)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOPedido.Post - ao tentar incluir novo pedido: ' + E.Message);
      Abort;
    end;
  end;
  FConexao.Commit;
  FDataSet := FQuery
                .SQL('select LAST_INSERT_ID () as id')
                .Open
                .DataSet;
  FPedido.Id(FDataSet.FieldByName('id').AsInteger);
end;


//Put para atualizar valor pedido
function TDAOPedido.Put(Id: Variant): iDAOPedido;
const
  lSQL=('update pedido set '+
                       'valorproduto     =:valorproduto, '+
                       'valordescontoitem=:valordescontoitem, '+
                       'valorreceber     =:valorreceber '+
                       'where      id    =:id '
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(lSQL)
        .Params('id'                , Id)
        .Params('valorproduto'      , FPedido.ValorProduto)
        .Params('valordescontoitem' , FPedido.ValorDescontoItem)
        .Params('valorreceber'      , FPedido.ValorReceber)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOPedido.Put - ao tentar alterar apenas valores do pedido: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOPedido.Put: iDAOPedido;
const
  LSQL=('update pedido set '+
                       'idempresa          =:idempresa, '+
                       'idcaixa            =:idcaixa, '+
                       'idpessoa           =:idpessoa, '+
                       'idcondicaopagamento=:idcondicaopagamento, '+
                       'idusuario          =:idusuario, '+
                       'valorproduto       =:valorproduto, '+
                       'valordesconto      =:valordesconto, '+
                       'valorreceber       =:valorreceber, '+
                       'valordescontoitem  =:valordescontoitem, '+
                       'datahoraemissao    =:datahoraemissao, '+
                       'status             =:status, '+
                       'excluido           =:excluido '+
                       'where id           =:id '
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('id'                  , FPedido.Id)
        .Params('idempresa'           , FPedido.IdEmpresa)
        .Params('idcaixa'             , FPedido.IdCaixa)
        .Params('idpessoa'            , FPedido.IdPessoa)
        .Params('idcondicaopagamento' , FPedido.IdCondicaoPagamento)
        .Params('idusuario'           , FPedido.IdUsuario)
        .Params('valorproduto'        , FPedido.ValorProduto)
        .Params('valordesconto'       , FPedido.ValorDesconto)
        .Params('valorreceber'        , FPedido.ValorReceber)
        .Params('valordescontoitem'   , FPedido.ValorDescontoItem)
        .Params('datahoraemissao'     , FPedido.DataHoraEmissao)
        .Params('status'              , FPedido.Status)
        .Params('excluido'            , FPedido.Excluido)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOPedido.Put - ao tentar alterar pedido: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;


function TDAOPedido.Delete: iDAOPedido;
const
  LSQL=('delete from pedido');
begin
  Result := self;
  FConexao.StartTransaction;
  try
    FQuery.SQL(LSQL)
               .Add('id=:id')
                 .Params('id', FPedido.Id)
               .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOPedido.Delete - ao tentar excluír pedido: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOPedido.LoopRegistro(Value: Integer): Integer;
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

function TDAOPedido.QuantidadeRegistro: Integer;
begin
  Result := LoopRegistro(0);
end;

function TDAOPedido.This: iEntidadePedido<iDAOPedido>;
begin
  Result := FPedido;
end;

end.
