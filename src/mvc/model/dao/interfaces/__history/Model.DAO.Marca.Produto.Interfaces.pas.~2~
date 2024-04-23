unit Model.DAO.Marca.Produto.Interfaces;

interface

uses
  Data.DB,

  Model.Entidade.Marca.Produto.Interfaces;

type
  iDAOMarcaProduto = interface
    ['{5A39611C-F9E4-4320-A5ED-44A57380FDA6}']
    function DataSet(DataSource : TDataSource) : iDAOMarcaProduto; overload;
    function DataSet                           : TDataSet;         overload;
    function GetAll                            : iDAOMarcaProduto;
    function GetbyId(Id : Variant)             : iDAOMarcaProduto;
    function GetbyParams                       : iDAOMarcaProduto;
    function Post                              : iDAOMarcaProduto;
    function Put                               : iDAOMarcaProduto;
    function Delete                            : iDAOMarcaProduto;

    function This : iEntidadeMarcaProduto<iDAOMarcaProduto>;
  end;

implementation

end.
