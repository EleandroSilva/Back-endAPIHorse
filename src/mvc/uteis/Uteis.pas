{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{            Início do projeto 27/05/2023               }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2023                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Uteis;

interface

uses
  System.Classes,
  System.SysUtils,
  Vcl.Forms,
  Winapi.Windows,
  Uteis.Interfaces;

Type
  TUteis = class(TInterfacedObject, iUteis)
  private
    //
  public
    constructor Create;
    Destructor Destroy; override;
    class function New : iUteis;
    function ValidaCnpjCeiCpf(Numero: String; ExibeMsgErro: Boolean=True): Boolean;
    function PegarApenasNumero(Value : String): String;
    function Pesquisar(Key, Value: string): string;
  end;

implementation

constructor TUteis.Create;
begin
  //
end;

destructor TUteis.Destroy;
begin
  inherited;
end;

class function TUteis.New: iUteis;
begin
  Result := Self.Create;
end;

function TUteis.ValidaCnpjCeiCpf(Numero: String; ExibeMsgErro: Boolean=True): Boolean;
//Verifica se o numero passado no parametro é CNPJ/CPF ou CEI e valida o mesmo. Se nao for válido e o parametro
//ExibeMSGErro for true, exibe um messagebox co icone de erro.
var
  i,d,b,
  Digito : Byte;
  Soma : Integer;
  CNPJ,CPF,CEI : Boolean;
  DgPass,
  DgCalc,DocMsg, MsgDialogo : String;

  function IIf(pCond:Boolean;pTrue,pFalse:Variant): Variant;
  begin
    If pCond Then Result := pTrue
    else Result := pFalse;
  end;

  function ValidaCEI(StrCEI:String):Boolean;
  const
    PESO = '74185216374';
  var
    Numero,DV_DIG,StrSoma :String;
    soma,i,valor1,valor2,
    resto,PRIDIG          :integer;
  begin
    Result := True;

    if Length(Trim(StrCEI)) = 0 then Exit;

    Numero := Copy(StrCEI,Length(StrCEI)-12+1,12);
    DV_DIG := Copy(Numero,12,1);
    soma   := 0;

    for i:= 1 to 11 do
      soma := soma + (StrToInt(Copy(Numero,i,1)) * StrToInt(Copy(PESO,i,1)));

    StrSoma:= FormatFloat('0000',soma);
    valor1 := StrToInt(Copy(StrSoma,4,1));
    valor2 := StrToInt(Copy(StrSoma,3,1));
    resto  := (valor1+valor2) Mod 10;

    if resto <> 0 then PRIDIG := 10 - resto;

    if PRIDIG <> StrToInt(DV_DIG) then
      Result := False;
  end;

begin
  Result := False;
  Numero := PegarApenasNumero(Numero);
  // Caso o número não seja 11 (CPF) ou 14 (CNPJ), aborta

  CPF := Length(Numero)=11;
  CNPJ:= Length(Numero)=14;
  CEI := Length(Numero)=12;

  case Length(Numero) of
    11: DocMsg:= 'CPF';
    14: DocMsg:= 'CNPJ';
    12: DocMsg:= 'CEI';
  end;

  if (Length(Numero) in [11,12,14]) then
  begin
    if CPF or CNPJ then
    begin
      // Separa o número do dígito
      DgCalc := '';
      DgPass := Copy(Numero,Length(Numero)-1,2);
      Numero := Copy(Numero,1,Length(Numero)-2);
      // Calcula o digito 1 e 2
      for d := 1 to 2 do
      begin
        B := IIF(D=1,2,3); // BYTE
        SOMA := IIF(D=1,0,STRTOINTDEF(DGCALC,0)*2);
        for i := Length(Numero) downto 1 do begin
          Soma := Soma + (Ord(Numero[I])-Ord('0'))*b;
          Inc(b);
          if (b > 9) And CNPJ Then
            b := 2;
        end;
        Digito := 11 - Soma mod 11;
        if Digito >= 10 then
          Digito := 0;
        DgCalc := DgCalc + Chr(Digito + Ord('0'));
      end;
      Result := DgCalc = DgPass;
    end
    else
      Result := ValidaCEI(Numero);
    MsgDialogo:= 'O número do '+DocMsg+' digitado é inválido!';
  end
  else
  begin
    MsgDialogo:= 'O número '+Numero+' digitado é inválido!'+#13+'Não equivale a nenhum CNPJ/CPF ou CEI válido no país.';
  end;
  if (not Result) and (ExibeMsgErro) then
    Application.MessageBox(Pchar(MsgDialogo),'Atenção',mb_ICONERROR+MB_OK);

end;

function TUteis.PegarApenasNumero(Value : String): String;
var
  I : Byte;
begin
   Result := '';
   for I := 1 To Length(Value) do
     if Value [I] In ['0'..'9'] Then
       Result := Result + Value [I];
end;

function TUteis.Pesquisar(Key, Value: string): string;
var
  L: TsTringlist;
  P: string;
  i: Integer;
  Resultado: string;
begin
  try
    L := TsTringlist.Create;
    i := 1;
    while i <= Length(Value) do
    begin
      if (Value[i] <> ';') then
      begin
        P := P + Value[i];
        inc(i);
      end
      else
      begin
        inc(i);
        L.Add(Trim(P));
        P := '';
      end;

    end;
    L.Add(P);

    for i := 0 to L.Count - 1 do
    begin
      if i >= 1 then
        L.Strings[i] := '%' + UpperCase(L.Strings[i]) + '%'
      else
        L.Strings[i] := UpperCase(L.Strings[i]) + '%';
    end;

    Resultado := '';
    for i := 0 to L.Count - 1 do
    begin
      if i > 0 then
        Resultado := Resultado + ' ' + 'AND' + ' ';
      Resultado := Resultado + ' (Upper(' + Key + ') Like ' + Char(39) + L.Strings[i] + Char(39) + ')';
    end;
    Result := Resultado;
  finally
    FreeAndNil(L);
  end;
end;

end.
