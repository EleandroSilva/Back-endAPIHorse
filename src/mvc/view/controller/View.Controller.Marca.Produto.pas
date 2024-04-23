{*******************************************************}
{                    API PDV - JSON                     }
{                     Be More Web                       }
{          Início do projeto 18/03/2024 13:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                       2003/2024                       }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit View.Controller.Marca.Produto;

interface

uses
  System.SysUtils,
  System.JSON,
  Data.DB,
  FireDAC.Comp.Client,
  DataSet.Serialize,
  Horse,
  Horse.BasicAuthentication,
  Controller.Interfaces;
type
  TViewControllerMarcaProduto = class
    private
      FBody       : TJSONValue;
      FJSONObject : TJSONObject;
      FJSONArray  : TJSONArray;
      FDataSource : TDataSource;
      FController : iController;
      FQuantidadeRegistro : Integer;

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

uses
  Imp.Controller;

{ TViewControllerMarcaProduto }

constructor TViewControllerMarcaProduto.Create;
begin
  FController := TController.New;
  FDataSource := TDataSource.Create(nil);
  Registry;
end;

destructor TViewControllerMarcaProduto.Destroy;
begin
  FreeAndNil(FDataSource);
  inherited;
end;

procedure TViewControllerMarcaProduto.GetAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      if Req.Query.Field('nomemarca').AsString<>'' then
        FQuantidadeRegistro := FController
                                .FactoryEntidade
                                  .DAOMarcaProduto
                                    .This
                                      .NomeMarca(Req.Query.Field('nomemarca').AsString)
                                    .&End
                                    .GetbyParams
                                  .DataSet(FDataSource)
                                  .QuantidadeRegistro
      else
        FQuantidadeRegistro:= FController
                              .FactoryEntidade
                                .DAOMarcaProduto
                                  .GetAll
                                .DataSet(FDataSource)
                                .QuantidadeRegistro;

     if FQuantidadeRegistro > 1  then
     begin
       FJSONArray := FDataSource.DataSet.ToJSONArray();
       Res.Send<TJSONArray>(FJSONArray);
     end
     else
     begin
       FJSONObject := FDataSource.DataSet.ToJSONObject();
       Res.Send<TJSONObject>(FJSONObject);
     end;
   except
     on E: Exception do
     begin
       Res.Status(500).Send('Ocorreu um erro interno no servidor'+E.Message);
       Exit;
     end;
   End;
  finally
    if FDataSource.DataSet.IsEmpty then
      Res.Status(404).Send('Registro não encontrado!')
    else
      Res.Status(201).Send('Registro encontrado com sucesso!');
  end;
end;

procedure TViewControllerMarcaProduto.GetbyId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Try
     try
       FController
         .FactoryEntidade
           .DAOMarcaProduto
             .GetbyId(Req.Params['id'].ToInt64)
           .DataSet(FDataSource);
       FJSONObject := FDataSource.DataSet.ToJSONObject();
       Res.Send<TJSONObject>(FJSONObject);
   except
     on E: Exception do
     begin
       Res.Status(500).Send('Ocorreu um erro interno no servidor'+E.Message);
       Exit;
     end;
   End;
   Finally
     if FDataSource.DataSet.IsEmpty then
       Res.Status(404).Send('Registro não encontrado!')
     else
       Res.Status(201).Send('Registro encontrado com sucesso!');
   End;
end;

procedure TViewControllerMarcaProduto.Post(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FJSONObject := Req.Body<TJSONObject>;
      FController
        .FactoryEntidade
          .DAOMarcaProduto
            .This
              .IdEmpresa      (FJSONObject.GetValue<integer>  ('idempresa'))
              .IdUsuario      (FJSONObject.GetValue<Integer>  ('idusuario'))
              .NomeMarca      (FJSONObject.GetValue<String>   ('nomemarca'))
              .DataHoraEmissao(FJSONObject.GetValue<TDateTime>('datahoraemissao'))
              .Ativo          (1)
            .&End
          .Post;
  except
    on E: Exception do
    begin
      Res.Status(500).Send('Ocorreu um erro interno no servidor'+E.Message);
      Exit;
    end;
  end;
  finally
    Res.Status(204).Send('Registro incluído com sucesso!');
  end;
end;

procedure TViewControllerMarcaProduto.Put(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FJSONObject := Req.Body<TJSONObject>;
      FController
        .FactoryEntidade
          .DAOMarcaProduto
            .This
              .Id             (FJSONObject.GetValue<Integer>  ('id'))
              .IdEmpresa      (FJSONObject.GetValue<Integer>  ('idempresa'))
              .IdUsuario      (FJSONObject.GetValue<Integer>  ('idusuario'))
              .NomeMarca      (FJSONObject.GetValue<String>   ('nomemarca'))
              .DataHoraEmissao(FJSONObject.GetValue<TDateTime>('datahoraemissao'))
              .Ativo          (FJSONObject.GetValue<Integer>  ('ativo'))
            .&End
          .Put;
  except
    on E: Exception do
    begin
      Res.Status(500).Send('Ocorreu um erro interno no servidor'+E.Message);
      Exit;
    end;
  end;
  finally
    Res.Status(204).Send('Registro alterado com sucesso!');
  end;
end;

procedure TViewControllerMarcaProduto.Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FController
        .FactoryEntidade
          .DAOMarcaProduto
            .This
              .Id(Req.Params['id'].ToInt64)
            .&End
          .Delete;
    except
      on E: Exception do
      begin
        Res.Status(500).Send('Ocorreu um erro interno no servidor'+E.Message);
        Exit;
      end;
    End;
  Finally
    Res.Status(204).Send('Registro excluído com sucesso!');
  End;
end;

procedure TViewControllerMarcaProduto.Registry;
begin
  THorse
      .Group
      .Prefix('bmw')
      .Get   ('/marca-produto'     , GetAll)
      .Get   ('/marca-produto/:id' , GetbyId)
      .Post  ('marca-produto'      , Post)
      .Put   ('marca-produto/:id'  , Put)
      .Delete('marca-produto/:id'  , Delete);
end;

end.
