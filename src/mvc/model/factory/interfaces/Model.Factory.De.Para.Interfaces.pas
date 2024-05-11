{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 10/05/2024 13:09           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Factory.De.Para.Interfaces;

interface

uses
  Model.De.Para.ReceitaWS.Empresa.Interfaces;

type
  iFactoryDePara = Interface
    ['{AAF30960-3DB9-4065-B82E-3941666EAB8F}']
    function DeParaReceitaWSEmpresa : iDeParaReceitaWSEmpresa;
  End;

implementation

end.
