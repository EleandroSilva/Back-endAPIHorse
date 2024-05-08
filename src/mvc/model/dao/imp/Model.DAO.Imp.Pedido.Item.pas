{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 22/04/2024 20:50           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Imp.Pedido.Item;

interface

uses
  Data.DB,
  System.SysUtils,

  Uteis,
  Uteis.Interfaces,
  Uteis.Tratar.Mensagens,

  Model.DAO.Pedido.Item.Interfaces,
  Model.Entidade.Pedido.Item.Interfaces,
  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces;

type
  TDAOPedidoItem= class(TInterfacedObject, iDAOPedidoItem)
    private
      FPedidoItem  : iEntidadePedidoItem<iDAOPedidoItem>;
      FConexao     : iConexao;
      FDataSet     : TDataSet;
      FQuery       : iQuery;
      FUteis       : iUteis;
      FMSG         : TMensagens;

    const
      FSQL=('select '+
            'pi.id, '+
            'pi.idpedido, '+
            'pi.idproduto, '+
            'pro.nomeproduto, '+
            'pi.quantidade, '+
            'pi.valorunitario, '+
            'pi.valordescontoitem, '+
            'pi.valorreceber '+
            'from pedidoitem pi '+
            'inner join produto pro on pro.id = pi.idproduto '
            );
      FSum=('select '+
            'coalesce(cast(sum(valorproduto) as decimal(10,3)),0)      as valorproduto, '+
            'coalesce(cast(sum(valordescontoitem) as decimal(10,3)),0) as valordescontoitem, '+
            'coalesce(cast(sum(valorreceber) as decimal(10,3)),0)      as valorreceber '+
            'from pedidoitem ');

      function LoopRegistro(Value : Variant): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOPedidoItem;

      function DataSet    (DataSource : TDataSource) : iDAOPedidoItem; overload;
      function DataSet                               : TDataSet;       overload;
      function GetAll                                : iDAOPedidoItem;
      function GetbyId    (Id : Variant)             : iDAOPedidoItem; overload;
      function GetbyId    (IdParent : Integer)       : iDAOPedidoItem; overload;
      function GetbyParams                           : iDAOPedidoItem; overload;
      function GetbyParams(IdProduto : Variant)      : iDAOPedidoItem; overload;
      function GetbyParams(NomeProduto : String)     : iDAOPedidoItem; overload;
      function Post                                  : iDAOPedidoItem;
      function Put                                   : iDAOPedidoItem;
      function Delete                                : iDAOPedidoItem;
      function SomarPedidoItem                       : iDAOPedidoItem;

      function QuantidadeRegistro : Integer;
      function This : iEntidadePedidoItem<iDAOPedidoItem>;
  end;

implementation

uses
  Model.Entidade.Imp.Pedido.Item,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp;

{ TDAOPedidoItem }

constructor TDAOPedidoItem.Create;
begin
  FPedidoItem  := TEntidadePedidoItem<iDAOPedidoItem>.New(Self);
  FConexao     := TModelConexaoFiredacMySQL.New;
  FQuery       := TQuery.New;
  FUteis       := TUteis.New;
  FMSG         := TMensagens.Create;
end;

destructor TDAOPedidoItem.Destroy;
begin
  FreeAndNil(FMSG);
  inherited;
end;

class function TDAOPedidoItem.New: iDAOPedidoItem;
begin
  Result := Self.Create;
end;

function TDAOPedidoItem.DataSet(DataSource: TDataSource): iDAOPedidoItem;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAOPedidoItem.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAOPedidoItem.GetAll: iDAOPedidoItem;
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
      WriteLn('Erro no TDAOPedidoItem.GetAll - ao tentar encontrar pedidoitem todas: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FPedidoItem.Id(FDataSet.FieldByName('idpedido').AsInteger);
    QuantidadeRegistro;
  end
  else
    FPedidoItem.Id(0);
end;

function TDAOPedidoItem.GetbyId(Id: Variant): iDAOPedidoItem;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL+' where pi.Id=:Id')
                    .Params('Id', Id)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOPedidoItem.GetbyId - ao tentar encontrar pedidoitem por Id: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FPedidoItem.Id(FDataSet.FieldByName('idpedido').AsInteger)
  else
    FPedidoItem.Id(0);
end;

function TDAOPedidoItem.GetbyId(IdParent: Integer): iDAOPedidoItem;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where pi.idpedido=:idpedido')
                    .Params('idpedido', IdParent)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOPedidoItem.GetbyId - ao tentar encontrar pedidoitem por Idpedido: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FPedidoItem.Id(FDataSet.FieldByName('idpedido').AsInteger)
  else
    FPedidoItem.Id(0);
end;

function TDAOPedidoItem.GetbyParams: iDAOPedidoItem;
begin
  {analisar como será este filtro
  Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL)
                    .Add('where pi.idpedido=:idpedido')
                    .Params('idpedido', FPedidoItem.IdPedido)
                    .Open
                  .DataSet;
    except
      on E: Exception do
      raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
    if not FDataSet.IsEmpty then
      FPedidoItem.Id(FDataSet.FieldByName('idpedido').AsInteger)
    else
      FPedidoItem.Id(0);
  end;
  }
