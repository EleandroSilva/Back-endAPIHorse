{*******************************************************}
{                    API PDV - JSON                     }
{                     Be More Web                       }
{          Início do projeto 18/03/2024 13:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                       2003/2024                       }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit View.Controller.Unidade.Produto;

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
  TViewControllerUnidadeProduto = class
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

{ TViewControllerUnidadeProduto }

constructor TViewControllerUnidadeProduto.Create;
begin
  FController := TController.New;
  FDataSource := TDataSource.Create(nil);
  Registry;
end;

destructor TViewControllerUnidadeProduto.Destroy;
begin
  FreeAndNil(FDataSource);
  inherited;
end;

procedure TViewControllerUnidadeProduto.GetAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      if Req.Query.Field('nomeunidade').AsString<>'' then
        FQuantidadeRegistro := FController
                                .FactoryEntidade
                                  .DAOUnidadeProduto
                                    .This
                                      .NomeUnidade(Req.Query.Field('nomeunidade').AsString)
                                    .&End
                                    .GetbyParams
                                  .DataSet(FDataSource)
                                  .QuantidadeRegistro
      else
       FQuantidadeRegistro:= FController
                              .FactoryEntidade
                                .DAOUnidadeProduto
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
      Res.Status(404).Send('Registro não encontrado!') else
      Res.Status(201).Send('Registro encontrado com sucesso!');
  end;
end;

procedure TViewControllerUnidadeProduto.GetbyId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Try
     try
       FController
         .FactoryEntidade
           .DAOUnidadeProduto
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
       Res.Status(404).Send('Registro não encontrado!') else
       Res.Status(201).Send('Registro encontrado com sucesso!');
   End;
end;

procedure TViewControllerUnidadeProduto.Post(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FJSONObject := Req.Body<TJSONObject>;
      FController
        .FactoryEntidade
          .DAOUnidadeProduto
            .This
              .Unidade    (FJSONObject.GetValue<String> ('unidade'))
              .NomeUnidade(FJSONObject.GetValue<String> ('nomeunidade'))
              .Ativo  (1)
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

procedure TViewControllerUnidadeProduto.Put(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FJSONObject := Req.Body<TJSONObject>;
      FController
        .FactoryEntidade
          .DAOUnidadeProduto
            .This
              .Id         (FJSONObject.GetValue<Integer>('id'))
              .Unidade    (FJSONObject.GetValue<String> ('unidade'))
              .NomeUnidade(FJSONObject.GetValue<String> ('nomeunidade'))
              .Ativo      (FJSONObject.GetValue<Integer>('ativo'))
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

procedure TViewControllerUnidadeProduto.Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FController
        .FactoryEntidade
          .DAOUnidadeProduto
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
  end;
  finally
    Res.Status(204).Send('Registro excluído com sucesso!');
  end;
end;

procedure TViewControllerUnidadeProduto.Registry;
begin
  THorse
      .Group
      .Prefix('bmw')
      .Get   ('/unidade-produto'     , GetAll)
      .Get   ('/unidade-produto/:id' , GetbyId)
      .Post  ('unidade-produto'      , Post)
      .Put   ('unidade-produto/:id'  , Put)
      .Delete('unidade-produto/:id'  , Delete);
end;

end.
