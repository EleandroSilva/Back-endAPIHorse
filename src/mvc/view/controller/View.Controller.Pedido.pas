


{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 26/04/2024 12:00           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit View.Controller.Pedido;

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
  TViewControllerPedido= class
    private
      FController : iController;
      //Jsons
      FJSONObject : TJSONObject;
      FJSONArray  : TJSONArray;
      //DataSource
      FDSPedido   : TDataSource;
      FIdPedido   : Integer;
      FQuantidadeRegistro  : Integer;

      //Loop que monta o JSON
      procedure LoopPedido;
      function  LoopPedidoItem      : TJSONValue;
      function  LoopPedidoPagamento : TJSONValue;
      function  CadastrarPedido(Value : TJSONObject) : Boolean;
      //Horse
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

{ TViewControllerPedido }
constructor TViewControllerPedido.Create;
begin
  FController   := TController.New;
  FDSPedido     := TDataSource.Create(nil);
  Registry;
end;

destructor TViewControllerPedido.Destroy;
begin
  inherited;
end;

function TViewControllerPedido.CadastrarPedido(Value: TJSONObject): Boolean;
begin
  Result := False;
  Result :=FController
             .FactoryCadastrar
               .CadastrarPedido
                 .JSONObjectPai(Value)
                 .Post
                 .Error;
end;

procedure TViewControllerPedido.LoopPedido;
begin
  FJSONArray := TJSONArray.Create;//JSONArray tabela pai empresa
  FDSPedido.DataSet.First;
  while not FDSPedido.DataSet.Eof do
  begin
    FJSONObject := TJSONObject.Create;//JSONObject tabela pai empresa
    try
      FJSONObject := FDSPedido.DataSet.ToJSONObject;
    except
      on E: Exception do
      begin
        WriteLn('Erro ao converter DataSet para JSONObject: ' + E.Message);
        Break;
      end;
    end;

    try
      FJSONObject.AddPair('pedidoitem' , LoopPedidoItem);
    except
      on E: Exception do
      begin
        WriteLn('Erro durante o loop de pedidoitem, verificar as instruções SQL no DAOPedidoItem: ' + E.Message);
        Break;
      end;
    end;

    try
      FJSONObject.AddPair('pedidopagamento' , LoopPedidoPagamento);
    except
      on E: Exception do
      begin
        WriteLn('Erro durante o loop de pedidopagamento, verificar as instruções SQL no DAOPedidoPagamento: ' + E.Message);
        Break;
      end;
    end;

    FJSONArray.Add(FJSONObject);
    FDSPedido.DataSet.Next;
  end;
end;

function TViewControllerPedido.LoopPedidoItem: TJSONValue;
begin
  Result := FController
              .FactoryPesquisar
                .PesquisarPedidoItem
                  .PedidoItem
                    .IdPedido(FIdPedido)
                  .&End
                .LoopPedidoItem;

end;

function TViewControllerPedido.LoopPedidoPagamento: TJSONValue;
begin
  Result := FController
              .FactoryPesquisar
                .PesquisarPedidoPagamento
                  .PedidoPagamento
                    .IdPedido(FIdPedido)
                  .&End
                .LoopPedidoPagamento;

end;

procedure TViewControllerPedido.GetAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lQuantidadeRegistro : Integer;
begin
  lQuantidadeRegistro := 0;
  try
    if Req.Query.Field('nomepessoa').AsString<>'' then
      lQuantidadeRegistro := FController
                               .FactoryDAO
                                 .DAOPedido
                                 .GetbyParams(Req.Query.Field('nomepessoa').AsString)
                                 .DataSet(FDSPedido)
                                 .QuantidadeRegistro
    else
    if Req.Query.Field('idpessoa').AsString<>'' then
      lQuantidadeRegistro := FController
                               .FactoryDAO
                                 .DAOPedido
                                 .GetbyParams(Req.Query.Field('idpessoa').AsInteger)
                                 .DataSet(FDSPedido)
                                 .QuantidadeRegistro
    else
    if Req.Query.Field('idusuario').AsString<>'' then
      lQuantidadeRegistro := FController
                               .FactoryDAO
                                 .DAOPedido
                                 .GetbyParams(Req.Query.Field('idusuario').AsString)
                                 .DataSet(FDSPedido)
                                 .QuantidadeRegistro
    else
      lQuantidadeRegistro := FController
                               .FactoryDAO
                                 .DAOPedido
                                   .GetAll
                                   .DataSet(FDSPedido)
                                   .QuantidadeRegistro;

  except
    on E: Exception do
    begin
      Res.Status(500).Send('Ocorreu um erro interno no servidor: '+ E.Message);
      Exit;
    end;
  end;

  if not FDSPedido.DataSet.IsEmpty then
  begin
    LoopPedido;

    if lQuantidadeRegistro > 1 then
      Res.Send<TJSONArray>(FJSONArray) else
      Res.Send<TJSONObject>(FJSONObject);

    Res.Status(201).Send('Registro encontrado com sucesso!');
  end
  else
    Res.Status(400).Send('Registro não encontrado!');

end;

procedure TViewControllerPedido.GetbyId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    FController
      .FactoryDAO
        .DAOPedido
          .GetbyId(Req.Params['id'].ToInt64)
          .DataSet(FDSPedido);

    FJSONObject := FDSPedido.DataSet.ToJSONObject();
    Res.Send<TJSONObject>(FJSONObject);
  except
    on E: Exception do
    begin
      Res.Status(500).Send('Ocorreu um erro interno no servidor'+E.Message);
      Exit;
    end;
  End;

  if not FDSPedido.DataSet.IsEmpty then
  begin
    LoopPedido;
    Res.Send<TJSONObject>(FJSONObject);
    Res.Status(201).Send('Registro encontrado com sucesso!');
  end
  else
    Res.Status(400).Send('Registro não encontrado!');
end;

procedure TViewControllerPedido.Post(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  //Lê os dados JSON da requisição (tabela pai='pedido')
  FJSONObject := Req.Body<TJSONObject>;
  if CadastrarPedido(FJSONObject) Then
  begin
    Res.Status(500).Send('Ocorreu um erro interno no servidor!');
    Exit;
  end
  else
  begin
    FJSONObject := FDSPedido.DataSet.ToJSONObject();
    Res.Send<TJSONObject>(FJSONObject);
    Res.Status(204).Send('Registro incluído com sucesso!');
  end;
end;

procedure TViewControllerPedido.Put(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
//
end;

procedure TViewControllerPedido.Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    FController
      .FactoryDAO
        .DAOPedido
          .This
            .Id(Req.Params['id'].ToInt64)
          .&End
          .Delete
          .DataSet(FDSPedido);
    except
      on E: Exception do
      raise Res.Status(500).Send('Ocorreu um erro interno no servidor.'+ E.Message);
  End;
    Res.Status(204).Send('Registro excluído com sucesso!');
end;

procedure TViewControllerPedido.Registry;
begin
  THorse
      .Group
        .Prefix  ('bmw')
          .Get   ('/pedido'     , GetAll)
          .Get   ('/pedido/:id' , GetbyId)
          .Post  ('pedido'      , Post)
          .Put   ('pedido/:id'  , Put)
          .Delete('pedido/:id'  , Delete);
end;

end.
