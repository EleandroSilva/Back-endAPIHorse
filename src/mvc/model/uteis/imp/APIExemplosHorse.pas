unit APIExemplosHorse;

interface

uses
  System.JSON,
  System.SysUtils,

  Horse,
  Horse.Commons;

type
  TExemploHorse = class
    private
      procedure ReadCNPJ(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    public
  end;




implementation



//Para criar um exemplo em Horse que l� o campo "cnpj" do JSON fornecido, voc� pode fazer o seguinte:
procedure TExemploHorse.ReadCNPJ(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  JSONObj: TJSONObject;
  CNPJ: string;
begin
  try
    // Faz o parse do corpo da requisi��o como JSON
    JSONObj := TJSONObject.ParseJSONValue(Req.Body) as TJSONObject;
    try
      // Obt�m o valor do campo "cnpj"
      CNPJ := JSONObj.GetValue('cnpj').Value;
      // Envia o valor do CNPJ na resposta
      Res.Send(CNPJ);
    finally
      JSONObj.Free;
    end;
  except
    on E: Exception do
    begin
      // Em caso de erro, envia uma mensagem de erro na resposta
      Res.Send('Erro ao processar o JSON: ' + E.Message).Status(THTTPStatus.InternalServerError);
    end;
  end;
end;
//Este exemplo cria um servidor Horse que escuta na porta 9000.
//Quando voc� envia um JSON como o que voc� forneceu, o servidor l� o campo "cnpj"
//e retorna seu valor como resposta.
//Lembre-se de que este � um exemplo b�sico. Em uma aplica��o real,
//voc� deve adicionar valida��es e tratamentos de erro adequados.
//Al�m disso, este exemplo n�o inclui o tratamento de CORS (Cross-Origin Resource Sharing),
//que pode ser necess�rio dependendo do seu ambiente de desenvolvimento.

end.
