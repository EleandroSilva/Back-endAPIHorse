{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 03/04/2024 16:03           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Imp.Pessoa;

interface

uses
  System.SysUtils,
  Data.DB,

  Uteis,
  Uteis.Interfaces,
  Uteis.Tratar.Mensagens,

  Model.DAO.Pessoa.Interfaces,
  Model.Entidade.Pessoa.Interfaces,
  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces;

type
  TDAOPessoa = class(TInterfacedObject, iDAOPessoa)
    private
      FPessoa  : iEntidadePessoa<iDAOPessoa>;
      FConexao : iConexao;
      FQuery   : iQuery;
      FUteis   : iUteis;
      FMSG     : TMensagens;
      FDataSet : TDataSet;
   const
        FSQL= ('select '+
               'p.id, '+
               'p.idempresa, '+
               'p.idusuario, '+
               'p.cpfcnpj, '+
               'p.rgie, '+
               'p.nomepessoa, '+
               'p.sobrenome, '+
               'case when p.FisicaJuridica =''F'' then ''Física'' else ''Jurídica'' '+
               'end FisicaJuridica, '+
               'p.FisicaJuridica as FJ, '+
               'case when p.sexo = ''M'' then ''Masculino'' else ''Feminimo'' '+
               'end sexo, '+
               'p.sexo as MF, '+
               'case '+
               'when p.tipopessoa =''A'' then ''Ambos'' '+
               'when p.tipopessoa =''C'' then ''Cliente'' '+
               'when p.tipopessoa =''F'' then ''Fornecedor'' '+
               'end pessoatipo,  '+
               'p.tipopessoa, '+
               'p.datahoraemissao, '+
               'p.datanascimento, '+
               'p.ativo '+
               'from pessoa p '
              );
      function LoopRegistro (Value : Integer): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOPessoa;
      function DataSet(DataSource : TDataSource)         : iDAOPessoa; overload;
      function DataSet                                   : TDataSet;   overload;
      function GetAll                                    : iDAOPessoa;
      function GetbyId(Id : Variant)                     : iDAOPessoa;
      function GetbyParams                               : iDAOPessoa; overload;
      function GetbyParams(CPFCNPJ : String)             : iDAOPessoa; overload;
      function GetbyParams(Key: Integer; Value : String) : iDAOPessoa; overload;
      function Post                                      : iDAOPessoa;
      function Put                                       : iDAOPessoa;
      function Delete                                    : iDAOPessoa;

      function QuantidadeRegistro : Integer;
      function This : iEntidadePessoa<iDAOPessoa>;
  end;

implementation

uses
  Model.Entidade.Imp.Pessoa,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp;

{ TDAOPessoa }

constructor TDAOPessoa.Create;
begin
  FPessoa  := TEntidadePessoa<iDAOPessoa>.New(Self);
  FConexao := TModelConexaoFiredacMySQL.New;
  FQuery   := TQuery.New;
  FUteis   := TUteis.New;
  FMSG     := TMensagens.Create;
end;

destructor TDAOPessoa.Destroy;
begin
  FreeAndNil(FMSG);
  inherited;
end;

class function TDAOPessoa.New: iDAOPessoa;
begin
  Result := Self.Create;
end;


function TDAOPessoa.DataSet(DataSource: TDataSource): iDAOPessoa;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAOPessoa.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAOPessoa.GetAll: iDAOPessoa;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('order by p.id asc')
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOPessoa.GetAll - ao tentar encontrar pessoa todas: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FPessoa.Id(FDataSet.FieldByName('id').AsInteger)
    else
    FPessoa.Id(0);
end;

function TDAOPessoa.GetbyId(Id: Variant): iDAOPessoa;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where p.id=:id')
                    .Params('Id', Id)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOPessoa.GetbyId - ao tentar encontrar pessoa por Id: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FPessoa.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FPessoa.Id(0);
end;

function TDAOPessoa.GetbyParams(Key: Integer; Value : String): iDAOPessoa;
begin
  Result := Self;
  try
    case Key of
      0 : FDataSet := FQuery
                         .SQL(FSQL+' where ' + FUteis.Pesquisar('p.nomepessoa', ';' + Value))
                         .Open
                      .DataSet;
      1 : FDataSet := FQuery
                         .SQL(FSQL+' where ' + FUteis.Pesquisar('p.sobrenome', ';' + Value))
                         .Open
                      .DataSet;
    end;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOPessoa.GetbyParams - ao tentar encontrar pessoa Key+Value: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FPessoa.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FPessoa.Id(0);
end;

function TDAOPessoa.GetbyParams(CPFCNPJ: String): iDAOPessoa;
begin
  Result := Self;
  FUteis.ValidaCnpjCeiCpf(CPFCNPJ, True);
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where e.cpfcnpj=:cpfcnpj')
                    .Params('cpfcnpj', CPFCNPJ)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOPessoa.GetbyParams - ao tentar encontrar pessoa CPFCNPJ: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FPessoa.Id(FDataSet.FieldByName('id').AsInteger)
    else
    FPessoa.Id(0);
end;

function TDAOPessoa.GetbyParams: iDAOPessoa;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL+' where ' + FUteis.Pesquisar('p.nomepessoa', ';' + FPessoa.NomePessoa))
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOPessoa.GetbyParams - ao tentar encontrar pessoa nomepessoa: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FPessoa.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FPessoa.Id(0);
end;

