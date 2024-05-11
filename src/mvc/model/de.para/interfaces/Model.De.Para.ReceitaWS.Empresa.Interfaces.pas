{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 10/05/2024 13:09           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.De.Para.ReceitaWS.Empresa.Interfaces;

interface

uses
  System.JSON;

type
  iDeParaReceitaWSEmpresa = interface
    ['{83140738-F8B5-406F-B208-40276A34A672}']
    function ConsultarDadosPorCNPJ(CNPJ : String) : TJSONObject;
  end;

implementation

end.
