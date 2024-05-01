unit Model.Entidade.Endereco.Empresa.Interfaces;

interface

uses
  Model.Entidade.Endereco.Interfaces,
  Model.Entidade.Numero.Interfaces;

type
  iEntidadeEnderecoEmpresa<T> = Interface
    ['{7522CABF-A400-4F5E-A053-FFEF2767571A}']
    function Id        (Value : Integer) : iEntidadeEnderecoEmpresa<T>; overload;
    function Id                          : Integer;                     overload;
    function IdEmpresa (Value : Integer) : iEntidadeEnderecoEmpresa<T>; overload;
    function IdEmpresa                   : Integer;                     overload;
    function IdEndereco(Value : Integer) : iEntidadeEnderecoEmpresa<T>; overload;
    function IdEndereco                  : Integer;                     overload;

    //Injeção de dependência
    function Endereco : iEntidadeEndereco<iEntidadeEnderecoEmpresa<T>>;
    function Numero   : iEntidadeNumero  <iEntidadeEnderecoEmpresa<T>>;

    function &End : T;
  End;

implementation

end.
