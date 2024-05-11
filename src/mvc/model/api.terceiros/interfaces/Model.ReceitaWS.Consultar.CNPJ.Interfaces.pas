unit Model.ReceitaWS.Consultar.CNPJ.Interfaces;

interface

uses
  System.JSON;

type
  iConsultarCNPJ = Interface
    ['{E531C317-5264-46BE-A0AA-E186EBFC52F2}']
    function ConsultarCNPJ       (const CNPJ: string)  : TJSONObject;
    function IniciarConsulta     (const CNPJ: string)  : iConsultarCNPJ;
    function RetornoResposta     (const Name: string)  : String;
    function RetornoRespostaLista(const Lista: string) : TJSONArray;
  End;

implementation

end.
