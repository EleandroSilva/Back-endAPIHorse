unit Model.Conexao.Query.Imp;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,

  Data.DB,

  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,

  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces,
  Model.Conexao.Firedac.MySQL.Imp;

type
  TQuery = class(TInterfacedObject, iQuery)
    private
      FConexao    : iConexao;
      FQuery      : TFDQuery;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iQuery;

      function DataSet(DataSource : TDataSource)        : iQuery;   overload;
      function DataSet                                  : TDataSet; overload;
      function Params(Params : String; Value : Variant) : iQuery;   overload;
      function Params(Params : String)                  : Variant;  overload;
      function SQL(Value : String)                      : iQuery;
      function Add(Value : String)                      : iQuery;
      function ExecSQL                                  : iQuery;
      function Clear                                    : iQuery;
      function Close                                    : iQuery;
      function Open                                     : iQuery;
      function Query                                    : TObject;
  end;

implementation

{ TQuery }

constructor TQuery.Create;
begin
  FConexao          := TModelConexaoFiredacMySQL.New;
  FQuery            := TFDQuery.Create(nil);
  FQuery.Connection := FConexao.Conexao;
end;

destructor TQuery.Destroy;
begin
  FreeAndNil(FQuery);
  inherited;
end;

class function TQuery.New: iQuery;
begin
  Result := Self.Create;
end;

function TQuery.DataSet(DataSource: TDataSource): iQuery;
begin
  Result := Self;
  DataSource.DataSet := FQuery;
end;

function TQuery.DataSet: TDataSet;
begin
  Result := FQuery;
end;

function TQuery.Params(Params: String; Value: Variant): iQuery;
begin
  Result := Self;
  FQuery.ParamByName(Params).Value := Value;
end;

function TQuery.Params(Params: String): Variant;
begin
  Result := FQuery.ParamByName(Params).Value;
end;

function TQuery.SQL(Value: String): iQuery;
begin
  Result := Self;
  FQuery.SQL.Clear;
  FQuery.SQL.Add(Value);
end;

function TQuery.Add(Value: String): iQuery;
begin
  Result := Self;
  FQuery.SQL.Add(Value);
end;

function TQuery.ExecSQL: iQuery;
begin
  Result := Self;
  FQuery.ExecSQL;
end;

function TQuery.Clear: iQuery;
begin
  Result := Self;
  FQuery.SQL.Clear;
end;

function TQuery.Close: iQuery;
begin
  FQuery.Active := False;
end;

function TQuery.Open: iQuery;
begin
  Result := Self;
  FQuery.Active := True;
end;

function TQuery.Query: TObject;
begin
  Result := FQuery;
end;

end.
