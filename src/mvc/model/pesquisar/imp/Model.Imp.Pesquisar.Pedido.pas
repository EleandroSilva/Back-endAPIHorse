{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 04/05/2024 11:42           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Pesquisar.Pedido;

interface

uses
  Data.DB,
  System.JSON,
  System.SysUtils,
  DataSet.Serialize,

  Model.Pesquisar.Pedido.Interfaces,
  Model.Entidade.Pedido.Interfaces,
  Controller.Interfaces;

type
  TPesquisarPedido = class(TInterfacedObject, iPesquisarPedido)
    private
      FController : iController;
      FPedido     : iEntidadePedido<iPesquisarPedido>;
      FDSPedido   : TDataSource;
      FJSONObject : TJSONObject;
      FJSONArray  : TJSONArray;
      FFound : Boolean;
      FError : Boolean;
      FQuantidadeRegistro : Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iPesquisarPedido;

      function GetBy(Id : Integer) : iPesquisarPedido;
      function LoopPedido : TJSONValue;
      function Found : Boolean;
      function Error : Boolean;

      function Pedido : iEntidadePedido<iPesquisarPedido>;
      function &End   : iPesquisarPedido;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Pedido;

{ TPesquisarPedido }

constructor TPesquisarPedido.Create;
begin
  FController := TController.New;
  FPedido     := TEntidadePedido<iPesquisarPedido>.New(Self);
  FDSPedido   := TDataSource.Create(nil);
  FFound := False;
  FError := False;
  FQuantidadeRegistro := 0;
end;

destructor TPesquisarPedido.Destroy;
begin
  inherited;
end;

class function TPesquisarPedido.New: iPesquisarPedido;
begin
  Result := Self.Create;
end;

function TPesquisarPedido.GetBy(Id: Integer): iPesquisarPedido;
begin
  Result := Self;
  try
    FController
      .FactoryDAO
        .DAOPedido
          .GetbyId(Id)
        .DataSet(FDSPedido);
  except
    on E: Exception do
    begin
      WriteLn('Erro ao tentar encontrar o pedido: ' + E.Message);
      FError := True;
    end;
  end;
  FFound := Not FDSPedido.DataSet.IsEmpty;
end;

function TPesquisarPedido.LoopPedido: TJSONValue;
begin
  FQuantidadeRegistro := FController
                           .FactoryDAO
                             .DAOPedido
                               .GetbyId(FPedido.Id)
                               .DataSet(FDSPedido)
                             .QuantidadeRegistro;

  if not FDSPedido.DataSet.IsEmpty then
  begin
    FJSONArray := TJSONArray.Create;

    FDSPedido.DataSet.First;
    while not FDSPedido.DataSet.Eof do
    begin
      FJSONObject := TJSONObject.Create;
      FJSONObject := FDSPedido.DataSet.ToJSONObject;
      Result := FJSONObject;
      //tendo mais de um registro, adiciona ao array
      if FQuantidadeRegistro > 1 then
      begin
        FJSONArray.Add(FJSONObject);
        Result := FJSONArray;
      end;
      FDSPedido.DataSet.Next;
    end;
  end;
end;

function TPesquisarPedido.Found: Boolean;
begin
  Result := FFound;
end;

function TPesquisarPedido.Error: Boolean;
begin
  Result := FError;
end;

//Injeção de dependência
function TPesquisarPedido.Pedido: iEntidadePedido<iPesquisarPedido>;
begin
  Result := FPedido;
end;

function TPesquisarPedido.&End: iPesquisarPedido;
begin
  Result := Self;
end;

end.
