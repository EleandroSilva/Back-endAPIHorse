{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 03/04/2024 16:03           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Imp.Endereco.Empresa;

interface

uses
  Data.DB,

  System.SysUtils,

  Uteis.Tratar.Mensagens,

  Model.DAO.Endereco.Empresa.Interfaces,
  Model.Entidade.Endereco.Empresa.Interfaces,
  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces;

type
  TDAOEnderecoEmpresa = class(TInterfacedObject, iDAOEnderecoEmpresa)
    private
      FEnderecoEmpresa : iEntidadeEnderecoEmpresa<iDAOEnderecoEmpresa>;
      FConexao         : iConexao;
      FQuery           : iQuery;
      FMSG             : TMensagens;
      FDataSet         : TDataSet;

      const
      FSQL=('select '+
            'ee.id, '+
            'ee.idempresa, '+
            'ee.idendereco, '+
            'ed.cep, '+
            'ed.tipologradouro, '+
            'ed.logradouro, '+
            'n.numeroendereco, '+
            'n.complementoendereco, '+
            'ed.Bairro, '+
            'ed.ibge, '+
            'm.municipio, '+
            'm.uf '+
            'from enderecoempresa ee '+
            'inner join endereco ed on ed.id        = ee.idendereco '+
            'inner join municipio m on m.ibge       = ed.ibge '+
            'left  join numero    n on n.idendereco = ee.idendereco '
           );
      function LoopRegistro (Value : Integer): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOEnderecoEmpresa;

      function DataSet(DataSource : TDataSource)              : iDAOEnderecoEmpresa; overload;
      function DataSet                                        : TDataSet;            overload;
      function GetAll                                         : iDAOEnderecoEmpresa;
      function GetbyId(Id : Variant)                          : iDAOEnderecoEmpresa;
      function GetbyParams                                    : iDAOEnderecoEmpresa; overload;
      function GetbyParams(const iDAOEnderecoEmpresa)         : iDAOEnderecoEmpresa; overload;
      function GetbyParams(IdEmpresa, IdEndereco : Variant)   : iDAOEnderecoEmpresa; overload;
      function Post                                           : iDAOEnderecoEmpresa;
      function Put                                            : iDAOEnderecoEmpresa;
      function Delete                                         : iDAOEnderecoEmpresa;

      function QuantidadeRegistro : Integer;
      function This : iEntidadeEnderecoEmpresa<iDAOEnderecoEmpresa>;
  end;

implementation

uses
  Model.Entidade.Imp.Endereco.Empresa,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp;

{ TDAOEnderecoEmpresa }

constructor TDAOEnderecoEmpresa.Create;
begin
  FEnderecoEmpresa := TEntidadeEnderecoEmpresa<iDAOEnderecoEmpresa>.New(Self);
  FConexao         := TModelConexaoFiredacMySQL.New;
  FQuery           := TQuery.New;
  FMSG             := TMensagens.Create;
end;

destructor TDAOEnderecoEmpresa.Destroy;
begin
  FreeAndNil(FMSG);
  inherited;
end;

class function TDAOEnderecoEmpresa.New: iDAOEnderecoEmpresa;
begin
  Result := Self.Create;
end;

function TDAOEnderecoEmpresa.DataSet(DataSource: TDataSource): iDAOEnderecoEmpresa;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAOEnderecoEmpresa.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAOEnderecoEmpresa.GetAll: iDAOEnderecoEmpresa;
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
      WriteLn('Erro no TDAOEnderecoEmpresa.GetAll - ao tentar encontrar enderecoempresa todos: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FEnderecoEmpresa.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FEnderecoEmpresa.Id(0);
end;

function TDAOEnderecoEmpresa.GetbyId(Id: Variant): iDAOEnderecoEmpresa;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where ee.id=:id')
                    .Params('id', Id)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOEnderecoEmpresa.GetId - ao tentar encontrar enderecoempresa por Id: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FEnderecoEmpresa.Id(FDataSet.FieldByName('id').AsInteger)
    else
    FEnderecoEmpresa.Id(0);
end;

//uso para listar no json junto com a tabela pai(empresa)
function TDAOEnderecoEmpresa.GetbyParams(const iDAOEnderecoEmpresa): iDAOEnderecoEmpresa;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where ee.idempresa =:idempresa')
                    .Add('and   ee.idendereco=ee.idendereco')
                    .Params('idempresa' , FEnderecoEmpresa.IdEmpresa)
                    .Add('order by ee.idempresa asc')
                    .Add(', ee.idendereco asc')
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOEnderecoEmpresa.GetParams - ao tentar encontrar enderecoempresa: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FEnderecoEmpresa.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FEnderecoEmpresa.Id(0);
end;

function TDAOEnderecoEmpresa.GetbyParams(IdEmpresa, IdEndereco: Variant): iDAOEnderecoEmpresa;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where ee.idempresa =:idempresa')
                    .Add('and   ee.idendereco=:idendereco')
                    .Params('idempresa'  , IdEmpresa)
                    .Params('idendereco' , IdEndereco)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOEnderecoEmpresa.GetParams - ao tentar encontrar enderecoempresa: ' + E.Message);
      Abort;
    end;
  end;
    if not FDataSet.IsEmpty then
      FEnderecoEmpresa.Id(FDataSet.FieldByName('id').AsInteger)
    else
      FEnderecoEmpresa.Id(0);
end;

function TDAOEnderecoEmpresa.GetbyParams: iDAOEnderecoEmpresa;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where ee.idempresa =:idempresa')
                    .Add('and   ee.idendereco=ee.idendereco')
                    .Params('idempresa' , FEnderecoEmpresa.IdEmpresa)
                    .Add('order by ee.idempresa asc')
                    .Add(', ee.idendereco asc')
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOEnderecoEmpresa.GetParams - ao tentar encontrar enderecoempresa: ' + E.Message);
      Abort;
    end;
  end;
    if not FDataSet.IsEmpty then
    begin
      FEnderecoEmpresa.Id(FDataSet.FieldByName('id').AsInteger);
      QuantidadeRegistro;
    end
    else
      FEnderecoEmpresa.Id(0);
end;

function TDAOEnderecoEmpresa.Post: iDAOEnderecoEmpresa;
const
  LSQL=('insert into enderecoempresa( '+
                                    'idempresa, ' +
                                    'idendereco '+
                                    ')'+
                                    ' values '+
                                    '('+
                                    ':idempresa, ' +
                                    ':idendereco '+
                                    ') '
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('idempresa'  , FEnderecoEmpresa.IdEmpresa)
        .Params('idendereco' , FEnderecoEmpresa.IdEndereco)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOEnderecoEmpresa.Post - ao tentar incluir enderecoempresa: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
    FDataSet := FQuery
                    .SQL('select LAST_INSERT_ID () as id ')
                    .Open
                    .DataSet;
    FEnderecoEmpresa.Id(FDataSet.FieldByName('id').AsInteger);
end;

function TDAOEnderecoEmpresa.Put: iDAOEnderecoEmpresa;
const
  LSQL=('update enderecoempresa set '+
                               'idempresa =:idempresa, '+
                               'idendereco=:idendereco '+
                               'where id=:id '
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('id'         , FEnderecoEmpresa.Id)
        .Params('idempresa'  , FEnderecoEmpresa.IdEmpresa)
        .Params('idendereco' , FEnderecoEmpresa.IdEndereco)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOEnderecoEmpresa.Put - ao tentar alterar enderecoempresa: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOEnderecoEmpresa.Delete: iDAOEnderecoEmpresa;
const
  LSQL=('delete from enderecoempresa where id=:id ');
begin
  Result := self;
  FConexao.StartTransaction;
  try
    FQuery.SQL(LSQL)
                 .Params('id', FEnderecoEmpresa.Id)
               .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOEnderecoEmpresa.Delete - ao tentar excluír enderecoempresa: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOEnderecoEmpresa.LoopRegistro(Value : Integer): Integer;
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

function TDAOEnderecoEmpresa.QuantidadeRegistro : Integer;
begin
  Result := LoopRegistro(0);
end;

function TDAOEnderecoEmpresa.This: iEntidadeEnderecoEmpresa<iDAOEnderecoEmpresa>;
begin
  Result := FEnderecoEmpresa;
end;

end.
