{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 03/05/2024 10:13           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Cadastrar.Pedido;

interface

uses
  Data.DB,
  System.JSON,
  System.SysUtils,
  DataSet.Serialize,

  Model.Cadastrar.Pedido.Interfaces,
  Model.Entidade.Pedido.Interfaces,
  Controller.Interfaces;

type
  TCadastrarPedido = class(TInterfacedObject, iCadastrarPedido)
    private
      FController : iController;
      FPedido     : iEntidadePedido<iCadastrarPedido>;
      FDSPedido     : TDataSource;
      FDSPedidoItem : TDataSource;
      FIdPedido   : Integer;
      FIdEmpresa  : Integer;
      FIdCaixa    : Integer;
      FIdUsuario  : Integer;

      FError : Boolean;

      FJSONArray     : TJSONArray;
      FJSONObject    : TJSONObject;

      procedure AlterarValoresPedido;
      function CadastrarPedidoItem      : Boolean;
      function CadastrarPedidoPagamento : Boolean;
      function CadastrarCaixaPedido     : Boolean;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iCadastrarPedido;

      function JSONObject(Value : TJSONObject) : iCadastrarPedido; overload;
      function JSONObject                      : TJSONObject;      overload;
      function Post   : iCadastrarPedido;
      function Error  : Boolean;

      function This : iEntidadePedido<iCadastrarPedido>;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Pedido;

{ TCadastrarPedido }

constructor TCadastrarPedido.Create;
begin
  FController := TController.New;
  FPedido     := TEntidadePedido<iCadastrarPedido>.New(Self);
  FDSPedido   := TDataSource.Create(nil);
  FDSPedidoItem := TDataSource.Create(nil);

  FError := False;
end;

destructor TCadastrarPedido.Destroy;
begin
  inherited;
end;

class function TCadastrarPedido.New: iCadastrarPedido;
begin
  Result := Self.Create;
end;

function TCadastrarPedido.JSONObject(Value: TJSONObject): iCadastrarPedido;
begin
  Result := Self;
  FJSONObject := Value;
end;

function TCadastrarPedido.JSONObject: TJSONObject;
begin
  Result := FJSONObject;
end;

function TCadastrarPedido.Post: iCadastrarPedido;
begin
  Result := Self;
  //tabela pai(Pedido)
  try
    FController
      .FactoryDAO
        .DAOPedido
          .This
            .IdEmpresa          (FJSONObject.GetValue<Integer>  ('idempresa'))
            .IdCaixa            (FJSONObject.GetValue<Integer>  ('idcaixa'))
            .IdPessoa           (FJSONObject.GetValue<Integer>  ('idpessoa'))
            .IdCondicaoPagamento(FJSONObject.GetValue<Integer>  ('idcondicaopagamento'))
            .IdUsuario          (FJSONObject.GetValue<Integer>  ('idusuario'))
            .ValorProduto       (FJSONObject.GetValue<Currency> ('valorproduto'))
            .ValorDesconto      (FJSONObject.GetValue<Currency> ('valordesconto'))
            .ValorReceber       (FJSONObject.GetValue<Currency> ('valorreceber'))
            .ValorDescontoItem  (FJSONObject.GetValue<Currency> ('valordescontoitem'))
            .DataHoraEmissao    (FJSONObject.GetValue<TDateTime>('datahoraemissao'))
            .Status(0) //(CRIAR PARAMENTO DA EMPRESA, INFORMAR SE NA DIGITAÇÃO TIPO DE INFORMAÇÃO)0-Pedido como orçamento 1-Pedido faturado 3-Pedido Cancelado
            .Excluido(0)//0-Pedido estado normal; 1-Pedido excluído
          .&End
        .Post
        .DataSet(FDSPedido);
    //Pegando os id(s), necessários para inserir na tabela caixapedido
    FIdPedido  := FDSPedido.DataSet.FieldByName('id').AsInteger;
    FIdEmpresa := FJSONObject.GetValue<Integer>('idempresa');
    FIdCaixa   := FJSONObject.GetValue<Integer>('idcaixa');
    FIdUsuario := FJSONObject.GetValue<Integer>('idusuario');
    CadastrarPedidoItem;
    AlterarValoresPedido;
    CadastrarPedidoPagamento;
    CadastrarCaixaPedido;
  except
    on E: Exception do
    begin
      WriteLn('Erro ao tentar incluir pedido: ' + E.Message);
      FError := True;
    end;
  end;
end;


//pegando soma da tabela item e atualizado tabela pedido
procedure TCadastrarPedido.AlterarValoresPedido;
begin
  FController
    .FactoryDAO
      .DAOPedido
        .This
          .ValorProduto     (FDSPedidoItem.DataSet.FieldByName('valorproduto').AsCurrency)
          .ValorDescontoItem(FDSPedidoItem.DataSet.FieldByName('valordescontoitem').AsCurrency)
          .ValorReceber     (FDSPedidoItem.DataSet.FieldByName('valorreceber').AsCurrency)
        .&End
      .Put(FIdPedido);
end;

//cadastrar itens do pedido
function TCadastrarPedido.CadastrarPedidoItem: Boolean;
begin
  Result := False;
  Result := FController
              .FactoryCadastrar
                .CadastrarPedidoItem
                  .JSONObjectPai(FJSONObject)
                  .This
                    .IdPedido(FIdPedido)
                  .&End
                .Post
                .DataSet(FDSPedidoItem)
                .Error;
end;

//cadastrar pagamento do pedido
function TCadastrarPedido.CadastrarPedidoPagamento: Boolean;
begin
  Result := False;
  Result := FController
              .FactoryCadastrar
                .CadastrarPedidoPagamento
                  .JSONObjectPai   (FJSONObject)
                    .This
                      .IdPedido    (FIdPedido)
                      .ValorReceber(FDSPedidoItem.DataSet.FieldByName('valorreceber').AsCurrency)
                    .&End
                .Post
                .Error;
end;


//cadastrar relacionamento caixa - pedido
function TCadastrarPedido.CadastrarCaixaPedido: Boolean;
begin
  Result := False;
  Result := FController
              .FactoryCadastrar
                .CadastrarCaixaPedido
                  .JSONObjectPai(FJSONObject)
                    .This
                      .IdEmpresa(FIdEmpresa)
                      .IdCaixa  (FIdCaixa)
                      .IdPedido (FIdPedido)
                      .IdUsuario(FIdUsuario)
                    .&End
                  .Post
                  .Error;
end;

function TCadastrarPedido.Error: Boolean;
begin
  Result := FError;
end;

function TCadastrarPedido.This: iEntidadePedido<iCadastrarPedido>;
begin
  Result := FPedido;
end;

end.
