{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 03/05/2024 13:46           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Cadastrar.Pedido.Item;

interface

uses
  Data.DB,
  System.JSON,
  System.SysUtils,
  DataSet.Serialize,

  Model.Cadastrar.Pedido.Item.Interfaces,
  Model.Entidade.Pedido.Item.Interfaces,
  Controller.Interfaces;

type
  TCadastrarPedidoItem = class(TInterfacedObject, iCadastrarPedidoItem)
    private
      FController   : iController;
      FPedidoItem   : iEntidadePedidoItem<iCadastrarPedidoItem>;
      FDataSet      : TDataSource;
      FError : Boolean;
      FJSONObjectPai : TJSONObject;
      FJSONArray     : TJSONArray;
      FJSONObject    : TJSONObject;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iCadastrarPedidoItem;
      function JSONObjectPai(Value : TJSONObject)   : iCadastrarPedidoItem; overload;
      function JSONObjectPai                        : TJSONObject;          overload;
      function DataSet(DataSource : TDataSource)    : iCadastrarPedidoItem; overload;
      function DataSet                              : TDataSet;             overload;
      function Post   : iCadastrarPedidoItem;
      function Error  : Boolean;
      //injeção de dependência
      function This : iEntidadePedidoItem<iCadastrarPedidoItem>;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Pedido.Item;

{ TCadastrarPedidoItem }

constructor TCadastrarPedidoItem.Create;
begin
  FController   := TController.New;
  FPedidoItem   := TEntidadePedidoItem<iCadastrarPedidoItem>.New(Self);
  FDataSet      := TDataSource.Create(nil);
  FError := False;
end;

destructor TCadastrarPedidoItem.Destroy;
begin
  inherited;
end;

class function TCadastrarPedidoItem.New: iCadastrarPedidoItem;
begin
  Result := Self.Create;
end;

function TCadastrarPedidoItem.JSONObjectPai(Value: TJSONObject): iCadastrarPedidoItem;
begin
  Result := Self;
  FJSONObjectPai := Value;
end;

function TCadastrarPedidoItem.JSONObjectPai: TJSONObject;
begin
  Result := FJSONObjectPai;
end;

function TCadastrarPedidoItem.DataSet(DataSource: TDataSource): iCadastrarPedidoItem;
begin
  Result := Self;
 // if not Assigned(FDataset) then
 //   DataSource.DataSet := FDataSet
 // else
    DataSource.DataSet := FDataSet.DataSet;
end;

function TCadastrarPedidoItem.DataSet: TDataSet;
begin
  Result := FDataSet.DataSet;
end;

function TCadastrarPedidoItem.Post: iCadastrarPedidoItem;
Var
  I : Integer;
begin
  Result := Self;
  //Obtém os dados JSON do corpo da requisição da tabela('pedidoitem')
  FJSONArray := FJSONObjectPai.GetValue('pedidoitem') as TJSONArray;
  // Loop inserindo pedidoitem(ns)
  for I := 0 to FJSONArray.Count - 1 do
  begin
    //Extraindo os dados do pedidoitem e salvando na tabela
    FJSONObject := FJSONArray.Items[I] as TJSONObject;
    try
      FController
        .FactoryDAO
          .DAOPedidoItem
            .This
              .IdPedido         (FPedidoItem.IdPedido)
              .IdProduto        (FJSONObject.GetValue<Integer> ('idproduto'))
              .Quantidade       (FJSONObject.GetValue<Currency>('quantidade'))
              .ValorUnitario    (FJSONObject.GetValue<Currency>('valorunitario'))
              .ValorProduto     (FJSONObject.GetValue<Currency>('valorproduto'))
              .ValorDescontoItem(FJSONObject.GetValue<Currency>('valordescontoitem'))
              .ValorReceber     (FJSONObject.GetValue<Currency>('valorreceber'))
            .&End
          .Post
          .DataSet(FDataSet);
    except
      on E: Exception do
      begin
        WriteLn('Erro ao tentar incluir itens do pedido: ' + E.Message);
        //caso ocorrer algum erro no lançamento do item, excluo o pedido lançado
        FController
          .FactoryDAO
            .DAOPessoa
              .This
                .Id(FPedidoItem.IdPedido)
              .&End
            .Delete;
            Exit;
        FError := True;
      end;
    end;
  end;
end;

function TCadastrarPedidoItem.Error: Boolean;
begin
  Result := FError;
end;

function TCadastrarPedidoItem.This: iEntidadePedidoItem<iCadastrarPedidoItem>;
begin
  Result := FPedidoItem;
end;

end.
