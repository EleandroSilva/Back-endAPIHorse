{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 18/03/2024 13:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Imp.Empresa;

interface

uses
  System.SysUtils,
  Data.DB,

  Uteis,
  Uteis.Interfaces,
  Uteis.Tratar.Mensagens,

  Model.DAO.Empresa.Interfaces,
  Model.Entidade.Empresa.Interfaces,
  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces;

type
  TDAOEmpresa = class(TInterfacedObject, iDAOEmpresa)
    private
      FEmpresa : iEntidadeEmpresa<iDAOEmpresa>;
      FConexao : iConexao;
      FQuery   : iQuery;
      FUteis   : iUteis;
      FMSG     : TMensagens;
      FDataSet : TDataSet;

   const
      FSQL=('select '+
            'e.Id, '+
            'e.cnpj, '+
            'e.inscricaoestadual,  '+
            'e.nomeempresarial, '+
            'e.nomefantasia, '+
            'e.idnaturezajuridica, '+
            'nj.nomenaturezajuridica, '+
            'e.datahoraemissao, '+
            'e.datasituacaocadastral, '+
            'e.ativo '+
            'from empresa e '+
            'left join naturezajuridica nj on nj.id=e.idnaturezajuridica '
             );
      function LoopRegistro (Value : Integer): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOEmpresa;

      function DataSet(DataSource : TDataSource) : iDAOEmpresa; overload;
      function DataSet                           : TDataSet;    overload;
      function GetAll                            : iDAOEmpresa;
      function GetbyId(Id : Variant)             : iDAOEmpresa;
      function GetbyParams                       : iDAOEmpresa; overload;
      function GetbyParams(aCNPJ: String)        : iDAOEmpresa; overload;
      function Post                              : iDAOEmpresa;
      function Put                               : iDAOEmpresa;
      function Delete                            : iDAOEmpresa;
      function QuantidadeRegistro                : Integer;

      function This : iEntidadeEmpresa<iDAOEmpresa>;
  end;

implementation

uses
  Model.Entidade.Imp.Empresa,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp;

{ TDAOEmpresa }

constructor TDAOEmpresa.Create;
begin
  FEmpresa := TEntidadeEmpresa<iDAOEmpresa>.New(Self);
  FConexao := TModelConexaoFiredacMySQL.New;
  FQuery   := TQuery.New;
  FUteis   := TUteis.New;
  FMSG     := TMensagens.Create;
end;

destructor TDAOEmpresa.Destroy;
begin
  FreeAndNil(FMSG);
  inherited;
end;

class function TDAOEmpresa.New: iDAOEmpresa;
begin
  Result := Self.Create;
end;

function TDAOEmpresa.DataSet(DataSource: TDataSource): iDAOEmpresa;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAOEmpresa.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAOEmpresa.GetAll: iDAOEmpresa;
begin
  Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL)
                    .Add('order by e.id asc')
                    .Open
                  .DataSet;
    except
      on E:Exception do
     raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
    if not FDataSet.IsEmpty then
    begin
      FEmpresa.Id(FDataSet.FieldByName('id').AsInteger);
      QuantidadeRegistro;
    end
    else
      FEmpresa.Id(0);
  end;
end;

function TDAOEmpresa.GetbyId(Id: Variant): iDAOEmpresa;
begin
  Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL)
                    .Add('where e.id=:id')
                    .Params('Id', Id)
                    .Open
                  .DataSet;
    except
      on E:Exception do
      raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
    if not FDataSet.IsEmpty then
      FEmpresa.Id(FDataSet.FieldByName('id').AsInteger)
    else
      FEmpresa.Id(0);
  end;
end;

function TDAOEmpresa.GetbyParams(aCNPJ: String): iDAOEmpresa;
begin
  Result := Self;
  FUteis.ValidaCnpjCeiCpf(aCNPJ, True);
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL)
                    .Add('where e.cnpj=:cnpj')
                    .Params('cnpj', aCNPJ)
                    .Open
                  .DataSet;
    except
      on E: Exception do
      begin
        WriteLn('Erro ao tentar filtrar tabela empresa pelo cnpj: ' + E.Message);
        raise Exception.Create(FMSG.MSGerroGet+E.Message);
      end;
    end;
  finally
    if not FDataSet.IsEmpty then
      FEmpresa.Id(FDataSet.FieldByName('id').AsInteger)
    else
      FEmpresa.Id(0);
  end;
end;

