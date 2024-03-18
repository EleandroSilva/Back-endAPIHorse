{*******************************************************}
{                    API PDV - JSON                     }
{                      ES Sistemas                      }
{            Início do projeto 27/05/2023               }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2023                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}

unit Uteis.Tratar.Mensagens;

interface

uses
  System.SysUtils,
  System.Classes,

  Vcl.Forms,
  Vcl.Dialogs;


type
  TMensagens = class
    private
      FlogFile : String;
    public
      constructor Create;

      procedure TratarException(Sender : TObject; E : Exception);
      procedure GravarLog(Value : String);
      function Mensagemok(Value : Integer) : String;
      function MSGnotGet     : String;
      function MSGerroGet    : String;
      function MSGokPost     : String;
      function MSGerroPost   : String;
      function MSGokPut      : String;
      function MSGerroPut    : String;
      function MSGokDelete   : String;
      function MSGerroDelete : String;
  end;

implementation

{ TTratarMensagens }

constructor TMensagens.Create;
begin
  FLogFile := ChangeFileExt(ParamStr(0), '.log');
  Application.OnException := TratarException;
end;

procedure TMensagens.GravarLog(Value: String);
var
  LTXTLog : TextFile;
begin
  AssignFile(LTXTLog, FLogFile);
  if FileExists(FLogFile) then
    Append(LTXTLog) else Rewrite(LTXTLog);


  Writeln(LTXTLog, FormatDateTime('dd/mm/yyyy - ', now) + Value);
  CloseFile(LTXTLog);
end;

function TMensagens.mensagemOK(Value: integer): String;
begin
  case Value of
   0 : Result := 'Registro salvo com sucesso';
   1 : Result := 'Registro atualizado com sucesso';
   2 : Result := 'Registro excluído com sucesso';
   3 : Result := 'Registro não encontrado';
  end;
end;

function TMensagens.MSGokDelete: String;
begin
  Result :='Registro excluído com sucesso';
end;

function TMensagens.MSGerroDelete: String;
begin
  Result :='Erro ao tentar excluir o registro';
end;

function TMensagens.MSGerroGet: String;
begin
  Result :='ao tentar filtrar o registro';
end;

function TMensagens.MSGerroPost: String;
begin
  Result :='Erro ao gravar o registro';
end;

function TMensagens.MSGerroPut: String;
begin
  Result :='Erro ao tentar atualizar o registro';
end;

function TMensagens.MSGnotGet: String;
begin
  Result :='Registro não encontrado';
end;

function TMensagens.MSGokPost: String;
begin
  Result :='Registro salvo com sucesso';
end;

function TMensagens.MSGokPut: String;
begin
  Result :='Registro atualizado com sucesso';
end;


procedure TMensagens.TratarException(Sender: TObject; E: Exception);
begin
  GravarLog('===================================================');
  if TComponent(Sender) is TForm then
  begin
    GravarLog('Form: '+ TForm(Sender).Name);
    GravarLog('Caption: '+ TForm(Sender).Caption);
    GravarLog('Erro: '+ E.ClassName);
    GravarLog('Erro: '+ E.Message);
  end
  else
  begin
    GravarLog('Form: '+ TForm(TComponent(Sender).Owner).Name);
    GravarLog('Caption: '+ TForm(TComponent(Sender).Owner).Caption);
    GravarLog('Erro: '+ E.ClassName);
    GravarLog('Erro: '+ E.Message);
  end;
  ShowMessage(E.Message);
end;

var
  FException : TMensagens;

initialization
  FException := TMensagens.Create;

finalization
  FreeAndNIl(FException);
end.
