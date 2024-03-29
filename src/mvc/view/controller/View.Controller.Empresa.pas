{*******************************************************}
{                    API PDV - JSON                     }
{                      ES Sistemas                      }
{          In�cio do projeto 13/03/2024 17:18           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit View.Controller.Empresa;

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
  TViewControllerEmpresa = class
    private
      FTexto      : String;
      FJSONObject : TJSONObject;
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

{ TViewControllerEmpresa }

constructor TViewControllerEmpresa.Create;
begin
  FController := TController.New;
  FDataSource := TDataSource.Create(nil);
  Registry;
end;

destructor TViewControllerEmpresa.Destroy;
begin
  inherited;
end;

procedure TViewControllerEmpresa.GetAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      if ((Req.Query.Field('cnpj').AsString<>'') or (Req.Query.Field('nomeempresarial').AsString<>'')) then
        FController
          .FactoryEntidade
            .DAOEmpresa
              .This
                .CNPJ           (Req.Query.Field('cnpj').AsString)
                .NomeEmpresarial(Req.Query.Field('nomeempresarial').AsString)
              .&End
            .GetbyParams
            .DataSet(FDataSource)
      else
        FController
          .FactoryEntidade
            .DAOEmpresa
              .GetAll
              .DataSet(FDataSource);

     FJSONArray := FDataSource.DataSet.ToJSONArray();
     FTexto     := FJSONArray.ToString;
     Res.Send<TJSONArray>(FJSONArray);
    except
     raise Exception.Create(' ao tentar encontrar registro de Usu�rio!');
   End;
  finally
    //informar msg de resposta do Horse, ver como funciona
  end;
end;

procedure TViewControllerEmpresa.GetbyId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
   Try
     FController
       .FactoryEntidade
         .DAOEmpresa
           .GetbyId(Req.Params['id'].ToInt64)
           .DataSet(FDataSource);

     FJSONArray := FDataSource.DataSet.ToJSONArray();
     Res.Send<TJSONArray>(FJSONArray);
   Finally
    //criar msg horse
   End;
end;

procedure TViewControllerEmpresa.Post(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FBody := Req.Body<TJSONObject>;

      FController
        .FactoryEntidade
          .DAOEmpresa
            .This
              .IdContato            (FBody.GetValue<integer>  ('idcontato'))
              .IdLogradouro         (FBody.GetValue<integer>  ('idlogradouro'))
              .CNPJ                 (FBody.GetValue<String>   ('CNPJ'))
              .InscricaoEstadual    (FBody.GetValue<String>   ('inscricaoestadual'))
              .NomeEmpresarial      (FBody.GetValue<String>   ('nomeempresarial'))
              .NomeFantasia         (FBody.GetValue<String>   ('nomefantasia'))
              .NaturezaJuridica     (FBody.GetValue<String>   ('naturezajuridica'))
              .DataEmissao          (FBody.GetValue<TDateTime>('dataemisao'))
              .DataSituacaoCadastral(FBody.GetValue<TDateTime>('datasituacaocadastral'))
              .Ativo                (FBody.GetValue<integer>  ('ativo'))
            .&End
          .Post;
  except
    raise Exception.Create(' ao tentar incuir registro!');
  end;
  finally
    //informar msg de resposta do Horse, ver como funciona
  end;
end;

procedure TViewControllerEmpresa.Put(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FBody := Req.Body<TJSONObject>;

      FController
        .FactoryEntidade
          .DAOEmpresa
            .This
              .Id                   (Req.Params['id'].ToInt64)
              .IdContato            (FBody.GetValue<Integer>  ('idcontato'))
              .IdLogradouro         (FBody.GetValue<Integer>  ('idlogradouro'))
              .CNPJ                 (FBody.GetValue<String>   ('cnpj'))
              .InscricaoEstadual    (FBody.GetValue<String>   ('inscricaoestadual'))
              .NomeEmpresarial      (FBody.GetValue<String>   ('nomeempresarial'))
              .NomeFantasia         (FBody.GetValue<String>   ('nomefantasia'))
              .NaturezaJuridica     (FBody.GetValue<String>   ('naturezajuridica'))
              .DataEmissao          (FBody.GetValue<TDateTime>('dataemissao'))
              .DataSituacaoCadastral(FBody.GetValue<TDateTime>('datasituacaocadastral'))
              .Ativo                (FBody.GetValue<Integer>  ('ativo'))
            .&End
          .Put;
  except
    raise Exception.Create(' ao tentar atualizar registro');
  end;
  finally
    //informar msg de resposta do Horse, ver como funciona sucesso
  end;
end;

procedure TViewControllerEmpresa.Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FController
        .FactoryEntidade
          .DAOEmpresa
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

procedure TViewControllerEmpresa.Registry;
begin
  THorse
      .Group
        .Prefix  ('ess')
          .Get   ('/empresas/:id' , GetbyId)
          .Get   ('/empresas'     , GetAll)
          .Post  ('empresas'      , Post)
          .Put   ('empresas/:id'  , Put)
          .Delete('empresas/:id'  , Delete);
end;

end.
