{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 04/05/2024 11:42           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Alterar.Pedido;

interface

uses
  Data.DB,
  System.SysUtils,
  System.JSON,

  Model.Alterar.Pedido.Interfaces,
  Model.Entidade.Pedido.Interfaces,
  Controller.Interfaces;

type
  TAlterarPedido = class(TInterfacedObject, iAlterarPedido)
    private
      FController : iController;
      FPedido     : iEntidadePedido<iAlterarPedido>;
      FDSPedido   : TDataSource;
      FJSONObject : TJSONObject;
      FJSONArray  : TJSONArray;
      FIdPedido   : Integer;
      FIdEmpresa  : Integer;
      FIdCaixa    : Integer;
      FIdUsuario  : Integer;
      FFound : Boolean;
      FError : Boolean;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iAlterarPedido;

      function JSONObject(Value : TJSONObject) : iAlterarPedido; overload;
      function JSONObject                      : TJSONObject;    overload;
      function Put                             : iAlterarPedido; overload;
      function Found  : Boolean;
      function Error  : Boolean;

      //injeção de dependência
      function This : iEntidadePedido<iAlterarPedido>;
      function &End : iAlterarPedido;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Pedido;

{ TAlterarPedido }

constructor TAlterarPedido.Create;
begin
  FController := TController.New;
  FPedido     := TEntidadePedido<iAlterarPedido>.New(Self);
  FDSPedido   := TDataSource.Create(nil);
  FFound := False;
  FError := False;
end;

destructor TAlterarPedido.Destroy;
begin
  inherited;
end;

class function TAlterarPedido.New: iAlterarPedido;
begin
  Result := Self.Create;
end;

function TAlterarPedido.JSONObject(Value: TJSONObject): iAlterarPedido;
begin
  Result := Self;
  FJSONObject := Value;
end;

function TAlterarPedido.JSONObject: TJSONObject;
begin
  Result := FJSONObject;
end;

function TAlterarPedido.Put: iAlterarPedido;
begin
  //tabela pai(Pedido)
  FJSONObject := FJSONObject;
  try
    FController
      .FactoryDAO
        .DAOPedido
          .This
            .Id                 (FJSONObject.GetValue<Integer>  ('id'))
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
            .Status             (FJSONObject.GetValue<Integer>  ('status')) //(CRIAR PARAMENTO DA EMPRESA, INFORMAR SE NA DIGITAÇÃO TIPO DE INFORMAÇÃO)0-Pedido como orçamento 1-Pedido faturado 3-Pedido Cancelado
            .Excluido           (FJSONObject.GetValue<Integer>  ('excluido'))//0-Pedido estado normal; 1-Pedido excluído
          .&End
        .Put
        .DataSet(FDSPedido);
    //Pegando os id(s), necessários para inserir na tabela caixapedido
    FIdPedido  := FDSPedido.DataSet.FieldByName('id').AsInteger;
    FIdEmpresa := FJSONObject.GetValue<Integer>('idempresa');
    FIdCaixa   := FJSONObject.GetValue<Integer>('idcaixa');
    FIdUsuario := FJSONObject.GetValue<Integer>('idusuario');
  except
    on E: Exception do
    begin
      WriteLn('Erro ao tentar incluir pedido: ' + E.Message);
      FError := True;
    end;
  end;
end;

function TAlterarPedido.Found: Boolean;
begin
  Result := FFound;
end;

function TAlterarPedido.Error: Boolean;
begin
  Result := FError;
end;

//Injeção de dependência
function TAlterarPedido.This: iEntidadePedido<iAlterarPedido>;
begin
  Result := FPedido;
end;

function TAlterarPedido.&End: iAlterarPedido;
begin
  Result := Self;
end;

end.
