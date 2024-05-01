{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 30/04/2024 14:18           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Deletar.Empresa.Interfaces;

interface

uses
  Model.Entidade.Empresa.Interfaces;

type
  iDeletarEmpresa = Interface
    ['{461DA23E-3FC8-4F89-A712-7FECE6AE57B0}']
    function Delete : iDeletarEmpresa;

    function Found  : Boolean;
    function Error  : Boolean;
    //injeção de dependência
    function Empresa : iEntidadeEmpresa<iDeletarEmpresa>;
    function &End    : iDeletarEmpresa;
  End;

implementation

end.
