{*******************************************************}
{                    API PDV - JSON                     }
{                      ES Sistemas                      }
{          Início do projeto 13/03/2024 10:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Imp.Usuario;

interface

uses
  System.SysUtils,
  Data.DB,

  Model.DAO.Usuario.Interfaces,
  Model.Entidade.Usuario.Interfaces,
  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces,
  Model.Entidade.Imp.Usuario,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp, FireDAC.Comp.Client;

type
  TDAOUsuario = class(TInterfacedObject, iDAOUsuario)
    private
      FUsuario : iEntidadeUsuario<iDAOUsuario>;
      FConexao : iConexao;
      FDataSet : TDataSet;
      FQuery   : iQuery;
   const
      FSQL=('select '+
            'u.id, '+
            'u.idempresa, '+
            'u.nome, '+
            'u.email, '+
            'u.senha, '+
            'u.ativo '+
            'from usuario u');
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOUsuario;

      function DataSet(DataSource : TDataSource) : iDAOUsuario; overload;
      function DataSet                           : TDataSet;    overload;
      function GetAll                            : iDAOUsuario;
      function GetbyId(Id : Variant)             : iDAOUsuario;
      function GetbyParams                       : iDAOUsuario;
      function Post                              : iDAOUsuario;
      function Put                               : iDAOUsuario;
      function Delete                            : iDAOUsuario;

      function This : iEntidadeUsuario<iDAOUsuario>;
  end;

implementation

{ TDAOUsuario }

constructor TDAOUsuario.Create;
begin
  FUsuario := TEntidadeUsuario<iDAOUsuario>.New(Self);
  FConexao := TModelConexaoFiredacMySQL.New;
  FQuery   := TQuery.New;
end;

destructor TDAOUsuario.Destroy;
begin
  inherited;
end;

class function TDAOUsuario.New: iDAOUsuario;
begin
  Result := Self.Create;
end;

function TDAOUsuario.DataSet(DataSource: TDataSource): iDAOUsuario;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAOUsuario.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAOUsuario.GetAll: iDAOUsuario;
begin
  Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL)
                    .Open
                  .DataSet;
    except
     raise Exception.Create('');
    end;
  finally
    //Criar MSG
  end;
end;

function TDAOUsuario.GetbyId(Id: Variant): iDAOUsuario;
begin
  Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL)
                    .Add('where Id=:Id')
                    .Params('Id', Id)
                    .Open
                  .DataSet;
    except
      raise Exception.Create('');
    end;
  finally
    //Criar MSG
  end;
end;

function TDAOUsuario.GetbyParams: iDAOUsuario;
begin
  Result := Self;
  try
   try
     FDataSet := FQuery
                   .SQL(FSQL)//+' where ((lower(email) like lower(:email) and (senha=:senha))) ')
                   .Add('where (lower(email) like lower(:email))')
                   .Add('and (senha=:senha)')
                   .Params('email', FUsuario.EMail)
                   .Params('senha', FUsuario.Senha)
                   .Open
                 .DataSet;
   except
     raise exception.Create('');
   end;
  finally
   //
  end;
end;

function TDAOUsuario.Post: iDAOUsuario;
const
  LSQL=('insert into usuario('+
                             'idempresa, '+
                             'nome, '+
                             'email, '+
                             'senha, '+
                             'ativo '+
                           ')'+
                             ' values '+
                           '('+
                             ':idempresa, '+
                             ':nome, '+
                             ':email, '+
                             ':senha, '+
                             ':ativo ' +
                            ')'
       );
begin
  Result := Self;

  FConexao.StartTransaction;
  try
    try
      FQuery
        .SQL(LSQL)
          .Params('idempresa ', FUsuario.IdEmpresa)
          .Params('nome'      , FUsuario.Nome)
          .Params('email'     , FUsuario.EMail)
          .Params('senha'     , FUsuario.Senha)
          .Params('ativo'     , FUsuario.Ativo)
        .ExecSQL;
    except
      FConexao.Rollback;
      raise Exception.Create('ao tentar salvar registro de Usuários!');
    end;
  finally
    FConexao.Commit;
    FDataSet := FQuery
                    .SQL('select LAST_INSERT_ID () as id')
                    .Open
                    .DataSet;
    FUsuario.Id(FDataSet.FieldByName('id').AsInteger);
  end;
end;

function TDAOUsuario.Put: iDAOUsuario;
const
  LSQL=('update usuario set '+
        'idempresa=:idempresa, '+
        'nome=:nome, '+
        'email=:email, '+
        'senha=:senha, '+
        'ativo=:ativo '+
        'where id=:id '
       );
begin
  Result := Self;

  FConexao.StartTransaction;
  try
    try
      FQuery
        .SQL(LSQL)
          .Params('id'        , FUsuario.Id)
          .Params('idempresa' , FUsuario.IdEmpresa)
          .Params('nome'      , FUsuario.Nome)
          .Params('email'     , FUsuario.EMail)
          .Params('senha'     , FUsuario.Senha)
          .Params('ativo'     , FUsuario.Ativo)
        .ExecSQL;
    except
      FConexao.Rollback;
      raise Exception.Create('ao tentar alterar o Usuário!');
    end;
  finally
    FConexao.Commit;
    //Criar MSG
  end;
end;

function TDAOUsuario.Delete: iDAOUsuario;
const
  LSQL=('delete from usuario where id=:id ');
begin
  Result := self;
  FConexao.StartTransaction;
  try
    try
      FQuery.SQL(LSQL)
               .Params('id', FUsuario.Id)
            .ExecSQL;
    except
      FConexao.Rollback;
      raise Exception.Create('ao tentar excluir o Usuário');
    end;
  finally
    FConexao.Commit;
    //Criar MSG
  end;
end;

function TDAOUsuario.This: iEntidadeUsuario<iDAOUsuario>;
begin
  Result := FUsuario;
end;

end.
