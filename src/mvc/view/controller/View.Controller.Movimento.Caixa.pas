{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 23/04/2024 20:41           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit View.Controller.Movimento.Caixa;

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
  TViewControllerMovimentoCaixa= class
    private
      FController       : iController;
      FDSMovimentoCaixa : TDataSource;

      FBody       : TJSONValue;
      FJSONObject : TJSONObject;
      FJSONArray  : TJSONArray;
      //Json Movimento Caixa
      FJSONObjectMovimentoCaixa : TJSONObject;
      FJSONArrayMovimentoCaixa  : TJSONArray;

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

constructor TViewControllerMovimentoCaixa.Create;
begin
  FController       := TController.New;
  FDSMovimentoCaixa := TDataSource.Create(nil);
  Registry;
end;

destructor TViewControllerMovimentoCaixa.Destroy;
begin
  inherited;
end;

procedure TViewControllerMovimentoCaixa.GetAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lQuantidadeRegistro : Integer;
begin
  lQuantidadeRegistro := 0;
  try
    try
      if Req.Query.Field('nomeusuario').AsString<>'' then
        lQuantidadeRegistro := FController
                                 .FactoryEntidade
                                   .DAOMovimentoCaixa
                                     .This
                                       .Usuario
                                         .NomeUsuario(Req.Query.Field('nomeusuario').AsString)
                                         .&End
                                       .&End
                                     .GetbyParams
                                   .DataSet(FDSMovimentoCaixa)
                                   .QuantidadeRegistro
      else
        lQuantidadeRegistro := FController
                                 .FactoryEntidade
                                   .DAOMovimentoCaixa
                                     .GetAll
                                   .DataSet(FDSMovimentoCaixa)
                                   .QuantidadeRegistro;

    if lQuantidadeRegistro > 1  then
     begin
       FJSONArray := FDSMovimentoCaixa.DataSet.ToJSONArray();
       Res.Send<TJSONArray>(FJSONArray);
     end
     else
     begin
       FJSONObject := FDSMovimentoCaixa.DataSet.ToJSONObject();
       Res.Send<TJSONObject>(FJSONObject);
     end;
    except
      on E: Exception do
      begin
        Res.Status(500).Send('Ocorreu um erro interno no servidor'+E.Message);
        Exit;
      end;
    end;
  finally
    if not FDSMovimentoCaixa.DataSet.IsEmpty then
    begin
      //LoopCaixaDiario;
      if lQuantidadeRegistro > 1 then
        Res.Send<TJSONArray>(FJSONArrayMovimentoCaixa) else
        Res.Send<TJSONObject>(FJSONObjectMovimentoCaixa);
      Res.Status(201).Send('Registro encontrado com sucesso!');
    end
    else
    begin
      Res.Send<TJSONObject>(FJSONObjectMovimentoCaixa);
      Res.Status(400).Send('Registro não encontrado!');
    end;
  end;
end;

procedure TViewControllerMovimentoCaixa.GetbyId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FController
        .FactoryEntidade
          .DAOMovimentoCaixa
            .GetbyId(Req.Params['id'].ToInt64)
          .DataSet(FDSMovimentoCaixa)
    except
      on E: Exception do
      begin
        Res.Status(500).Send('Ocorreu um erro interno no servidor'+E.Message);
        Exit;
      end;
    end;
  finally
    if not FDSMovimentoCaixa.DataSet.IsEmpty then
    begin
      FJSONObject := FDSMovimentoCaixa.DataSet.ToJSONObject();
      Res.Send<TJSONObject>(FJSONObjectMovimentoCaixa);
      Res.Status(201).Send('Registro encontrado com sucesso!');
    end
    else
    begin
      Res.Send<TJSONObject>(FJSONObjectMovimentoCaixa);
      Res.Status(400).Send('Registro não encontrado!');
    end;
  end;
end;

procedure TViewControllerMovimentoCaixa.Post(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FJSONObjectMovimentoCaixa := Req.Body<TJSONObject>;
      FController
        .FactoryEntidade
          .DAOMovimentoCaixa
            .This
              .IdCaixa         (FJSONObjectMovimentoCaixa.GetValue<integer>  ('idcaixa'))
              .IdPedido        (FJSONObjectMovimentoCaixa.GetValue<integer>  ('idpedido'))
              .IdFormaPagamento(FJSONObjectMovimentoCaixa.GetValue<integer>  ('idformapagamento'))
              .IdUsuario       (FJSONObjectMovimentoCaixa.GetValue<Integer>  ('idusuario'))
              .ValorLancado    (FJSONObjectMovimentoCaixa.GetValue<Currency> ('valorlancado'))
              .CreditoDebito   (FJSONObjectMovimentoCaixa.GetValue<string>   ('creditodebito'))
              .DataHoraEmissao (FJSONObjectMovimentoCaixa.GetValue<TDateTime>('datahoraemissao'))
              .TipoLancamento  (FJSONObjectMovimentoCaixa.GetValue<string>   ('tipolancamento'))
            .&End
          .Post;
  except
    on E: Exception do
    begin
      Res.Send<TJSONObject>(FJSONObjectMovimentoCaixa);
      Res.Status(500).Send('Ocorreu um erro interno no servidor'+E.Message);
      Exit;
    end;
  end;
  finally
    Res.Send<TJSONObject>(FJSONObjectMovimentoCaixa);
    Res.Status(204).Send('Registro incluído com sucesso!');
  end;
end;

procedure TViewControllerMovimentoCaixa.Put(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  {Analisar para ver se vai poder ter alteração nesta classe no UPDATE
  try
    try
      FJSONObjectMovimentoCaixa := Req.Body<TJSONObject>;
      FController
        .FactoryEntidade
          .DAOMovimentoCaixa
            .This
              .Id          (FJSONObjectMovimentoCaixa.GetValue<Integer> ('id'))
              .ValorLancado(FJSONObjectMovimentoCaixa.GetValue<Currency>('valorlancado'))
              .Observacao  (FJSONObjectMovimentoCaixa.GetValue<string>  ('observacao'))
            .&End
          .Put;
      //altero o status do caixa para caixa fechado
      FController
        .FactoryEntidade
          .DAOCaixa
            .This
              .Id    (FJSONObjectMovimentoCaixa.GetValue<Integer>('idcaixa'))
              .Status('F')
            .&End
          .Put;
  except
    on E: Exception do
    begin
      Res.Send<TJSONObject>(FJSONObjectMovimentoCaixa);
      Res.Status(500).Send('Ocorreu um erro interno no servidor'+E.Message);
      Exit;
    end;
  end;
  finally
    Res.Send<TJSONObject>(FJSONObjectMovimentoCaixa);
    Res.Status(204).Send('Registro alterado com sucesso!');
  end;
  }
end;


procedure TViewControllerMovimentoCaixa.Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FController
        .FactoryEntidade
          .DAOMovimentoCaixa
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
    Res.Send<TJSONObject>(FJSONObjectMovimentoCaixa);
    Res.Status(204).Send('Registro excluído com sucesso!');
  end;
end;

procedure TViewControllerMovimentoCaixa.Registry;
begin
  THorse
      .Group
        .Prefix  ('bmw')
          .Get   ('/movimento-caixa/:id' , GetbyId)
          .Get   ('/movimento-caixa'     , GetAll)
          .Post  ('movimento-caixa'      , Post)
          .Put   ('movimento-caixa/:id'  , Put)
          .Delete('movimento-caixa/:id'  , Delete);
end;

end.