function TDAOPessoa.Post: iDAOPessoa;
const
  LSQL=('insert into pessoa( '+
                           'idempresa, '+
                           'idusuario, '+
                           'cpfcnpj, '+
                           'rgie, ' +
                           'nomepessoa, '+
                           'sobrenome, ' +
                           'fisicajuridica, '+
                           'sexo, '+
                           'tipopessoa, ' +
                           'datahoraemissao, '+
                           'datanascimento, '+
                           'ativo '+
                           ')'+
                           ' values '+
                           '( '+
                           ':idempresa, '+
                           ':idusuario, '+
                           ':cpfcnpj, '+
                           ':rgie, ' +
                           ':nomepessoa, '+
                           ':sobrenome, ' +
                           ':fisicajuridica, '+
                           ':sexo, '+
                           ':tipopessoa, ' +
                           ':datahoraemissao, '+
                           ':ativo '+
                           ')'
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('idempresa'       , FPessoa.IdEmpresa)
        .Params('idusuario'       , FPessoa.IdUsuario)
        .Params('cpfcnpj'         , FPessoa.CPFCNPJ)
        .Params('rgie'            , FPessoa.RGIE)
        .Params('nomepessoa'      , FPessoa.NomePessoa)
        .Params('sobrenome'       , FPessoa.SobreNome)
        .Params('fisicajuridica'  , FPessoa.FisicaJuridica)
        .Params('sexo'            , FPessoa.Sexo)
        .Params('tipopessoa'      , FPessoa.TipoPessoa)
        .Params('datahoraemissao' , FPessoa.DataHoraEmissao)
        .Params('datanascimento'  , FPessoa.DataNascimento)
        .Params('ativo'           , FPessoa.Ativo)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOPessoa.Post - ao tentar incluir nova pessoa: ' + E.Message);
      Abort;
    end;
  end;
  FConexao.Commit;
  FDataSet := FQuery
                .SQL('select LAST_INSERT_ID () as id')
                .Open
                .DataSet;
  FPessoa.Id(FDataSet.FieldByName('id').AsInteger);
end;

function TDAOPessoa.Put: iDAOPessoa;
const
  LSQL=('update pessoa set '+
                        'idempresa      =:idempresa, '+
                        'idusuario      =:idusuario, '+
                        'cpfcnpj        =:cpfcnpj, '+
                        'rgie           =:rgie, '+
                        'nomepessoa     =:nome, '+
                        'sobrenome      =:nomefantasia, '+
                        'fisicajuridica =:fisicajuridica, '+
                        'sexo           =:sexo, '+
                        'tipopessoa     =:tipopessoa, '+
                        'datahoraemissao=:datahoraemissao, '+
                        'datanascimento =:datanascimento, '+
                        'ativo          =:ativo '+
                        'where id=:id '
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('id'              , FPessoa.Id)
        .Params('idempresa'       , FPessoa.IdEmpresa)
        .Params('idusuario'       , FPessoa.IdUsuario)
        .Params('cpfcnpj'         , FPessoa.CPFCNPJ)
        .Params('rgie'            , FPessoa.RGIE)
        .Params('nomepessoa'      , FPessoa.NomePessoa)
        .Params('sobrenome'       , FPessoa.SobreNome)
        .Params('fisicajuridica'  , FPessoa.FisicaJuridica)
        .Params('sexo'            , FPessoa.Sexo)
        .Params('tipopessoa'      , FPessoa.TipoPessoa)
        .Params('datahoraemissao' , FPessoa.DataHoraEmissao)
        .Params('datanascimento'  , FPessoa.DataNascimento)
        .Params('ativo'           , FPessoa.Ativo)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOPessoa.Put - ao tentar alterar pessoa: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOPessoa.Delete: iDAOPessoa;
const
  LSQL=('delete from pessoa where id=:id ');
begin
  Result := self;
  FConexao.StartTransaction;
  try
    FQuery.SQL(LSQL)
                 .Params('id', FPessoa.Id)
               .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOPessoa.Delete - ao tentar excluír pessoa: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOPessoa.LoopRegistro(Value : Integer): Integer;
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

function TDAOPessoa.QuantidadeRegistro : Integer;
begin
  Result := LoopRegistro(0);
end;

function TDAOPessoa.This: iEntidadePessoa<iDAOPessoa>;
begin
  Result := FPessoa;
end;

end.
