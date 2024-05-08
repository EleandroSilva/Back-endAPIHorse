{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 08/04/2024 22:46           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Imp.Municipio;

interface

uses
  System.SysUtils,
  Data.DB,

  FireDAC.Comp.Client,

  Uteis,
  Uteis.Interfaces,
  Uteis.Tratar.Mensagens,

  Model.DAO.Municipio.Interfaces,
  Model.Entidade.Municipio.Interfaces,
  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces;

type
  TDAOMunicipio = class(TInterfacedObject, iDAOMunicipio)
    private
      FMunicipio : iEntidadeMunicipio<iDAOMunicipio>;
      FConexao   : iConexao;
      FQuery     : iQuery;
      FUteis     : iUteis;
      FMSG       : TMensagens;

      FDataSet   : TDataSet;

   const
      FSQL=('select '+
            'm.id, '+
            'm.ibge, '+
            'm.idestado, '+
            'm.municipio, '+
            'm.uf '+
            'from municipio m '+
            'inner join estado        e on e.idestado = m.idestado '+
            'inner join regiaoestado re on re.id      = e.idregiao ');
      function LoopRegistro (Value : Integer): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOMunicipio;

      function DataSet(DataSource : TDataSource) : iDAOMunicipio; overload;
      function DataSet                           : TDataSet;      overload;
      function GetAll                            : iDAOMunicipio;
      function GetbyId(Id : Variant)             : iDAOMunicipio;
      function GetbyParams                       : iDAOMunicipio;
      function Post                              : iDAOMunicipio;
      function Put                               : iDAOMunicipio;
      function Delete                            : iDAOMunicipio;

      function QuantidadeRegistro : Integer;
      function This : iEntidadeMunicipio<iDAOMunicipio>;
  end;

implementation

uses
  Model.Entidade.Imp.Municipio,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp;

constructor TDAOMunicipio.Create;
begin
  FMunicipio := TEntidadeMunicipio<iDAOMunicipio>.New(Self);
  FConexao   := TModelConexaoFiredacMySQL.New;
  FQuery     := TQuery.New;
  FUteis     := TUteis.New;
  FMSG       := TMensagens.Create;
end;

destructor TDAOMunicipio.Destroy;
begin
  FreeAndNil(FMSG);
  inherited;
end;

class function TDAOMunicipio.New: iDAOMunicipio;
begin
  Result := Self.Create;
end;

function TDAOMunicipio.DataSet(DataSource: TDataSource): iDAOMunicipio;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAOMunicipio.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAOMunicipio.GetAll: iDAOMunicipio;
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
      WriteLn('Erro no TDAOMunicipio.GetAll - ao tentar encontrar Municipio: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
     FMunicipio.Id(FDataSet.FieldByName('id').AsInteger);
     QuantidadeRegistro;
  end
  else
     FMunicipio.Id(0);
end;

function TDAOMunicipio.GetbyId(Id: Variant): iDAOMunicipio;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where m.Id=:Id')
                    .Params('Id', Id)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOMunicipio.GetbyId - ao tentar encontrar Municipio por Id: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FMunicipio.Id(FDataSet.FieldByName('id').AsInteger)
  else
    FMunicipio.Id(0);
end;

function TDAOMunicipio.GetbyParams: iDAOMunicipio;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL+' where ' + FUteis.Pesquisar('m.municipio', ';' + FMunicipio.Municipio))
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOMunicipio.GetbyParams - ao tentar encontrar Municipio por municipio: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FMunicipio.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FMunicipio.Id(0);
end;

function TDAOMunicipio.Post: iDAOMunicipio;
const
  LSQL=('insert into municipio('+
                             'ibge, '+
                             'idestado, '+
                             'municipio, '+
                             'uf '+
                             ')'+
                               ' values '+
                             '('+
                               ':ibge, '+
                               ':idestado, '+
                               ':municipio, '+
                               ':uf '+
                              ')'
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('ibge'      , FMunicipio.IBGE)
        .Params('idestado'  , FMunicipio.IdEstado)
        .Params('municipio' , FMunicipio.Municipio)
        .Params('uf'        , FMunicipio.UF)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOMunicipio.Post - ao tentar incluir novo Municipio: ' + E.Message);
      Abort;
    end;
  end;
  FConexao.Commit;
  FDataSet := FQuery
                .SQL('select LAST_INSERT_ID () as id')
                .Open
                .DataSet;
  FMunicipio.Id(FDataSet.FieldByName('m.id').AsInteger);
end;

function TDAOMunicipio.Put: iDAOMunicipio;
const
  LSQL=('update municipio set '+
                          'ibge     =:ibge, '+
                          'idestado =:idestado, '+
                          'municipio=:municipio, '+
                          'uf       =:uf '+
                          'where id=:id '
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('id'        , FMunicipio.Id)
        .Params('ibge'      , FMunicipio.IBGE)
        .Params('idestado'  , FMunicipio.IdEstado)
        .Params('municipio' , FMunicipio.Municipio)
        .Params('uf'        , FMunicipio.UF)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOMunicipio.Put - ao tentar alterar Municipio: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOMunicipio.Delete: iDAOMunicipio;
const
  LSQL=('delete from municipio where id=:id ');
begin
  Result := self;
  FConexao.StartTransaction;
  try
    FQuery.SQL(LSQL)
                 .Params('id', FMunicipio.Id)
               .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOMunicipio.Delete - ao tentar excluír Municipio: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOMunicipio.LoopRegistro(Value : Integer): Integer;
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

function TDAOMunicipio.QuantidadeRegistro : Integer;
begin
  Result := LoopRegistro(0);
end;

function TDAOMunicipio.This: iEntidadeMunicipio<iDAOMunicipio>;
begin
  Result := FMunicipio;
end;

end.
