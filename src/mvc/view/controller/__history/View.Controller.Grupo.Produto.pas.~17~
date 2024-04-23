{*******************************************************}
{                    API PDV - JSON                     }
{                      ES Sistemas                      }
{          Início do projeto 18/03/2024 13:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit View.Controller.Grupo.Produto;

interface

uses
  System.SysUtils,
  System.JSON,

  Data.DB,

  FireDAC.Comp.Client,

  DataSet.Serialize,
  Horse,
  Horse.BasicAuthentication,

  Controller.Interfaces,
  Imp.Controller;

type
  TViewControllerGrupoProduto = class
    private
      FTexto      : String;
      FJSONArray  : TJSONArray;
      FBody       : TJSONValue;
      FDataSource : TDataSource;
      FController : iController;

      procedure GetAll (Req: THorseRequest; Res: THorseResponse; Next : TProc);
      procedure GetbyId(Req: THorseRequest; Res: THorseResponse; Next : TProc);
      procedure Post   (Req: THorseRequest; Res: THorseResponse; Next : TProc);
      procedure Put    (Req: THorseRequest; Res: THorseResponse; Next : TProc);
      procedure Delete (Req: THorseRequest; Res: THorseResponse; Next : TProc);

      procedure Registry;
    public
      constructor Create;
      destructor Destroy; override;
  end;

implementation

{ TViewControllerGrupoProduto }

constructor TViewControllerGrupoProduto.Create;
begin
  FController := TController.New;
  FDataSource := TDataSource.Create(nil);
  Registry;
end;

destructor TViewControllerGrupoProduto.Destroy;
begin
  FreeAndNil(FDataSource);
  inherited;
end;

procedure TViewControllerGrupoProduto.GetAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      if Req.Query.Field('nome').AsString<>'' then
        FController
          .FactoryEntidade
            .DAOGrupoProduto
              .This
                .Nome(Req.Query.Field('Nome').AsString)
              .&End
            .GetbyParams
            .DataSet(FDataSource)
      else
        FController
          .FactoryEntidade
            .DAOGrupoProduto
              .GetAll
              .DataSet(FDataSource);

     FJSONArray := FDataSource.DataSet.ToJSONArray();
     FTexto     := FJSONArray.ToString;
     Res.Send<TJSONArray>(FJSONArray);
    except
     raise Exception.Create(' ao tentar encontrar registro de Usuário!');
   End;
  finally
    //informar msg de resposta do Horse, ver como funciona
  end;
end;

procedure TViewControllerGrupoProduto.GetbyId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Try
     try
       FController
         .FactoryEntidade
           .DAOGrupoProduto
             .GetbyId(Req.Params['id'].ToInt64)
             .DataSet(FDataSource);

       FJSONArray := FDataSource.DataSet.ToJSONArray();
       Res.Send<TJSONArray>(FJSONArray);
   except
     raise Exception.Create(' ao tentar encontrar registro');
   End;
   Finally
     //informar msg de resposta do Horse, ver como funciona
   End;
end;

procedure TViewControllerGrupoProduto.Post(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FBody := Req.Body<TJSONObject>;

      FController
        .FactoryEntidade
          .DAOGrupoProduto
            .This
              .IdEmpresa(FBody.GetValue<integer>('idempresa'))
              .Nome     (FBody.GetValue<String> ('nome'))
              .Ativo    (FBody.GetValue<integer>('ativo'))
            .&End
          .Post;
  except
    raise Exception.Create(' ao tentar incuir registro!');
  end;
  finally
    //informar msg de resposta do Horse, ver como funciona
  end;
end;

procedure TViewControllerGrupoProduto.Put(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FBody := Req.Body<TJSONObject>;

      FController
        .FactoryEntidade
          .DAOGrupoProduto
            .This
              .Id       (Req.Params['id'].ToInt64)
              .IdEmpresa(FBody.GetValue<Integer>('idempresa'))
              .Nome     (FBody.GetValue<String> ('nome'))
              .Ativo    (FBody.GetValue<Integer>('ativo'))
            .&End
          .Put;
  except
    raise Exception.Create(' ao tentar atualizar registro');
  end;
  finally
    //informar msg de resposta do Horse, ver como funciona sucesso
  end;
end;

procedure TViewControllerGrupoProduto.Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FController
        .FactoryEntidade
          .DAOGrupoProduto
            .This
              .Id(Req.Params['id'].ToInt64)
            .&End
          .Delete;
    except
      raise Exception.Create(' ao tentar excluir registro');
    End;
  Finally
    //informar msg de resposta do Horse, ver como funciona
  End;
end;

procedure TViewControllerGrupoProduto.Registry;
begin
  THorse
      .Group
      .Prefix('ess')
      .Get   ('/grupos/produtos'     , GetAll)
      .Get   ('/grupos/produtos/:id' , GetbyId)
      .Post  ('grupos/produtos'      , Post)
      .Put   ('grupos/produtos/:id'  , Put)
      .Delete('grupos/produtos/:id'  , Delete);
end;

end.
