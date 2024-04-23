{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 13/03/2024 16:22           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Conexao.Firedac.Interfaces;

interface

uses
  Data.DB,
  FireDAC.Comp.Client;

type
  iConexao = interface
    ['{BF29FDDC-CD39-4E99-AD53-E16DE92AF119}']
    function Conexao(Value : TFDConnection) : iConexao;      overload;
    function Conexao                        : TFDConnection; overload;
    function StartTransaction               : iConexao;
    function Commit                         : iConexao;
    function Rollback                       : iConexao;
    function ConfigurarMySQL                : iConexao;
  end;

implementation

end.
