{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 08/04/2024 22:46           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Imp.Regiao.Estado;

interface

uses
  System.SysUtils,
  Data.DB,

  FireDAC.Comp.Client,

  Uteis,
  Uteis.Interfaces,
  Uteis.Tratar.Mensagens,

  Model.DAO.Regiao.Estado.Interfaces,
  Model.Entidade.Regiao.Estado.Interfaces,
  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces;

type
  TDAORegiaoEstado = class(TInterfacedObject, iDAORegiaoEstado)
    private
      FRegiaoEstado : iEntidadeRegiaoEstado<iDAORegiaoEstado>;
      FConexao      : iConexao;
      FQuery        : iQuery;
      FUteis        : iUteis;
      FMSG          : TMensagens;

      FDataSet      : TDataSet;

      FKey     : String;
      FValue   : String;
   const
      FSQL=('select '+
            're.id, '+
            're.regiao '+
            'from regiaoestado re '
            );
      function LoopRegistro (Value : Integer): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAORegiaoEstado;

      function DataSet(DataSource : TDataSource) : iDAORegiaoEstado; overload;
      function DataSet                           : TDataSet;         overload;
      function GetAll                            : iDAORegiaoEstado;
      function GetbyId(Id : Variant)             : iDAORegiaoEstado;
      function GetbyParams                       : iDAORegiaoEstado;
      function Post                              : iDAORegiaoEstado;
      function Put                               : iDAORegiaoEstado;
      function Delete                            : iDAORegiaoEstado;

      function QuantidadeRegistro : Integer;
      function This : iEntidadeRegiaoEstado<iDAORegiaoEstado>;
  end;

implementation

uses
  Model.Entidade.Imp.Regiao.Estado,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp;

constructor TDAORegiaoEstado.Create;
begin
  FRegiaoEstado  := TEntidadeRegiaoEstado<iDAORegiaoEstado>.New(Self);
  FConexao       := TModelConexaoFiredacMySQL.New;
  FQuery         := TQuery.New;
  FUteis         := TUteis.New;
  FMSG           := TMensagens.Create;
end;

destructor TDAORegiaoEstado.Destroy;
begin
  FreeAndNil(FMSG);
  inherited;
end;

class function TDAORegiaoEstado.New: iDAORegiaoEstado;
begin
  Result := Self.Create;
end;

function TDAORegiaoEstado.DataSet(DataSource: TDataSource): iDAORegiaoEstado;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAORegiaoEstado.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAORegiaoEstado.GetAll: iDAORegiaoEstado;
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
      WriteLn('Erro no TDAORegiaoEstado.GetAll - ao tentar encontrar regiaoestado todas: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FRegiaoEstado.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FRegiaoEstado.Id(0);
end;

function TDAORegiaoEstado.GetbyId(Id: Variant): iDAORegiaoEstado;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where Id=:Id')
                    .Params('Id', Id)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAORegiaoEstado.GetbyId - ao tentar encontrar regiaoestado por Id: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FRegiaoEstado.Id(FDataSet.FieldByName('id').AsInteger)
    else
    FRegiaoEstado.Id(0);
end;

function TDAORegiaoEstado.GetbyParams: iDAORegiaoEstado;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL+' where ' + FUteis.Pesquisar('re.regiao', ';' + FRegiaoEstado.Regiao))
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAORegiaoEstado.GetbyParams - ao tentar encontrar regiaoestado regiao: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FRegiaoEstado.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FRegiaoEstado.Id(0);
end;

function TDAORegiaoEstado.Post: iDAORegiaoEstado;
const
  LSQL=('insert into regiaoestado('+
                             'regiao '+
                             ')'+
                             ' values '+
                             '('+
                             ':regiao '+
                             ')'
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('regiao' , FRegiaoEstado.Regiao)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAORegiaoEstado.Post - ao tentar incluir regiaoestado todas: ' + E.Message);
      Abort;
    end;
  end;
  FConexao.Commit;
  FDataSet := FQuery
                .SQL('select LAST_INSERT_ID () as id')
                .Open
                .DataSet;
  FRegiaoEstado.Id(FDataSet.FieldByName('id').AsInteger);
end;

function TDAORegiaoEstado.Put: iDAORegiaoEstado;
const
  LSQL=('update regiaoestado set '+
                            'regiao=:regiao '+
                            'where id=:id '
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('id'     , FRegiaoEstado.Id)
        .Params('regiao' , FRegiaoEstado.Regiao)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAORegiaoEstado.Put - ao tentar alterar regiaoestado: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAORegiaoEstado.Delete: iDAORegiaoEstado;
const
  LSQL=('delete from regiaoestado where id=:id ');
begin
  Result := self;
  FConexao.StartTransaction;
  try
    FQuery.SQL(LSQL)
                 .Params('id', FRegiaoEstado.Id)
               .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAORegiaoEstado.Put - ao tentar exclu�r regiaoestado: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAORegiaoEstado.LoopRegistro(Value : Integer): Integer;
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

function TDAORegiaoEstado.QuantidadeRegistro : Integer;
begin
  Result := LoopRegistro(0);
end;

function TDAORegiaoEstado.This: iEntidadeRegiaoEstado<iDAORegiaoEstado>;
begin
  Result := FRegiaoEstado;
end;

end.
