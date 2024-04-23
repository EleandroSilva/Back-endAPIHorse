unit Uteis.Interfaces;

interface

type
  iUteis = interface
    ['{FA49E1BB-F056-4907-AC79-365B5C512A85}']
    function ValidaCnpjCeiCpf (Numero: String; ExibeMsgErro: Boolean=True): Boolean;
    function PegarApenasNumero(Value : String): String;
    function Pesquisar        (Key, Value: string): string;
  end;

implementation

end.
