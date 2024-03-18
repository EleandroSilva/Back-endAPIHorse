{*******************************************************}
{                    API PDV - JSON                     }
{                      ES Sistemas                      }
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
  System.SysUtils;

Type
  TUteis = class
  private
  public
    function Pesquisar(Key, Value: string): string;
  end;

implementation

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
