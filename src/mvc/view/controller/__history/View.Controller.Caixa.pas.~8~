{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 23/04/2024 08:32           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit View.Controller.Caixa;

interface

uses
  System.Classes,
  System.SysUtils,
  System.JSON,
  Vcl.StdCtrls,
  Data.DB,
  FireDAC.Comp.Client,
  DataSet.Serialize,
  Horse,
  Horse.BasicAuthentication,
  Controller.Interfaces;

type
  TViewControllerCaixa= class
    private
      FController : iController;
      FDSCaixa    : TDataSource;

      FBody       : TJSONValue;
      FJSONObject : TJSONObject;
      FJSONArray  : TJSONArray;
      //Json Caixa -->tabela pai
      FJSONObjectCaixa : TJSONObject;
      FJSONArrayCaixa  : TJSONArray;

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

{ TViewControllerCaixa }

constructor TViewControllerCaixa.Create;
begin
  FController    := TController.New;
  FDSCaixa := TDataSource.Create(nil);
  Registry;
end;

destructor TViewControllerCaixa.Destroy;
begin
  inherited;
end;

procedure TViewControllerCaixa.GetAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lQuantidadeRegistro : Integer;
begin
  lQuantidadeRegistro := 0;
  try
    try
      if Req.Query.Field('nomeusuario').AsString<>'' then
        lQuantidadeRegistro := FController
                                 .FactoryEntidade
                                   .DAOCaixa
                                     .This
                                       .Usuario
                                         .NomeUsuario(Req.Query.Field('nomeusuario').AsString)
                                         .&End
                                       .&End
                                     .GetbyParams
                                   .DataSet(FDSCaixa)
                                   .QuantidadeRegistro
      else
        lQuantidadeRegistro := FController
                                 .FactoryEntidade
                                   .DAOCaixa
                                     .GetAll
                                   .DataSet(FDSCaixa)
                                   .QuantidadeRegistro;

    if FQuantidadeRegistro > 1  then
     begin
       FJSONArray := FDSCaixa.DataSet.ToJSONArray();
       Res.Send<TJSONArray>(FJSONArray);
     end
     else
     begin
       FJSONObject := FDSCaixa.DataSet.ToJSONObject();
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
    if FDSCaixa.DataSet.IsEmpty then
      Res.Status(404).Send('Registro não encontrado!')
    else
      Res.Status(201).Send('Registro encontrado com sucesso!');
  end;
end;

procedure TViewControllerCaixa.GetbyId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FController
        .FactoryEntidade
          .DAOCaixa
            .GetbyId(Req.Params['id'].ToInt64)
          .DataSet(FDSCaixa)
    except
      on E: Exception do
      begin
        Res.Status(500).Send('Ocorreu um erro interno no servidor'+E.Message);
        Exit;
      end;
    end;
  finally
    if not FDSCaixa.DataSet.IsEmpty then
    begin
      FJSONObject := FDSCaixa.DataSet.ToJSONObject();
      Res.Send<TJSONObject>(FJSONObjectCaixa);
      Res.Status(201).Send('Registro encontrado com sucesso!');
    end
    else
    begin
      Res.Send<TJSONObject>(FJSONObjectCaixa);
      Res.Status(400).Send('Registro não encontrado!');
    end;
  end;
end;

procedure TViewControllerCaixa.Post(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FJSONObjectCaixa := Req.Body<TJSONObject>;
      FController
        .FactoryEntidade
          .DAOCaixa
            .This
              .IdEmpresa      (FJSONObjectCaixa.GetValue<integer>  ('idempresa'))
              .IdUsuario      (FJSONObjectCaixa.GetValue<Integer>  ('idusuario'))
              .ValorInicial   (FJSONObjectCaixa.GetValue<Currency> ('valorinicial'))
              .DataHoraEmissao(FJSONObjectCaixa.GetValue<TDateTime>('datahoraemissao'))
              .Status         ('A')
            .&End
          .Post;
  except
    on E: Exception do
    begin
      Res.Send<TJSONObject>(FJSONObjectCaixa);
      Res.Status(500).Send('Ocorreu um erro interno no servidor'+E.Message);
      Exit;
    end;
  end;
  finally
    Res.Send<TJSONObject>(FJSONObjectCaixa);
    Res.Status(204).Send('Registro incluído com sucesso!');
  end;
end;

procedure TViewControllerCaixa.Put(Req: THorseRequest;Res: THorseResponse; Next: TProc);
begin
  try
    try
      FJSONObjectCaixa := Req.Body<TJSONObject>;
      FController
        .FactoryEntidade
          .DAOCaixa
            .This
              .Id          (FJSONObjectCaixa.GetValue<Integer>  ('id'))
              .IdEmpresa   (FJSONObjectCaixa.GetValue<Integer>  ('idempresa'))
              .ValorInicial(FJSONObjectCaixa.GetValue<Currency> ('valorinicial'))
            .&End
          .Put;
  except
    on E: Exception do
    begin
      Res.Send<TJSONObject>(FJSONObjectCaixa);
      Res.Status(500).Send('Ocorreu um erro interno no servidor'+E.Message);
      Exit;
    end;
  end;
  finally
    Res.Send<TJSONObject>(FJSONObjectCaixa);
    Res.Status(204).Send('Registro alterado com sucesso!');
  end;
end;

procedure TViewControllerCaixa.Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FController
        .FactoryEntidade
          .DAOCaixa
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
    Res.Send<TJSONObject>(FJSONObjectCaixa);
    Res.Status(204).Send('Registro excluído com sucesso!');
  end;
end;

procedure TViewControllerCaixa.Registry;
begin
  THorse
      .Group
        .Prefix  ('bmw')
          .Get   ('/caixa/:id' , GetbyId)
          .Get   ('/caixa'     , GetAll)
          .Post  ('caixa'      , Post)
          .Put   ('caixa/:id'  , Put)
          .Delete('caixa/:id'  , Delete);
end;

end.
