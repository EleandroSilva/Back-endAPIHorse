{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 30/04/2024 14:18           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Cadastrar.Endereco.Empresa.Interfaces;

interface

uses
  System.JSON,
  Model.Entidade.Endereco.Empresa.Interfaces;

type
  iCadastrarEnderecoEmpresa = interface
    ['{A7A6068A-1A4C-4D67-AE6B-59E12050D8CA}']
    function JSONObjectPai(Value : TJSONObject) : iCadastrarEnderecoEmpresa; overload;
    function JSONObjectPai                      : TJSONObject;               overload;
    function Post : iCadastrarEnderecoEmpresa;
    function Error : Boolean;

    //injeção de dependência
    function EnderecoEmpresa : iEntidadeEnderecoEmpresa<iCadastrarEnderecoEmpresa>;
    function &End : iCadastrarEnderecoEmpresa;
  end;

implementation

end.
