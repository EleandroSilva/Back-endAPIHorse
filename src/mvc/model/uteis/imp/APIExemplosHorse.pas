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



//Para criar um exemplo em Horse que lê o campo "cnpj" do JSON fornecido, você pode fazer o seguinte:
procedure TExemploHorse.ReadCNPJ(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  JSONObj: TJSONObject;
  CNPJ: string;
begin
  try
    // Faz o parse do corpo da requisição como JSON
    JSONObj := TJSONObject.ParseJSONValue(Req.Body) as TJSONObject;
    try
      // Obtém o valor do campo "cnpj"
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
//Quando você envia um JSON como o que você forneceu, o servidor lê o campo "cnpj"
//e retorna seu valor como resposta.
//Lembre-se de que este é um exemplo básico. Em uma aplicação real,
//você deve adicionar validações e tratamentos de erro adequados.
//Além disso, este exemplo não inclui o tratamento de CORS (Cross-Origin Resource Sharing),
//que pode ser necessário dependendo do seu ambiente de desenvolvimento.

end.
