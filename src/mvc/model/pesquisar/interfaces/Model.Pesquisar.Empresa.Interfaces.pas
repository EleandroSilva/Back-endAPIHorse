{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 30/04/2024 20:04           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Pesquisar.Empresa.Interfaces;

interface

uses
  Model.Entidade.Empresa.Interfaces;

type
  iPesquisarEmpresa = interface
    ['{00437633-9628-4553-9A9E-B899A184DD87}']
    function GetbyId             (Id : Variant)             : iPesquisarEmpresa;
    function GetbyCNPJ           (CNPJ: String)             : iPesquisarEmpresa;
    function GetbyNomeEmpresarial(NomeEmpresarial : String) : iPesquisarEmpresa;
    function Found   : Boolean;
    function Error   : Boolean;
    function Empresa : iEntidadeEmpresa<iPesquisarEmpresa>;
    function &End    : iPesquisarEmpresa;
  end;

implementation

end.
