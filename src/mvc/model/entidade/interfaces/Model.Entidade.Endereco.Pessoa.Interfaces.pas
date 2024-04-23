unit Model.Entidade.Endereco.Pessoa.Interfaces;

interface

uses
  Model.Entidade.Endereco.Interfaces,
  Model.Entidade.Numero.Interfaces;

type
  iEntidadeEnderecoPessoa<T> = Interface
    ['{1EA54924-08A8-46BA-BEAE-1DAA535D98EE}']
    function Id        (Value : Integer) : iEntidadeEnderecoPessoa<T>; overload;
    function Id                          : Integer;                    overload;
    function IdEmpresa (Value : Integer) : iEntidadeEnderecoPessoa<T>; overload;
    function IdEmpresa                   : Integer;                    overload;
    function IdEndereco(Value : Integer) : iEntidadeEnderecoPessoa<T>; overload;
    function IdEndereco                         : Integer;             overload;
    function IdPessoa  (Value : Integer) : iEntidadeEnderecoPessoa<T>; overload;
    function IdPessoa                    : Integer;                    overload;

    //Injeção de dependência
    function Endereco : iEntidadeEndereco<iEntidadeEnderecoPessoa<T>>;
    function Numero   : iEntidadeNumero  <iEntidadeEnderecoPessoa<T>>;

    function &End : T;
  End;

implementation

end.
