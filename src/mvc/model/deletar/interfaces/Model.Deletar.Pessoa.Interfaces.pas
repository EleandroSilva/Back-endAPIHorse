{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 02/05/2024 19:27           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Deletar.Pessoa.Interfaces;

interface

uses
  Model.Entidade.Pessoa.Interfaces;

type
  iDeletarPessoa = Interface
    ['{F8E56C61-E99D-4BF1-88C6-18C70709339C}']
    function Delete : iDeletarPessoa;

    function Found  : Boolean;
    function Error  : Boolean;
    //injeção de dependência
    function Pessoa : iEntidadePessoa<iDeletarPessoa>;
    function &End   : iDeletarPessoa;
  End;

implementation

end.