end;

function TDAOPedidoItem.GetbyParams(IdProduto: Variant): iDAOPedidoItem;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where pi.idproduto=:idproduto')
                    .Params('idproduto', IdProduto)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOPedidoItem.GetbyParams - ao tentar encontrar pedidoitem por Idproduto: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FPedidoItem.Id(FDataSet.FieldByName('idpedido').AsInteger);
    QuantidadeRegistro;
  end
  else
    FPedidoItem.Id(0);
end;

function TDAOPedidoItem.GetbyParams(NomeProduto: String): iDAOPedidoItem;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL+' where ' + FUteis.Pesquisar('pro.nomeproduto', ';' + NomeProduto))
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOPedidoItem.GetbyParams - ao tentar encontrar pedidoitem por nomeproduto: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FPedidoItem.Id(FDataSet.FieldByName('idpedido').AsInteger)
  else
    FPedidoItem.Id(0);
end;

function TDAOPedidoItem.Post: iDAOPedidoItem;
const
  LSQL=('insert into pedidoitem( '+
                             'idpedido, '+
                             'idproduto, '+
                             'quantidade, '+
                             'valorunitario, '+
                             'valorproduto, '+
                             'valordescontoitem, '+
                             'valorreceber '+
                           ')'+
                             ' values '+
                           '('+
                             ':idpedido, '+
                             ':idproduto, '+
                             ':quantidade, '+
                             ':valorunitario, '+
                             ':valorproduto, '+
                             ':valordescontoitem, '+
                             ':valorreceber '+
                            ')'
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('idpedido'          , FPedidoItem.IdPedido)
        .Params('idproduto'         , FPedidoItem.IdProduto)
        .Params('quantidade'        , FPedidoItem.Quantidade)
        .Params('valorunitario'     , FPedidoItem.ValorUnitario)
        .Params('valorproduto'      , FPedidoItem.ValorProduto)
        .Params('valordescontoitem' , FPedidoItem.ValorDescontoItem)
        .Params('valorreceber'      , FPedidoItem.ValorReceber)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOPedidoItem.Post - ao tentar incluir pedidoitem: ' + E.Message);
      Abort;
    end;
  end;
  FConexao.Commit;
  FDataSet := FQuery
                .SQL('select LAST_INSERT_ID () as id')
                .Open
                .DataSet;
  FPedidoItem.Id(FDataSet.FieldByName('id').AsInteger);
  SomarPedidoItem;
end;

function TDAOPedidoItem.Put: iDAOPedidoItem;
const
  LSQL=('update pedidoitem set '+
                       'idpedido          =:idpedido, '+
                       'idproduto         =:idproduto, '+
                       'quantidade        =:quantidade, '+
                       'valorunitario     =:valorunitario, '+
                       'valorproduto      =:valorproduto, '+
                       'valordescontoitem =:valordescontoitem, '+
                       'valorreceber      =:valorreceber '+
                       'where idpedido    =:idpedido '
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('idpedido'          , FPedidoItem.IdPedido)
        .Params('idpedido'          , FPedidoItem.IdPedido)
        .Params('idproduto'         , FPedidoItem.IdProduto)
        .Params('quantidade'        , FPedidoItem.Quantidade)
        .Params('valorunitario'     , FPedidoItem.ValorUnitario)
        .Params('valorproduto'      , FPedidoItem.ValorProduto)
        .Params('valordescontoitem' , FPedidoItem.ValorDescontoItem)
        .Params('valorreceber'      , FPedidoItem.ValorReceber)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOPedidoItem.Put - ao tentar alterar pedidoitem: ' + E.Message);
      Abort;
    end;
  end;
  FConexao.Commit;
  FDataSet := FQuery
                .SQL('select LAST_INSERT_ID () as id')
                .Open
                .DataSet;
  FPedidoItem.Id(FDataSet.FieldByName('id').AsInteger);
  SomarPedidoItem;
end;

function TDAOPedidoItem.Delete: iDAOPedidoItem;
const
  LSQL=('delete from pedidoitem where id=:id ');
begin
  Result := self;
  FConexao.StartTransaction;
  try
    FQuery.SQL(LSQL)
                 .Params('id', FPedidoItem.Id)
               .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOPedidoItem.Delete - ao tentar excluír pedidoitem: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOPedidoItem.LoopRegistro(Value: Variant): Integer;
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

function TDAOPedidoItem.QuantidadeRegistro: Integer;
begin
  Result := LoopRegistro(0);
end;

function TDAOPedidoItem.SomarPedidoItem: iDAOPedidoItem;
begin
  Result := Self;
  FDataSet := FQuery
                .SQL(FSum)
                  .Add('where idpedido=:id')
                  .Params('id',FPedidoItem.IdPedido)
                .Open
                .DataSet;
end;

function TDAOPedidoItem.This: iEntidadePedidoItem<iDAOPedidoItem>;
begin
  Result := FPedidoItem;
end;

end.
