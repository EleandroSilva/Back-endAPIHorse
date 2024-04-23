unit Model.Entidade.Endereco.Empresa.Interfaces;

interface

uses
  Model.Entidade.Endereco.Interfaces,
  Model.Entidade.Numero.Interfaces;

type
  iEntidadeEnderecoEmpresa<T> = Interface
    ['{70A087E5-2329-4902-8B25-78FD009355E1}']
    function Id        (Value : Integer) : iEntidadeEnderecoEmpresa<T>; overload;
    function Id                          : Integer;                     overload;
    function IdEndereco(Value : Integer) : iEntidadeEnderecoEmpresa<T>; overload;
    function IdEndereco                  : Integer;                     overload;
    function IdEmpresa (Value : Integer) : iEntidadeEnderecoEmpresa<T>; overload;
    function IdEmpresa                   : Integer;                     overload;

    //Inje��o de depend�ncia
    function Endereco : iEntidadeEndereco<iEntidadeEnderecoEmpresa<T>>;
    function Numero   : iEntidadeNumero  <iEntidadeEnderecoEmpresa<T>>;

    function &End : T;
  End;

implementation

end.