{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 22/04/2024 17:02           }
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
            'p.idpessoa, '+
            'pp.nomepessoa, '+
            'pp.cpfcnpj, '+
            'p.idpagamento, '+
            'cpp.nomecondicaopagamento, '+
            'p.idusuario, '+
            'u.nomeusuario, '+
            'p.valorproduto, '+
            'p.valordesconto, '+
            'p.valorreceber, '+
            'p.datahoraemissao, '+
            'p.status '+
            'from pedido p '+
            'inner join pessoa             pp on pp.id  = p.idpessoa '+
            'inner join condicaopagamento cpp on cpp.id = p.idpagamento '+
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
      function Put                                   : iDAOPedido;
      function Delete                                : iDAOPedido;
      function QuantidadeRegistro                    : Integer;

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
      FPedido.Id(FDataSet.FieldByName('id').AsInteger);
      QuantidadeRegistro;
    end
    else
      FPedido.Id(0);
  end;
end;

function TDAOPedido.GetbyId(Id: Variant): iDAOPedido;
begin
  Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL+' where p.Id=:Id')
                    .Params('Id', Id)
                    .Open
                  .DataSet;
    except
      on E: Exception do
      raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
    if not FDataSet.IsEmpty then
      FPedido.Id(FDataSet.FieldByName('id').AsInteger)
    else
      FPedido.Id(0);
  end;
end;

function TDAOPedido.GetbyParams(aIdPessoa: Integer): iDAOPedido;
begin
  Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL)
                    .Add('where p.Idpessoa=:Idpessoa')
                    .Params('Idpessoa', aIdPessoa)
                    .Open
                  .DataSet;
    except
      on E: Exception do
      raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
    if not FDataSet.IsEmpty then
      FPedido.Id(FDataSet.FieldByName('id').AsInteger)
    else
      FPedido.Id(0);
  end;
end;

function TDAOPedido.GetbyParams: iDAOPedido;
begin
  Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL)
                    .Add('where pp.cpfcnpj=:cpfcnpj')
                    .Params('cpfcnpj', FPedido.Pessoa.CPFCNPJ)
                    .Open
                  .DataSet;
    except
      on E: Exception do
      raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
    if not FDataSet.IsEmpty then
    begin
      FPedido.Id(FDataSet.FieldByName('id').AsInteger);
      QuantidadeRegistro;
    end
    else
      FPedido.Id(0);
  end;
end;

function TDAOPedido.GetbyParams(aIdUsuario: Variant): iDAOPedido;
begin
  Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL)
                    .Add('where p.idusuario=:idusuario')
                    .Params('idusuario', FPedido.IdUsuario)
                    .Open
                  .DataSet;
    except
      on E: Exception do
      raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
    if not FDataSet.IsEmpty then
    begin
      FPedido.Id(FDataSet.FieldByName('id').AsInteger);
      QuantidadeRegistro;
    end
    else
      FPedido.Id(0);
  end;
end;

function TDAOPedido.GetbyParams(aNomePessoa: String): iDAOPedido;
begin
  Result := Self;
  try
   try
     FDataSet := FQuery
                   .SQL(FSQL+' where ' + FUteis.Pesquisar('pp.nomepessoa', ';' + aNomePessoa))
                   .Open
                 .DataSet;
   except
     on E: Exception do
     raise exception.Create(FMSG.MSGerroGet+E.Message);
   end;
  finally
    if not FDataSet.IsEmpty then
    begin
      FPedido.Id(FDataSet.FieldByName('id').AsInteger);
      QuantidadeRegistro;
    end
    else
      FPedido.Id(0);
  end;
end;

function TDAOPedido.Post: iDAOPedido;
const
  LSQL=('insert into pedido( '+
                             'idempresa, '+
                             'idpessoa, '+
                             'idpagamento, '+
                             'idusuario, '+
                             'valorproduto, '+
                             'valordesconto, '+
                             'valorreceber, '+
                             'datahoraemissao, '+
                             'status '+
                           ')'+
                             ' values '+
                           '('+
                             ':idempresa, '+
                             ':idpessoa, '+
                             ':idpagamento, '+
                             ':idusuario, '+
                             ':valorproduto, '+
                             ':valordesconto, '+
                             ':valorreceber, '+
                             ':datahoraemissao, '+
                             ':status '+
                            ')'
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    try
      FQuery
        .SQL(LSQL)
          .Params('idempresa'       , FPedido.IdEmpresa)
          .Params('idpessoa'        , FPedido.IdPessoa)
          .Params('idpagamento'     , FPedido.IdPagamento)
          .Params('idusuario'       , FPedido.IdUsuario)
          .Params('valorproduto'    , FPedido.ValorProduto)
          .Params('valordesconto'   , FPedido.ValorDesconto)
          .Params('valorreceber'    , FPedido.ValorReceber)
          .Params('datahoraemissao' , FPedido.DataHoraEmissao)
          .Params('status'          , FPedido.Status)
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
    FPedido.Id(FDataSet.FieldByName('id').AsInteger);
  end;
end;

function TDAOPedido.Put: iDAOPedido;
const
  LSQL=('update pedido set '+
                       'idempresa      =:idempresa, '+
                       'idpessoa       =:idpessoa, '+
                       'idpagamento    =:idpagamento, '+
                       'idusuario      =:idusuario, '+
                       'valorproduto   =:valorproduto, '+
                       'valordesconto  =:valordesconto, '+
                       'valorreceber   =:valorreceber, '+
                       'datahoraemissao=:datahoraemissao, '+
                       'status         =:status '+
                       'where id       =:id '
       );
begin
  Result := Self;

  FConexao.StartTransaction;
  try
    try
      FQuery
        .SQL(LSQL)
          .Params('id'              , FPedido.Id)
          .Params('idempresa'       , FPedido.IdEmpresa)
          .Params('idpessoa'        , FPedido.IdPessoa)
          .Params('idpagamento'     , FPedido.IdPagamento)
          .Params('idusuario'       , FPedido.IdUsuario)
          .Params('valorproduto'    , FPedido.ValorProduto)
          .Params('valordesconto'   , FPedido.ValorDesconto)
          .Params('valorreceber'    , FPedido.ValorReceber)
          .Params('datahoraemissao' , FPedido.DataHoraEmissao)
          .Params('status'          , FPedido.Status)
        .ExecSQL;
    except
      on E: Exception do
      begin
        FConexao.Rollback;
        raise  Exception.Create(FMSG.MSGerroPut+E.Message);
      end;
    end;
  finally
    FConexao.Commit;
  end;
end;


function TDAOPedido.Delete: iDAOPedido;
const
  LSQL=('delete from pedido where id=:id ');
begin
  Result := self;
  FConexao.StartTransaction;
  try
    try
      FQuery.SQL(LSQL)
              .Params('id', FPedido.Id)
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
