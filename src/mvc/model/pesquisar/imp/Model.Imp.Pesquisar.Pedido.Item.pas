{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 04/05/2024 11:42           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Pesquisar.Pedido.Item;

interface

uses
  Data.DB,
  System.JSON,
  System.SysUtils,
  DataSet.Serialize,

  Model.Pesquisar.Pedido.Item.Interfaces,
  Model.Entidade.Pedido.Item.Interfaces,
  Controller.Interfaces;

type
  TPesquisarPedidoItem = class(TInterfacedObject, iPesquisarPedidoItem)
    private
      FController  : iController;
      FPedidoItem  : iEntidadePedidoItem<iPesquisarPedidoItem>;

      FDSPedidoItem : TDataSource;

      FJSONObject : TJSONObject;
      FJSONArray  : TJSONArray;

      FFound : Boolean;
      FError : Boolean;

      FQuantidadeRegistro : Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iPesquisarPedidoItem;

      function GetBy(IdPedido : Integer) : iPesquisarPedidoItem;
      function LoopPedidoItem : TJSONValue;
      function Found : Boolean;
      function Error : Boolean;

      function PedidoItem : iEntidadePedidoItem<iPesquisarPedidoItem>;
      function &End : iPesquisarPedidoItem;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Pedido.Item;

{ TPesquisarPedidoItem }

constructor TPesquisarPedidoItem.Create;
begin
  FController   := TController.New;
  FPedidoItem   := TEntidadePedidoItem<iPesquisarPedidoItem>.New(Self);
  FDSPedidoItem := TDataSource.Create(nil);
  FFound := False;
  FError := False;
  FQuantidadeRegistro := 0;
end;

destructor TPesquisarPedidoItem.Destroy;
begin
  inherited;
end;

class function TPesquisarPedidoItem.New: iPesquisarPedidoItem;
begin
  Result := Self.Create;
end;

function TPesquisarPedidoItem.GetBy(IdPedido: Integer): iPesquisarPedidoItem;
begin
  Result := Self;
  try
    FController
      .FactoryDAO
        .DAOPedidoItem
          .GetbyId(IdPedido)
        .DataSet(FDSPedidoItem);
  except
    on E: Exception do
    begin
      WriteLn('Erro ao tentar encontrar o item do pedido: ' + E.Message);
      FError := True;
    end;
  end;
  FFound := Not FDSPedidoItem.DataSet.IsEmpty;
end;

function TPesquisarPedidoItem.LoopPedidoItem: TJSONValue;
begin
  FQuantidadeRegistro := FController
                           .FactoryDAO
                             .DAOPedidoItem
                               .GetbyId(FPedidoItem.IdPedido)
                               .DataSet(FDSPedidoItem)
                             .QuantidadeRegistro;

  if not FDSPedidoItem.DataSet.IsEmpty then
  begin
    FJSONArray := TJSONArray.Create;

    FDSPedidoItem.DataSet.First;
    while not FDSPedidoItem.DataSet.Eof do
    begin
      FJSONObject := TJSONObject.Create;
      FJSONObject := FDSPedidoItem.DataSet.ToJSONObject;
      Result := FJSONObject;
      //tendo mais de um registro, adiciona ao array
      if FQuantidadeRegistro > 1 then
      begin
        FJSONArray.Add(FJSONObject);
        Result := FJSONArray;
      end;
      FDSPedidoItem.DataSet.Next;
    end;
  end;
end;

function TPesquisarPedidoItem.Found: Boolean;
begin
  Result := FFound;
end;

function TPesquisarPedidoItem.Error: Boolean;
begin
  Result := FError;
end;

//Injeção de dependência
function TPesquisarPedidoItem.PedidoItem: iEntidadePedidoItem<iPesquisarPedidoItem>;
begin
  Result := FPedidoItem;
end;

function TPesquisarPedidoItem.&End: iPesquisarPedidoItem;
begin
  Result := Self;
end;

end.
