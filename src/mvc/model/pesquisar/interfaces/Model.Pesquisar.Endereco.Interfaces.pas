{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 01/05/2024 13:38           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Pesquisar.Endereco.Interfaces;

interface

uses
  Model.Entidade.Endereco.Interfaces;

type
  iPesquisarEndereco = Interface
    ['{3BCA3CE6-9D62-44EB-9D35-5CF28EDF36D5}']
    function GetbyCep(Cep : String) : iPesquisarEndereco;
    function Found    : Boolean;
    function Error    : Boolean;
    function Endereco : iEntidadeEndereco<iPesquisarEndereco>;
    function &End     : iPesquisarEndereco;
  End;

implementation

end.
