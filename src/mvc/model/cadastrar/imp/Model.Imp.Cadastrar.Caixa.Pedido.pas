{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 03/05/2024 14:57           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Cadastrar.Caixa.Pedido;

interface

uses
  Data.DB,
  System.JSON,
  System.SysUtils,
  DataSet.Serialize,

  Model.Cadastrar.Caixa.Pedido.Interfaces,
  Model.Entidade.Caixa.Pedido.Interfaces,
  Controller.Interfaces;

type
  TCadastrarCaixaPedido = class(TInterfacedObject, iCadastrarCaixaPedido)
    private
      FController    : iController;
      FCaixaPedido   : iEntidadeCaixaPedido<iCadastrarCaixaPedido>;

      FError : Boolean;

      FJSONObjectPai : TJSONObject;
      FJSONArray     : TJSONArray;
      FJSONObject    : TJSONObject;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iCadastrarCaixaPedido;

      function JSONObjectPai(Value : TJSONObject) : iCadastrarCaixaPedido; overload;
      function JSONObjectPai                      : TJSONObject;           overload;
      function Post   : iCadastrarCaixaPedido;
      function Error  : Boolean;
      //injeção de dependência
      function This : iEntidadeCaixaPedido<iCadastrarCaixaPedido>;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Caixa.Pedido;

{ TCadastrarCaixaPedido }

constructor TCadastrarCaixaPedido.Create;
begin
  FController    := TController.New;
  FCaixaPedido   := TEntidadeCaixaPedido<iCadastrarCaixaPedido>.New(Self);
  FError := False;
end;

destructor TCadastrarCaixaPedido.Destroy;
begin
  inherited;
end;

function TCadastrarCaixaPedido.JSONObjectPai(Value: TJSONObject): iCadastrarCaixaPedido;
begin
  Result := Self;
  FJSONObjectPai := Value;
end;

function TCadastrarCaixaPedido.JSONObjectPai: TJSONObject;
begin
  Result := FJSONObjectPai;
end;

class function TCadastrarCaixaPedido.New: iCadastrarCaixaPedido;
begin
  Result := Self.Create;
end;

function TCadastrarCaixaPedido.Post: iCadastrarCaixaPedido;
begin
  //inserindo caixa que este pedido pertence
  try
    FController
      .FactoryDAO
        .DAOCaixaPedido
          .This
            .IdEmpresa(FCaixaPedido.IdEmpresa)
            .IdCaixa  (FCaixaPedido.IdCaixa)
            .IdPedido (FCaixaPedido.IdPedido)
            .IdUsuario(FCaixaPedido.IdUsuario)
            .DataHoraEmissao(Now)
          .&End
        .Post;
  except
    on E: Exception do
    begin
      WriteLn('Erro ao tentar incluir itens do pedido: ' + E.Message);
      //caso ocorrer algum erro no lançamento do item, excluo o pedido lançado
      FController
        .FactoryDAO
          .DAOPessoa
            .This
              .Id(FCaixaPedido.IdPedido)
            .&End
          .Delete;
      Exit;
    end;
  end;
end;

function TCadastrarCaixaPedido.Error: Boolean;
begin
  Result := FError;
end;

function TCadastrarCaixaPedido.This: iEntidadeCaixaPedido<iCadastrarCaixaPedido>;
begin
  Result := FCaixaPedido;
end;

end.
