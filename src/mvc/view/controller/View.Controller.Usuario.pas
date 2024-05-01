{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 18/03/2024 13:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit View.Controller.Usuario;

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
  TViewControllerUsuario = class
    private
      FBody       : TJSONValue;
      FJSONArray  : TJSONArray;
      FJSONObject : TJSONObject;
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

{ TViewControllerUsuario }
constructor TViewControllerUsuario.Create;
begin
  FController := TController.New;
  FDataSource := TDataSource.Create(nil);
  Registry;
end;

destructor TViewControllerUsuario.Destroy;
begin
  FreeAndNil(FDataSource);
  inherited;
end;

procedure TViewControllerUsuario.GetAll(Req: THorseRequest; Res: THorseResponse;  Next: TProc);
begin
  FBody := Req.Body<TJSONObject>;
  try
    try
      if ((Req.Query.Field('email').AsString<>'') and (Req.Query.Field('senha').AsString<>'')) then
        FQuantidadeRegistro := FController
                                .FactoryDAO
                                  .DAOUsuario
                                    .This
                                      .Email(Req.Query.Field('email').AsString)
                                      .Senha(Req.Query.Field('senha').AsString)
                                    .&End
                                  .GetbyParams
                                  .DataSet(FDataSource)
                                  .QuantidadeRegistro
      else
        FQuantidadeRegistro := FController
                                .FactoryDAO
                                  .DAOUsuario
                                    .GetAll
                                    .DataSet(FDataSource)
                                    .QuantidadeRegistro;
     if FQuantidadeRegistro > 1 then
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
     Res.Status(500).Send('Ocorreu um erro interno no servidor.');
     Exit;
   End;
  finally
    if FDataSource.DataSet.IsEmpty then
      Res.Status(404).Send('Registro não encontrado!') else
      Res.Status(201).Send('Registro encontrado com sucesso!');
  end;
end;

procedure TViewControllerUsuario.GetbyId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  FBody := Req.Body<TJSONObject>;
  Try
     try
       FController
         .FactoryDAO
           .DAOUsuario
             .GetbyId(Req.Params['id'].ToInt64)
             .DataSet(FDataSource);

       FJSONObject := FDataSource.DataSet.ToJSONObject;
       Res.Send<TJSONObject>(FJSONObject);
  except
    Res.Status(500).Send('Ocorreu um erro interno no servidor.');
    Exit;
  end;
  finally
    Res.Status(201).Send('Registro encontrado com sucesso!');
  end;
end;

procedure TViewControllerUsuario.Post(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  FBody := Req.Body<TJSONObject>;
  try
    try
      FController
        .FactoryDAO
          .DAOUsuario
            .This
              .IdEmpresa  (FBody.GetValue<integer>('idempresa'))
              .NomeUsuario(FBody.GetValue<String> ('nomeusuario'))
              .EMail      (FBody.GetValue<String> ('email'))
              .Senha      (FBody.GetValue<String> ('senha'))
              .Ativo      (1)
            .&End
          .Post;
  except
    Res.Status(500).Send('Ocorreu um erro interno no servidor.');
    Exit;
  end;
  finally
    Res.Status(204).Send('Registro incluído com sucesso!');
  end;
end;

procedure TViewControllerUsuario.Put(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  FBody := Req.Body<TJSONObject>;
  try
    try
      FController
        .FactoryDAO
          .DAOUsuario
            .This
              .Id         (FBody.GetValue<Integer>('id'))
              .IdEmpresa  (FBody.GetValue<Integer>('idempresa'))
              .NomeUsuario(FBody.GetValue<String> ('nomeusuario'))
              .EMail      (FBody.GetValue<String> ('email'))
              .Senha      (FBody.GetValue<String> ('senha'))
              .Ativo      (FBody.GetValue<Integer>('ativo'))
            .&End
          .Put;
  except
    Res.Status(500).Send('Ocorreu um erro interno no servidor.');
     Exit;
  end;
  finally
    Res.Status(204).Send('Registro alterado com sucesso!');
  end;
end;

procedure TViewControllerUsuario.Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  FBody := Req.Body<TJSONObject>;
  try
    try
      FController
        .FactoryDAO
          .DAOUsuario
            .This
              .Id(FBody.GetValue<Integer>('id'))
            .&End
          .Delete;
    except
    raise Res.Status(500).Send('Ocorreu um erro interno no servidor.');
  end;
  finally
    Res.Status(204).Send('Registro excluído com sucesso!');
  end;
end;

procedure TViewControllerUsuario.Registry;
begin
  THorse
      .Group
      .Prefix('bmw')
      .Get   ('/usuario'     , GetAll)
      .Get   ('/usuario/:id' , GetbyId)
      .Post  ('usuario'      , Post)
      .Put   ('usuario/:id'  , Put)
      .Delete('usuario/:id'  , Delete);
end;

end.
