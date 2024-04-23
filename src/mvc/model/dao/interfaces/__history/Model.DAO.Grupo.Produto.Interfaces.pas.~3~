unit Model.DAO.Grupo.Produto.Interfaces;

interface

uses
  Data.DB,

  Model.Entidade.Grupo.Produto.Interfaces;

type
  iDAOGrupoProduto = interface
    ['{5A39611C-F9E4-4320-A5ED-44A57380FDA6}']
    function DataSet(DataSource : TDataSource) : iDAOGrupoProduto; overload;
    function DataSet                           : TDataSet;         overload;
    function GetAll                            : iDAOGrupoProduto;
    function GetbyId(Id : Variant)             : iDAOGrupoProduto;
    function GetbyParams                       : iDAOGrupoProduto;
    function Post                              : iDAOGrupoProduto;
    function Put                               : iDAOGrupoProduto;
    function Delete                            : iDAOGrupoProduto;

    function This : iEntidadeGrupoProduto<iDAOGrupoProduto>;
  end;

implementation

end.
