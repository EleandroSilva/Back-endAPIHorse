{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 09/05/2024 13:18           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Factory.Consultar.API.Interfaces;

interface

uses
  Model.ReceitaWS.Consultar.CNPJ.Interfaces;

type
  iFactoryConsultarAPI = Interface
    ['{4565EA9B-984C-488A-A67B-9C81227519CC}']
    function ConsultarCNPJReceitaWS : iConsultarCNPJ;
  End;

implementation

end.
