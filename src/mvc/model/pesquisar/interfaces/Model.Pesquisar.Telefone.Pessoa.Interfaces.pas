{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 02/05/2024 10:23           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Pesquisar.Telefone.Pessoa.Interfaces;

interface

uses
  System.JSON, Model.Entidade.Telefone.Pessoa.Interfaces;

type
  iPesquisarTelefonePessoa = Interface
    ['{D7762EA5-A871-4D44-AB7D-79905C3C5EF7}']
    function GetBy(IdPessoa : Integer; DDD, NumeroTelefone: String) :iPesquisarTelefonePessoa;
    function LoopTelefonePessoa : TJSONValue;
    function Found : Boolean;
    function Error : Boolean;

    //inje��o de depend�ncia
    function TelefonePessoa : iEntidadeTelefonePessoa<iPesquisarTelefonePessoa>;
    function &End : iPesquisarTelefonePessoa;
  End;

implementation

end.