function TDAOEmpresa.GetbyParams: iDAOEmpresa;
begin
  Result := Self;
  try
   try
     FDataSet := FQuery
                   .SQL(FSQL+' where ' + FUteis.Pesquisar('e.nomeempresarial', ';' + FEmpresa.NomeEmpresarial))
                   .Open
                 .DataSet;


   except
     on E:Exception do
     begin
       WriteLn('Erro ao tentar filtrar tabela empresa pelo nomeempresa: ' + E.Message);
       raise exception.Create(FMSG.MSGerroGet+E.Message);
     end;
   end;
  finally
   if not FDataSet.IsEmpty then
   begin
     FEmpresa.Id(FDataSet.FieldByName('id').AsInteger);
     QuantidadeRegistro;
   end
   else
     FEmpresa.Id(0);
  end;
end;

function TDAOEmpresa.Post: iDAOEmpresa;
const
  LSQL=('insert into empresa( '+
                             'cnpj, '+
                             'inscricaoestadual, ' +
                             'nomeempresarial, '+
                             'nomefantasia, ' +
                             'idnaturezajuridica, '+
                             'datahoraemissao, '+
                             'datasituacaocadastral, ' +
                             'ativo '+
                           ')'+
                             ' values '+
                           '('+
                             ':cnpj, '+
                             ':inscricaoestadual, ' +
                             ':nomeempresarial, '+
                             ':nomefantasia, ' +
                             ':idnaturezajuridica, '+
                             ':datahoraemissao, '+
                             ':datasituacaocadastral, ' +
                             ':ativo '+
                            ') '
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    try
      FQuery
        .SQL(LSQL)
          .Params('cnpj'                 , FEmpresa.CNPJ)
          .Params('inscricaoestadual'    , Fempresa.InscricaoEstadual)
          .Params('nomeempresarial'      , FEmpresa.NomeEmpresarial)
          .Params('nomefantasia'         , FEmpresa.NomeFantasia)
          .Params('idnaturezajuridica'   , FEmpresa.IdNaturezaJuridica)
          .Params('datahoraemissao'      , FEmpresa.DataHoraEmissao)
          .Params('datasituacaocadastral', FEmpresa.DataSituacaoCadastral)
          .Params('ativo'                , FEmpresa.Ativo)
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
                    .SQL('select LAST_INSERT_ID () as id ')
                    .Open
                    .DataSet;
    FEmpresa.Id(FDataSet.FieldByName('id').AsInteger);
  end;
end;

function TDAOEmpresa.Put: iDAOEmpresa;
const
  LSQL=('update empresa set '+
                        'cnpj                 =:cnpj, '+
                        'inscricaoestadual    =:inscricaoestadual, '+
                        'nomeempresarial      =:nomeempresarial, '+
                        'nomefantasia         =:nomefantasia, '+
                        'idnaturezajuridica   =:idnaturezajuridica, '+
                        'datahoraemissao      =:datahoraemissao, '+
                        'datasituacaocadastral=:datasituacaocadastral, '+
                        'ativo                =:ativo '+
                        'where id=:id '
       );
begin
  Result := Self;

  FConexao.StartTransaction;
  try
    try
      FQuery
        .SQL(LSQL)
          .Params('id'                    , FEmpresa.Id)
          .Params('cnpj'                  , FEmpresa.CNPJ)
          .Params('inscricaoestadual'     , FEmpresa.InscricaoEstadual)
          .Params('nomeempresarial'       , FEmpresa.NomeEmpresarial)
          .Params('nomefantasia'          , FEmpresa.NomeFantasia)
          .Params('idnaturezajuridica'    , FEmpresa.IdNaturezaJuridica)
          .Params('datahoraemissao'       , FEmpresa.DataHoraEmissao)
          .Params('datasituacaocadastral' , FEmpresa.DataSituacaoCadastral)
          .Params('ativo'                 , FEmpresa.Ativo)
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

function TDAOEmpresa.Delete: iDAOEmpresa;
const
  LSQL=('delete from empresa where id=:id ');
begin
  Result := self;
  FConexao.StartTransaction;
  try
    try
      FQuery.SQL(LSQL)
               .Params('id', FEmpresa.Id)
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

function TDAOEmpresa.LoopRegistro(Value : Integer): Integer;
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

function TDAOEmpresa.QuantidadeRegistro : Integer;
begin
  Result := LoopRegistro(0);
end;

function TDAOEmpresa.This: iEntidadeEmpresa<iDAOEmpresa>;
begin
  Result := FEmpresa;
end;

end.
