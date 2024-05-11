{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 09/05/2024 12:11           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit View.Controller.Consultar.CNPJ;

interface

uses
  System.SysUtils,
  System.JSON,
  Data.DB,

  ViaCEP.Intf,
  ViaCEP.Core,
  ViaCEP.Model,

  DataSet.Serialize,
  Horse,
  Horse.BasicAuthentication,
  Controller.Interfaces;

type
  TViewControllerConsultarCNPJ = class
    private
      FController : iController;
      FDataSource : TDataSource;
      FJSONObject : TJSONObject;
      FCNPJ       : String;
      FDataSet : TDataSet;

      procedure GetAll (Req: THorseRequest; Res: THorseResponse; Next : TProc);
      procedure Registry;
    public
      constructor Create;
      destructor Destroy; override;
  end;


implementation

uses
  Imp.Controller, FireDAC.Comp.Client;

{ TViewControllerConsultarCNPJ }

constructor TViewControllerConsultarCNPJ.Create;
begin
  FController := TController.New;
  FDataSource := TDataSource.Create(nil);
  Registry;
end;

destructor TViewControllerConsultarCNPJ.Destroy;
begin
  inherited;
end;

procedure TViewControllerConsultarCNPJ.GetAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  FCNPJ := Req.Query.Field('cnpj').AsString;
  if FController
      .FactoryUteis
        .Uteis
          .ValidaCnpjCeiCpf(FCNPJ, True) then
  begin
    try
      FJSONObject := FController
                       .FactoryConsultarAPI
                         .ConsultarCNPJReceitaWS
                           .ConsultarCNPJ(FCNPJ);
    except
      on E: Exception do
      begin
        WriteLn('Erro -ao tentar encontrar CNPJ: ' + E.Message);
        Abort;
      end;
    end;
    Res.Send(FJSONObject);
  end
  else
    Res.Status(400).Send('O número do CNPJ digitado é inválido!');
end;

procedure TViewControllerConsultarCNPJ.Registry;
begin
  THorse
    .Group
      .Prefix('api')
        .Get ('/cnpj' , GetAll);
end;

end.
