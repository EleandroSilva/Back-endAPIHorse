{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 04/05/2024 11:42           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Alterar.Pedido.Pagamento;

interface

uses
  Data.DB,
  System.SysUtils,
  System.JSON,

  Model.Alterar.Pedido.Pagamento.Interfaces,
  Model.Entidade.Pedido.Pagamento.Interfaces,
  Controller.Interfaces;

type
  TAlterarPedidoPagamento = class(TInterfacedObject, iAlterarPedidoPagamento)
    private
      FController        : iController;
      FPedidoPagamento   : iEntidadePedidoPagamento<iAlterarPedidoPagamento>;
      FDSPedidoPagamento : TDataSource;
      FJSONObject : TJSONObject;
      FJSONArray  : TJSONArray;

      FFound : Boolean;
      FError : Boolean;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iAlterarPedidoPagamento;

      function JSONObject(Value : TJSONObject) : iAlterarPedidoPagamento; overload;
      function JSONObject                      : TJSONObject;             overload;
      function Put    : iAlterarPedidoPagamento;
      function Found  : Boolean;
      function Error  : Boolean;

      //inje��o de depend�ncia
      function PedidoPagamento : iEntidadePedidoPagamento <iAlterarPedidoPagamento>;
      function &End : iAlterarPedidoPagamento;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Pedido.Pagamento;

{ TAlterarPedidoPagamento }

constructor TAlterarPedidoPagamento.Create;
begin
  FController        := TController.New;
  FPedidoPagamento   := TEntidadePedidoPagamento<iAlterarPedidoPagamento>.New(Self);
  FDSPedidoPagamento := TDataSource.Create(nil);
  FFound := False;
  FError := False;
end;

destructor TAlterarPedidoPagamento.Destroy;
begin
  inherited;
end;

class function TAlterarPedidoPagamento.New: iAlterarPedidoPagamento;
begin
  Result := Self.Create;
end;

function TAlterarPedidoPagamento.JSONObject(Value: TJSONObject): iAlterarPedidoPagamento;
begin
  Result := Self;
  FJSONObject := Value;
end;

function TAlterarPedidoPagamento.JSONObject: TJSONObject;
begin
  Result := FJSONObject;
end;

function TAlterarPedidoPagamento.Put: iAlterarPedidoPagamento;
Var
  I : Integer;
begin
//Obt�m os dados JSON do corpo da requisi��o da tabela('pedidopagamento')
  FJSONArray := FJSONObject.GetValue('pedidopagamento') as TJSONArray;
  // Loop inserindo pedidopagamento(ns)
  for I := 0 to FJSONArray.Count - 1 do
  begin
    //Extraindo os dados do pagamento do pedido e salvando os dados na tabela
    FJSONObject := FJSONArray.Items[I] as TJSONObject;
    try
      FController
        .FactoryDAO
          .DAOPedidoPagamento
            .This
              .IdPedido      (FPedidoPagamento.IdPedido)
              .DataVencimento(FJSONObject.GetValue<TDateTime>('datavencimento'))
              .ValorParcela  (FJSONObject.GetValue<Currency> ('valorparcela'))
            .&End
          .Post;
    except
      on E: Exception do
      begin
        WriteLn('Erro ao tentar incluir itens do pedido: ' + E.Message);
        //caso ocorrer algum erro no lan�amento do item, excluo o pedido lan�ado
        FController
          .FactoryDAO
            .DAOPessoa
              .This
                .Id(FPedidoPagamento.IdPedido)
              .&End
            .Delete;
            Exit;
        FError := True;
      end;
    end;
  end;
end;

function TAlterarPedidoPagamento.Found: Boolean;
begin
  Result := FFound;
end;

function TAlterarPedidoPagamento.Error: Boolean;
begin
  Result := FError;
end;

//Inje��o de depend�ncia
function TAlterarPedidoPagamento.PedidoPagamento: iEntidadePedidoPagamento<iAlterarPedidoPagamento>;
begin
  Result := FPedidoPagamento;
end;

function TAlterarPedidoPagamento.&End: iAlterarPedidoPagamento;
begin
  Result := Self;
end;

end.
