{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 05/04/2024 15:27           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit View.Controller.Pessoa;

interface

uses
  System.Classes,
  System.SysUtils,
  System.JSON,
  Vcl.StdCtrls,
  Data.DB,
  FireDAC.Comp.Client,
  DataSet.Serialize,
  Horse,
  Horse.BasicAuthentication,
  Controller.Interfaces;
type
  TViewControllerPessoa = class
    private
      FController : iController;
      FIdPessoa   : Integer;
      FCPFCNPJ    : String;
      FError      : Boolean;

      //Json Pessoa-->tabela pai
      FJSONObjectPessoa  : TJSONObject;
      FJSONArrayPessoa   : TJSONArray;
      //DataSource
      FDataSource         : TDataSource;
      FDSPessoa           : TDataSource;
      FQuantidadeRegistro : Integer;

      procedure LoopPessoa;

      //Injeção de dependência
      function LoopEnderecoPessoa : TJSONValue;
      function LoopEmailPessoa    : TJSONValue;
      function LoopTelefonePessoa : TJSONValue;

      procedure GetAll (Req: THorseRequest; Res: THorseResponse; Next : TProc);
      procedure GetbyId(Req: THorseRequest; Res: THorseResponse; Next : TProc);
      procedure Post   (Req: THorseRequest; Res: THorseResponse; Next : TProc);
      procedure Put    (Req: THorseRequest; Res: THorseResponse; Next : TProc);
      procedure Delete (Req: THorseRequest; Res: THorseResponse; Next : TProc);
      function  CadastrarPessoa(Value : TJSONObject) : Boolean;
      function  AlterarPessoa  (Value : TJSONObject) : Boolean;
      procedure Registry;
    public
      constructor Create;
      destructor Destroy; override;
  end;

implementation

uses
  Imp.Controller;

constructor TViewControllerPessoa.Create;
begin
  FController       := TController.New;
  FDSPessoa         := TDataSource.Create(nil);
  Registry;
end;

destructor TViewControllerPessoa.Destroy;
begin
  inherited;
end;

procedure TViewControllerPessoa.LoopPessoa;
begin
  FJSONArrayPessoa := TJSONArray.Create;//Jsonarray Geral
  FDSPessoa.DataSet.First;
  while not FDSPessoa.DataSet.Eof do
  begin
    FIdPessoa := FDSPessoa.DataSet.FieldByName('id').AsInteger;
    FJSONObjectPessoa := TJSONObject.Create;//JSONObject(Tabela pai---> pessoa)
    try
      FJSONObjectPessoa := FDSPessoa.DataSet.ToJSONObject;
    except
      on E: Exception do
      begin
        WriteLn('Erro ao converter DataSet para JSONObject: ' + E.Message);
        Break;
      end;
    end;

    try
      FJSONObjectPessoa.AddPair('endereco' , LoopEnderecoPessoa);
    except
      on E: Exception do
      begin
        WriteLn('Erro durante o loop de endereços da pessoa, verificar as instruções SQL no DAOEnderecopessoa: ' + E.Message);
        Break;
      end;
    end;

    try
      FJSONObjectPessoa.AddPair('emailPessoa' , LoopEmailPessoa);
    except
      on E: Exception do
      begin
        WriteLn('Erro durante o loop de email da pessoa, verificar as instruções SQL no DAOEmailpessoa: ' + E.Message);
        Break;
      end;
    end;

    try
      FJSONObjectPessoa.AddPair('telefonePessoa' , LoopTelefonePessoa);
    except
      on E: Exception do
      begin
        WriteLn('Erro durante o loop de telefone da pessoa, verificar as instruções SQL no DAOEmailtelefone: ' + E.Message);
        Break;
      end;
    end;

    FJSONArrayPessoa.Add(FJSONObjectPessoa);

    FDSPessoa.DataSet.Next;
  end;
end;

//Endereco
function TViewControllerPessoa.LoopEnderecoPessoa : TJSONValue;
begin
  Result := FController
              .FactoryPesquisar
                .PesquisarEnderecoPessoa
                .EnderecoPessoa
                  .IdPessoa(FIdPessoa)
                .&End
                .LoopEnderecoPessoa;
end;

//Email
function TViewControllerPessoa.LoopEmailPessoa : TJSONValue;
begin
  Result := FController
              .FactoryPesquisar
                .PesquisarEmailPessoa
                  .EmailPessoa
                    .IdPessoa(FIdPessoa)
                  .&End
                  .LoopEmailPessoa;
end;

//Telefone
function TViewControllerPessoa.LoopTelefonePessoa: TJSONValue;
begin
  Result := FController
              .FactoryPesquisar
                .PesquisarTelefonePessoa
                  .TelefonePessoa
                    .IdPessoa(FIdPessoa)
                  .&End
                  .LoopTelefonePessoa;
end;

procedure TViewControllerPessoa.GetAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
      if Req.Query.Field('cpfcnpj').AsString<>'' then
        FQuantidadeRegistro := FController
                                .FactoryDAO
                                  .DAOPessoa
                                  .GetbyParams(Req.Query.Field('cpfcnpj').AsString)
                                  .DataSet(FDSPessoa)
                                  .QuantidadeRegistro
      else
      If Req.Query.Field('nomepessoa').AsString<>'' then
        FQuantidadeRegistro := FController
                                .FactoryDAO
                                  .DAOPessoa
                                  .GetbyParams(0, Req.Query.Field('nomepessoa').AsString)
                                  .DataSet(FDSPessoa)
                                  .QuantidadeRegistro
      else
        FQuantidadeRegistro := FController
                                .FactoryDAO
                                   .DAOPessoa
                                   .GetAll
                                   .DataSet(FDSPessoa)
                                   .QuantidadeRegistro;
  except
    on E: Exception do
    begin
      Res.Status(500).Send('Ocorreu um erro interno no servidor: '+ E.Message);
      Exit;
    end;
  end;

  if not FDSPessoa.DataSet.IsEmpty then
  begin
    LoopPessoa;
    if FQuantidadeRegistro > 1 then
      Res.Send<TJSONArray>(FJSONArrayPessoa)
    else
      Res.Send<TJSONObject>(FJSONObjectPessoa);

    Res.Status(201).Send('Registro encontrado com sucesso!');
  end
  else
    Res.Status(400).Send('Registro não encontrado!');
end;

procedure TViewControllerPessoa.GetbyId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Try
    FController
      .FactoryDAO
        .DAOPessoa
          .GetbyId(Req.Params['id'].ToInt64)
          .DataSet(FDSPessoa);

    FJSONObjectPessoa := FDSPessoa.DataSet.ToJSONObject();
    Res.Send<TJSONObject>(FJSONObjectPessoa);
  except
    on E: Exception do
    begin
      Res.Status(500).Send('Ocorreu um erro interno no servidor.');
      Exit;
    end;
  end;

  if not FDSPessoa.DataSet.IsEmpty then
  begin
    LoopPessoa;
    Res.Send<TJSONObject>(FJSONObjectPessoa);
    Res.Status(201).Send('Registro encontrado com sucesso!');
  end
  else
    Res.Status(400).Send('Registro não encontrado!')
end;

function TViewControllerPessoa.CadastrarPessoa(Value: TJSONObject): Boolean;
begin
  Result := False;
  //Obtém os dados JSON do corpo da requisição da tabela('pessoa')
  Result := FController
              .FactoryCadastrar
                .CadastrarPessoa
                  .Pessoa
                    .CPFCNPJ(FCPFCNPJ)
                  .&End
                .JSONObject(Value)
                .Post
                .Found;

  FError := FController
              .FactoryCadastrar
                .CadastrarEmpresa
                .Error;
end;

//Alterar pessoa
function TViewControllerPessoa.AlterarPessoa(Value: TJSONObject): Boolean;
begin
  Result := False;
  //Obtém os dados JSON do corpo da requisição da tabela('empresa')
  Result := FController
              .FactoryAlterar
                .AlterarPessoa
                  .Pessoa
                    .Id(FIdPessoa)
                  .&End
                .JSONObject(Value)
                .Put
                .Found;

  FError := FController
              .FactoryAlterar
                .AlterarPessoa
                .Error;
end;

procedure TViewControllerPessoa.Post(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  //Lê os dados JSON da requisição (tabela pai='pessoa')
  FJSONObjectPessoa := TJSONObject.ParseJSONValue(Req.Body) as TJSONObject;
  FCPFCNPJ := FJSONObjectPessoa.GetValue('cpfcnpj').Value;
  FController
    .FactoryUteis
      .Uteis
        .ValidaCnpjCeiCpf(FCPFCNPJ, True);
  FIdPessoa := FJSONObjectPessoa.GetValue<Integer>('idpessoa');

  if CadastrarPessoa(FJSONObjectPessoa) Then
  begin
    Res.Status(404).Send('Este registro já consta em nossa base de dados!');
    Exit;
  end
  else
    if FError then
    begin
      Res.Status(500).Send('Ocorreu um erro interno no servidor!');
      Exit;
    end
    else
    begin
      FJSONObjectPessoa := FDSPessoa.DataSet.ToJSONObject();
      Res.Send<TJSONObject>(FJSONObjectPessoa);
      Res.Status(204).Send('Registro incluído com sucesso!');
    end;
end;

procedure TViewControllerPessoa.Put(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  FJSONObjectPessoa := Req.Body<TJSONObject>; //Tabela Pai Pessoa
  FIdPessoa := Req.Params['id'].ToInt64;
  if not AlterarPessoa(FJSONObjectPessoa) then
  begin
    Res.Status(204).Send('Registro não encontrado!');
    Exit;
  end
  else
    if FError then
    begin
      Res.Status(500).Send('Ocorreu um erro interno no servidor!');
      Exit;
    end
    else
      Res.Status(204).Send('Registro alterado com sucesso!');
end;


procedure TViewControllerPessoa.Delete(Req: THorseRequest; Res: THorseResponse;  Next: TProc);
begin
  FIdPessoa := Req.Params['id'].ToInt64;//Tabela Pai Empresa
  if FController
       .FactoryDeletar
         .DeletarPessoa
           .Pessoa
             .Id(FIdPessoa)
           .&End
         .Delete
         .Error then
   Res.Status(500).Send('Ocorreu um erro interno no servidor!')
   else
   Res.Status(201).Send('Registro excluído com sucesso!');
end;

procedure TViewControllerPessoa.Registry;
begin
  THorse
      .Group
        .Prefix  ('bmw')
          .Get   ('/pessoa/:id' , GetbyId)
          .Get   ('/pessoa'     , GetAll)
          .Post  ('pessoa'      , Post)
          .Put   ('pessoa/:id'  , Put)
          .Delete('pessoa/:id'  , Delete);
end;

end.
