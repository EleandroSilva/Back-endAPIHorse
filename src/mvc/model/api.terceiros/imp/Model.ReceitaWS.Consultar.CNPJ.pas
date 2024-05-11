unit Model.ReceitaWS.Consultar.CNPJ;

interface

uses
  Data.DB,
  System.JSON,
  Vcl.Controls,
  Vcl.Dialogs,
  System.SysUtils,

  REST.Client,
  REST.Types,
  REST.Response.Adapter,

  Model.ReceitaWS.Consultar.CNPJ.Interfaces;

type
  TConsultarCNPJ = class(TInterfacedObject, iConsultarCNPJ)
    private
      FRESTClient                 : TRESTClient;
      FRESTRequest                : TRESTRequest;
      FRESTResponse               : TRESTResponse;
      FRESTResponseDataSetAdapter : TRESTResponseDataSetAdapter;
      FJSONObject                 : TJSONObject;
      FUltimoCNPJ : String;

      const FBaseURL = 'https://receitaws.com.br/v1/cnpj/%s';
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iConsultarCNPJ;

      function ConsultarCNPJ       (const CNPJ: string)  : TJSONObject;
      function IniciarConsulta     (const CNPJ: string)  : iConsultarCNPJ;
      function RetornoResposta     (const Name: string)  : String;
      function RetornoRespostaLista(const Lista: string) : TJSONArray;
  end;

implementation

uses
  Model.Entidade.Imp.Empresa;

{ TConsultarCNPJ }

constructor TConsultarCNPJ.Create;
begin
  FRESTClient                 := TRESTClient.Create(nil);
  FRESTRequest                := TRESTRequest.Create(nil);
  FRESTResponse               := TRESTResponse.Create(nil);
  FRESTResponseDataSetAdapter := TRESTResponseDataSetAdapter.Create(nil);
end;

destructor TConsultarCNPJ.Destroy;
begin
  inherited;
end;

class function TConsultarCNPJ.New: iConsultarCNPJ;
begin
  Result := Self.Create;
end;

function TConsultarCNPJ.ConsultarCNPJ(const CNPJ: string): TJSONObject;
Var
  lButtonSelected: TModalResult;
begin
  {verificando se o CNPJ armazenado é o mesmo da nova solicitação}

  if FUltimoCNPJ = CNPJ then
  begin
    LButtonSelected := MessageDlg(
      'CNPJ Consultado anteriormente, deseja consultar novamente?'+
      ' Obs: A API tem um número limite de requisições por minuto, ' +
      'pode ser necessário aguardar para fazer a solicitação novamente.',
      TMsgDlgType.mtConfirmation,
      [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo],
      0
    );

    if LButtonSelected = mrYes then
    begin
      try
        IniciarConsulta(CNPJ);
      except
        on E:Exception do
        begin
          raise Exception.Create(E.Message);
        end;
      end;
    end
    else
    begin
      exit;
    end;
  end
  else
  begin
  // Se o CNPJ for diferente, realiza a consulta diretamente
    try
      IniciarConsulta(CNPJ);
    except
      on E:Exception do
      begin
        raise Exception.Create(E.Message);
      end;
    end;
    Result := FJSONObject;
  end;
end;

function TConsultarCNPJ.IniciarConsulta(const CNPJ: string): iConsultarCNPJ;
Var
  lStatusValue:String;
begin
   Result := Self;
   {definindo URL requisição}
    FRestClient.BaseURL:= Format(FBaseURL,[CNPJ]);
    FRestRequest.Client := FRestClient;
    FRestRequest.Method := rmGet;
    {executando requisição}
    FRestRequest.Execute;

    {tratando status do retorno}
    if FRestRequest.Response.StatusCode = 429 then
      raise Exception.Create('Você esta realizando muitas consultas. '+
                            'Aguarde um instante e tente novamente');

    if FRestRequest.Response.StatusCode = 504 then
      raise Exception.Create('TimeOut');


    FJSONObject := FRestRequest.Response.JSONValue as TJSONObject;

    {Tratando possiveis exceções}
    if FJSONObject.TryGetValue('status', LStatusValue) then
      if LStatusValue = 'ERROR' then
        raise Exception.Create(FJSONObject.Values['message'].Value);

    FUltimoCNPJ:=CNPJ;
end;

function TConsultarCNPJ.RetornoResposta(const Name: string): String;
begin
   Result := FJSONObject.Values[Name].Value;
end;

function TConsultarCNPJ.RetornoRespostaLista(const Lista: string): TJSONArray;
begin
  Result:= FJSONObject.Values[Lista] as TJSONArray;
end;

end.
