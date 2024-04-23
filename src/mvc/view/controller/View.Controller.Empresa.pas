{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 13/03/2024 17:18           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit View.Controller.Empresa;

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
  TViewControllerEmpresa = class
    private
      FIdEmpresa    : Integer;
      FIdEmpresaStr : String;
      FDataEmissao  : String;
      FIdEndereco   : Integer;
      FCep          : String;
      FNumero       : String;
      FController   : iController;

      FBody       : TJSONValue;
      FJSONObject : TJSONObject;
      FJSONArray  : TJSONArray;

      //Json empresa-->tabela pai
      FJSONObjectEmpresa  : TJSONObject;
      FJSONArrayEmpresa   : TJSONArray;
      //Json - endereco
      FJSONObjectEndereco : TJSONObject;
      FJSONArrayEndereco  : TJSONArray;
      //Json EMail
      FJSONObjectEMail    : TJSONObject;
      FJSONArrayEmail     : TJSONArray;
      //Json Telefone
      FJSONObjectTelefone : TJSONObject;
      FJSONArrayTelefone  : TJSONArray;

      //DataSource
      FDSEmpresa          : TDataSource;
      FDSEndereco         : TDataSource;
      FDSNumero           : TDataSource;
      FDSEnderecoEmpresa  : TDataSource;
      FDSEmailEmpresa     : TDataSource;
      FDSTelefoneEmpresa  : TDataSource;
      FQuantidadeRegistro : Integer;
      //procedure
      procedure GetAll   (Req: THorseRequest; Res: THorseResponse; Next : TProc);
      procedure GetbyId  (Req: THorseRequest; Res: THorseResponse; Next : TProc);
      procedure Post     (Req: THorseRequest; Res: THorseResponse; Next : TProc);
      procedure Put      (Req: THorseRequest; Res: THorseResponse; Next : TProc);
      procedure Delete   (Req: THorseRequest; Res: THorseResponse; Next : TProc);
      procedure LoopEmpresa;
      //loop
      function LoopEnderecoEmpresa : Boolean;
      function LoopEmailEmpresa    : Boolean;
      function LoopTelefoneEmpresa : Boolean;
      //verificando se existe cadastrado em tabela espec�fica
      function BuscarCNPJ           (aCNPJ : String)                                    : Boolean;
      function BuscarEndereco       (aCep  : String)                                    : Boolean;
      function BuscarNumero         (aIdEndereco : Integer; aNumeroEndereco : String)   : Boolean;
      function BuscarEnderecoEmpresa(aIdEmpresa, aIdEndereco : Integer)                 : Boolean;
      function BuscarEmailEmpresa   (IdEmpresa : Integer; Email : String)               : Boolean;
      function BuscarTelefoneEmpresa(IdEmpresa : Integer; DDD, NumeroTelefone : String) : Boolean;
      procedure Registry;
    public
      constructor Create;
      destructor Destroy; override;
  end;

implementation

uses
  Imp.Controller;

constructor TViewControllerEmpresa.Create;
begin
  FController        := TController.New;
  FDSEmpresa         := TDataSource.Create(nil);
  FDSEndereco        := TDataSource.Create(nil);
  FDSNumero          := TDataSource.Create(nil);
  FDSEnderecoEmpresa := TDataSource.Create(nil);
  FDSEmailEmpresa    := TDataSource.Create(nil);
  FDSTelefoneEmpresa := TDataSource.Create(nil);
  Registry;
end;

destructor TViewControllerEmpresa.Destroy;
begin
  inherited;
end;

//verifico se j� consta o cnpj cadastrado na tabela empresa
function TViewControllerEmpresa.BuscarCNPJ(aCNPJ : String): Boolean;
begin
  Result := False;
  FController
    .FactoryEntidade
      .DAOEmpresa
        .GetbyParams(aCNPJ)
      .DataSet(FDSEmpresa);

  Result := not FDSEmpresa.DataSet.IsEmpty;
end;

//verifico se j� consta o endereco cadastrado na tabela endereco-pelo cep
function TViewControllerEmpresa.BuscarEndereco(aCep: String): Boolean;
begin
  Result := False;
  FController
    .FactoryEntidade
      .DAOEndereco
      .GetbyParams(aCep)
      .DataSet(FDSEndereco);

  Result:= not FDSEndereco.DataSet.IsEmpty;
end;

//verifico se j� consta este n�mero cadastrado na tabela numero
function TViewControllerEmpresa.BuscarNumero(aIdEndereco : Integer; aNumeroEndereco : String): Boolean;
begin
  Result := False;
  FController
    .FactoryEntidade
      .DAONumero
        .This
          .IdEndereco    (aIdEndereco)
          .NumeroEndereco(aNumeroEndereco)
        .&End
      .GetbyParams
      .DataSet(FDSNumero);

  Result := not FDSNumero.DataSet.IsEmpty;
end;

//verifico se j� consta este n�mero cadastrado na tabela enderecoempresa
function TViewControllerEmpresa.BuscarEnderecoEmpresa(aIdEmpresa, aIdEndereco : Integer): Boolean;
begin
  Result := False;
  FController
    .FactoryEntidade
      .DAOEnderecoEmpresa
        .GetbyParams(aIdEmpresa, aIdEndereco)
        .DataSet(FDSEnderecoEmpresa);

  Result := not FDSEnderecoEmpresa.DataSet.IsEmpty;
end;

//verifico se j� consta este EMail cadastrado na tabela emailempresa
function TViewControllerEmpresa.BuscarEmailEmpresa(IdEmpresa : Integer; Email : String): Boolean;
begin
  Result := False;
  FController
    .FactoryEntidade
      .DAOEmailEmpresa
        .This
          .IdEmpresa(IdEmpresa)
          .Email    (Email)
        .&End
      .GetbyParams
      .DataSet(FDSEmailEmpresa);

  Result := not FDSEmailEmpresa.DataSet.IsEmpty;
end;

//verifico se j� consta este EMail esta cadastrado na tabela emailempresa que se relaciona com a tabela empresa
function TViewControllerEmpresa.BuscarTelefoneEmpresa(IdEmpresa : Integer; DDD, NumeroTelefone : String): Boolean;
begin
  Result := False;
  FController
    .FactoryEntidade
      .DAOTelefoneEmpresa
        .This
          .IdEmpresa     (IdEmpresa)
          .DDD           (DDD)
          .NumeroTelefone(NumeroTelefone)
        .&End
      .GetbyParams
      .DataSet(FDSTelefoneEmpresa);

  Result := not FDSEmailEmpresa.DataSet.IsEmpty;
end;

procedure TViewControllerEmpresa.LoopEmpresa;
begin
  FJSONArrayEmpresa := TJSONArray.Create;//JSONArray tabela pai empresa
  FDSEmpresa.DataSet.First;
  while not FDSEmpresa.DataSet.Eof do
  begin
    FJSONObjectEmpresa := TJSONObject.Create;//JSONObject tabela pai empresa
    try
      FJSONObjectEmpresa := FDSEmpresa.DataSet.ToJSONObject;
    except
      on E: Exception do
      begin
        WriteLn('Erro ao converter DataSet para JSONObject: ' + E.Message);
        Break;
      end;
    end;

    try
      if LoopEnderecoEmpresa then
        if FQuantidadeRegistro > 1 then
          FJSONObjectEmpresa.AddPair('endereco' , FJSONArrayEndereco) else
          FJSONObjectEmpresa.AddPair('endereco' , FJSONObjectEndereco);
    except
      on E: Exception do
      begin
        WriteLn('Erro durante o loop de endere�os da empresa, verificar as instru��es SQL no DAOEnderecoempresa: ' + E.Message);
        Break;
      end;
    end;

    Try
      if LoopEmailEmpresa then
        if FQuantidadeRegistro > 1 then
          FJSONObjectEmpresa.AddPair('emailempresa'    , FJSONArrayEmail) else //Json tabela emailempresa
          FJSONObjectEmpresa.AddPair('emailempresa'    , FJSONObjectEMail);
    except
      on E: Exception do
        WriteLn('Erro durante o loop de Email da empresa: ' + E.Message);
    End;

    try
      if LoopTelefoneEmpresa then
        if FQuantidadeRegistro > 1 then
          FJSONObjectEmpresa.AddPair('telefoneempresa' , FJSONArrayTelefone) else//Json tabela telefoneempresa
          FJSONObjectEmpresa.AddPair('telefoneempresa' , FJSONObjectTelefone);
    except
      on E: Exception do
        WriteLn('Erro durante o loop de Telefone da empresa: ' + E.Message);
    end;

    FJSONArrayEmpresa.Add(FJSONObjectEmpresa);
    FDSEmpresa.DataSet.Next;
  end;
end;

//Endereco
function TViewControllerEmpresa.LoopEnderecoEmpresa : Boolean;
begin
  Result := False;
  FQuantidadeRegistro:= FController
                           .FactoryEntidade
                             .DAOEnderecoEmpresa
                               .This
                                 .IdEmpresa(FDSEmpresa.DataSet.FieldByName('id').AsInteger)
                               .&End
                             .GetbyParams
                             .DataSet(FDSEndereco)
                             .QuantidadeRegistro;

  if not FDSEndereco.DataSet.IsEmpty then
  begin
    Result := True;
    FJSONArrayEndereco := TJSONArray.Create;

    FDSEndereco.DataSet.First;
    while not FDSEndereco.DataSet.Eof do
    begin
      FJSONObjectEndereco := TJSONObject.Create;
      FJSONObjectEndereco := FDSEndereco.DataSet.ToJSONObject;
      // Se tiver mais de um registro, adiciona ao array
      if FQuantidadeRegistro > 1 then
        FJSONArrayEndereco.Add(FJSONObjectEndereco);

      FDSEndereco.DataSet.Next;
    end;
  end;
end;

//Email
function TViewControllerEmpresa.LoopEmailEmpresa : Boolean;
begin
  Result := False;
  FQuantidadeRegistro:= FController
                           .FactoryEntidade
                             .DAOEmailEmpresa
                               .This
                                 .IdEmpresa(FDSEmpresa.DataSet.FieldByName('id').AsInteger)
                               .&End
                             .GetbyParams
                             .DataSet(FDSEmailEmpresa)
                             .QuantidadeRegistro;

  if not FDSEmailEmpresa.DataSet.IsEmpty then
  begin
    Result := True;
    FJSONArrayEmail := TJSONArray.Create;

    FDSEmailEmpresa.DataSet.First;
    while not FDSEmailEmpresa.DataSet.Eof do
    begin
      FJSONObjectEMail := TJSONObject.Create;
      FJSONObjectEMail := FDSEmailEmpresa.DataSet.ToJSONObject;
      //tendo mais de um registro, adiciona ao array
      if FQuantidadeRegistro > 1 then
        FJSONArrayEmail.Add(FJSONObjectEMail);

      FDSEmailEmpresa.DataSet.Next;
    end;
  end;
end;

//Telefone
function TViewControllerEmpresa.LoopTelefoneEmpresa: Boolean;
begin
  Result := False;
  FQuantidadeRegistro:= FController
                           .FactoryEntidade
                              .DAOTelefoneEmpresa
                                .This
                                  .IdEmpresa(FDSEmpresa.DataSet.FieldByName('id').AsInteger)
                                .&End
                              .GetbyParams
                              .DataSet(FDSTelefoneEmpresa)
                              .QuantidadeRegistro;

  if not FDSTelefoneEmpresa.DataSet.IsEmpty then
  begin
    Result := True;
    FJSONArrayTelefone := TJSONArray.Create;//JSONArray

    FDSTelefoneEmpresa.DataSet.First;
    while not FDSTelefoneEmpresa.DataSet.Eof do
    begin
      FJSONObjectTelefone := TJSONObject.Create;//JSONObject
      FJSONObjectTelefone := FDSTelefoneEmpresa.DataSet.ToJSONObject;
      // Se tiver mais de um registro, adiciona ao array
      if FQuantidadeRegistro > 1 then
        FJSONArrayTelefone.Add(FJSONObjectTelefone);

      FDSTelefoneEmpresa.DataSet.Next;
    end;
  end;
end;


procedure TViewControllerEmpresa.GetAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lQuantidadeRegistro : Integer;
begin
  lQuantidadeRegistro := 0;
  try
    if Req.Query.Field('cnpj').AsString<>'' then
      lQuantidadeRegistro := FController
                                .FactoryEntidade
                                  .DAOEmpresa
                                  .GetbyParams(Req.Query.Field('cnpj').AsString)
                                  .DataSet(FDSEmpresa)
                                  .QuantidadeRegistro
      else
     if Req.Query.Field('nomeempresarial').AsString<>'' then
      lQuantidadeRegistro := FController
                                .FactoryEntidade
                                  .DAOEmpresa
                                    .This
                                      .NomeEmpresarial(Req.Query.Field('nomeempresarial').AsString)
                                    .&End
                                  .GetbyParams
                                  .DataSet(FDSEmpresa)
                                  .QuantidadeRegistro
    else
      lQuantidadeRegistro := FController
                                .FactoryEntidade
                                  .DAOEmpresa
                                  .GetAll
                                  .DataSet(FDSEmpresa)
                                  .QuantidadeRegistro;
  except
    on E: Exception do
    begin
      Res.Status(500).Send('Ocorreu um erro interno no servidor: '+ E.Message);
      Exit;
    end;
  end;

  if not FDSEmpresa.DataSet.IsEmpty then
  begin
    LoopEmpresa;
      if lQuantidadeRegistro > 1 then
        Res.Send<TJSONArray>(FJSONArrayEmpresa) else
        Res.Send<TJSONObject>(FJSONObjectEmpresa);

    Res.Status(201).Send('Registro encontrado com sucesso!');
  end
  else
    Res.Status(400).Send('Registro n�o encontrado!');
end;

procedure TViewControllerEmpresa.GetbyId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Try
    FController
      .FactoryEntidade
        .DAOEmpresa
          .GetbyId(Req.Params['id'].ToInt64)
        .DataSet(FDSEmpresa);

    FJSONObjectEmpresa := FDSEmpresa.DataSet.ToJSONObject();
    Res.Send<TJSONObject>(FJSONObjectEmpresa);

  except
    on E: Exception do
    begin
      Res.Status(500).Send('Ocorreu um erro interno no servidor: ' + E.Message);
      Exit;
    end;
  end;

  if not FDSEmpresa.DataSet.IsEmpty then
  begin
    LoopEmpresa;
    Res.Send<TJSONObject>(FJSONObjectEmpresa);
    Res.Status(201).Send('Registro encontrado com sucesso!');
  end
  else
    Res.Status(400).Send('Registro n�o encontrado!');
end;

procedure TViewControllerEmpresa.Post(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  LObjectEmpresa  : TJSONObject;//JSONObject-empresa
  LArrayEndereco  : TJSONArray; //JSONArray -endereco
  LEnderecoObject : TJSONObject;//JSONObject-endereco
  LNumeroArray    : TJSONArray;//JSONArray-numero
  LNumeroObject   : TJSONObject;//JSONObject-numero
  LEmailArray     : TJSONArray; //JSONArray -email
  LEmailObject    : TJSONObject;//JSONObject-email
  LTelefoneArray  : TJSONArray; //JSONArray -telefone
  LTelefoneObject : TJSONObject;//JSONObject-telefone

  I : Integer;
  LNumero, LCNPJ : String;
begin
  //L� os dados JSON da requisi��o (tabela pai='empresa')
  LObjectEmpresa := TJSONObject.ParseJSONValue(Req.Body) as TJSONObject;
  LCNPJ          := LObjectEmpresa.GetValue('cnpj').Value;
  FController.FactoryEntidade.Uteis.ValidaCnpjCeiCpf(LCNPJ, True);
  try
    if not BuscarCNPJ(LCNPJ) then
    begin
      Res.Status(400).Send('Este CNPJ j� consta em nossa base de dados!');
      Exit;
    end;
  except
   on E: Exception do
   begin
      Res.Status(500).Send('Ocorreu um erro interno no servidor.'+ E.Message);
      Exit;
   end;
  end;

  //tabela pai
  LObjectEmpresa := Req.Body<TJSONObject>;
  try
    try
      try
        FController
            .FactoryEntidade
              .DAOEmpresa
                .This
                  .CNPJ                 (LObjectEmpresa.GetValue<String>   ('cnpj'))
                  .InscricaoEstadual    (LObjectEmpresa.GetValue<String>   ('inscricaoestadual'))
                  .NomeEmpresarial      (LObjectEmpresa.GetValue<String>   ('nomeempresarial'))
                  .NomeFantasia         (LObjectEmpresa.GetValue<String>   ('nomefantasia'))
                  .IdNaturezaJuridica   (LObjectEmpresa.GetValue<Integer>  ('idnaturezajuridica'))
                  .DataHoraEmissao      (LObjectEmpresa.GetValue<TDateTime>('datahoraemissao'))
                  .DataSituacaoCadastral(LObjectEmpresa.GetValue<TDateTime>('datasituacaocadastral'))
                  .Ativo                (1)
                .&End
              .Post
              .DataSet(FDSEmpresa);
          FIdEmpresa := FDSEmpresa.DataSet.FieldByName('id').AsInteger;
      except
        on E: Exception do
        begin
          Res.Status(500).Send('Ocorreu um erro interno no servidor.');
          Exit;
        end;
      end;

      //Obt�m os dados JSON do corpo da requisi��o da tabela('endereco')
      LArrayEndereco := LObjectEmpresa.GetValue('endereco') as TJSONArray;
      try
        // Loop do(s) endere�o(s)
        for I := 0 to LArrayEndereco.Count - 1 do
        begin
          //Extraindo os dados do endere�o e salvando no banco de dados
          LEnderecoObject := LArrayEndereco.Items[I] as TJSONObject;
          //verificando se j� consta este cep cadastrado na tabela endereco(se n�o estiver insiro o mesmo)
          if BuscarEndereco(LEnderecoObject.GetValue<String>('cep')) then
            FController
              .FactoryEntidade
                .DAOEndereco
                  .This
                    .Cep           (LEnderecoObject.GetValue<String> ('cep'))
                    .IBGE          (LEnderecoObject.GetValue<Integer>('ibge'))
                    .UF            (LEnderecoObject.GetValue<String> ('uf'))
                    .TipoLogradouro(LEnderecoObject.GetValue<String> ('tipologradouro'))
                    .Logradouro    (LEnderecoObject.GetValue<String> ('logradouro'))
                    .Bairro        (LEnderecoObject.GetValue<String> ('bairro'))
                    .GIA           (LEnderecoObject.GetValue<Integer>('gia'))
                    .DDD           (LEnderecoObject.GetValue<String> ('ddd'))
                  .&End
                .Post
                .DataSet(FDSEndereco);

          FIdEndereco := FDSEndereco.DataSet.FieldByName('id').AsInteger;
          LNumeroArray  := LObjectEmpresa.GetValue('numero') as TJSONArray;
          LNumeroObject :=  LNumeroArray.Items[I] as TJSONObject;
          //verifico se consta este n�mero cadastrado na tabela numero(se n�o estiver insiro o mesmo)
          if BuscarNumero(FIdEndereco, LNumeroObject.GetValue<String>('numeroendereco')) then
            //Inserindo dados na tabela numero
            FController
                    .FactoryEntidade
                     .DAONumero
                       .This
                          .IdEndereco         (FIdEndereco)
                          .NumeroEndereco     (LNumeroObject.GetValue<String>('numeroendereco'))
                          .ComplementoEndereco(LNumeroObject.GetValue<String>('complementoendereco'))
                        .&End
                      .Post;
          //Inserindo dados na tabela enderecoempresa caso n�o existir
          if BuscarEnderecoEmpresa(FIdEndereco, FIdEmpresa) then
            FController
                    .FactoryEntidade
                      .DAOEnderecoEmpresa
                        .This
                          .IdEndereco(FIdEndereco)
                          .IdEmpresa (FIdEmpresa)
                        .&End
                     .Post;
        end;
      except
        on E: Exception do
        begin
          Res.Status(500).Send('Ocorreu um erro interno no servidor.');
          Exit;
        end;
      end;

      //Obt�m os dados JSON do corpo da requisi��o da tabela('emailempresa')
      LEmailArray := LObjectEmpresa.GetValue('emailempresa') as TJSONArray;
      try
        //Loop emails
        for I := 0 to LEmailArray.Count - 1 do
        begin
          //Extraindo os dados do(s) emai(s)  e salvando no banco de dados
          LEmailObject :=  LEmailArray.Items[I] as TJSONObject;

          //verifico se consta o email que esta vindo no json. Na tabela emailempresa, se n�o existir insiro.
          if BuscarEmailEmpresa(FIdEmpresa, LEmailObject.GetValue<String>('email')) Then
            FController
                   .FactoryEntidade
                     .DAOEmailEmpresa
                       .This
                         .IdEmpresa(FIdEmpresa)
                         .Email    (LEmailObject.GetValue<String>('email'))
                         .TipoEmail(LEmailObject.GetValue<String>('tipoemail'))
                         .Ativo    (1)
                       .&End
                     .Post;
        end;
      except
        on E: Exception do
        begin
          Res.Status(500).Send('Ocorreu um erro interno no servidor.'+ E.Message);
          Exit;
        end;
      end;

      //Obt�m os dados JSON do corpo da requisi��o da tabela('telefoneempresa')
      LTelefoneArray := LObjectEmpresa.GetValue('telefoneempresa') as TJSONArray;

      try
        //Loop telefone(s)
        for I := 0 to LTelefoneArray.Count - 1 do
        begin
          //Extraindo os dados do(s) telefone(s) e salvando no banco de dados
          LTelefoneObject := LTelefoneArray.Items[I] as TJSONObject;
          //verifico se consta o telefone que esta vindo no json. Na tabela telefoneempresa, se n�o existir insiro.
          if BuscarTelefoneEmpresa(FIdEmpresa, LEmailObject.GetValue<String>('ddd'),
                                               LTelefoneObject.GetValue<String>('numerotelefone')) Then
            FController
                   .FactoryEntidade
                     .DAOTelefoneEmpresa
                       .This
                         .IdEmpresa     (FIdEmpresa)
                         .Operadora     (LTelefoneObject.GetValue<String>('operadora'))
                         .DDD           (LTelefoneObject.GetValue<String>('ddd'))
                         .NumeroTelefone(LTelefoneObject.GetValue<String>('numerotelefone'))
                         .TipoTelefone  (LTelefoneObject.GetValue<String>('tipotelefone'))
                         .Ativo         (1)
                       .&End
                     .Post;
        end;
      except
        on E: Exception do
        begin
          Res.Status(500).Send('Ocorreu um erro interno no servidor.'+E.Message);
          Exit;
        end;
      end;

    except
      on E : Exception do
      begin
        Res.Status(500).Send('Ocorreu um  erro interno no servidor.'+ E.Message);
        FController.FactoryEntidade.DAOEmpresa.This.Id(FIdEmpresa).&End.Delete;//exclu�ndo empresa lan�ada
        FController.FactoryEntidade.DAOEndereco.This.Id(FIdEndereco).&End.Delete;//exclu�ndo o endere�o lancado
        //caso ocorrer algum erro neste final excluir todo os inserts
        Exit;
      end;
    end;
  finally
    Res.Status(204).Send('Registro inclu�do com sucesso!');
  end;
end;

procedure TViewControllerEmpresa.Put(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  I : Integer;
  LObjectEmpresa  : TJSONObject;//JSONObject-empresa
  LArrayEndereco  : TJSONArray; //JSONArray -endereco
  LObjectEndereco : TJSONObject;//JSONObject-endereco
  LArrayNumero   : TJSONArray;//JSONArray-numero
  LObjectNumero   : TJSONObject;//JSONObject-numero
  LArrayEmail     : TJSONArray; //JSONArray -email
  LObjectEmail    : TJSONObject;//JSONObject-email
  LArrayTelefone  : TJSONArray; //JSONArray -telefone
  LObjectTelefone : TJSONObject;//JSONObject-telefone
begin
  LObjectEmpresa := Req.Body<TJSONObject>; //Tabela Pai Empresa
  try
    try
      FController
        .FactoryEntidade
          .DAOEmpresa
            .This
              .Id                   (LObjectEmpresa.GetValue<Integer>  ('id'))
              .CNPJ                 (LObjectEmpresa.GetValue<String>   ('cnpj'))
              .InscricaoEstadual    (LObjectEmpresa.GetValue<String>   ('inscricaoestadual'))
              .NomeEmpresarial      (LObjectEmpresa.GetValue<String>   ('nomeempresarial'))
              .NomeFantasia         (LObjectEmpresa.GetValue<String>   ('nomefantasia'))
              .IdNaturezaJuridica   (LObjectEmpresa.GetValue<Integer>  ('idnaturezajuridica'))
              .DataHoraEmissao      (LObjectEmpresa.GetValue<TDateTime>('datahoraemissao'))
              .DataSituacaoCadastral(LObjectEmpresa.GetValue<TDateTime>('datasituacaocadastral'))
              .Ativo                (LObjectEmpresa.GetValue<Integer>  ('ativo'))
            .&End
          .Put
          .DataSet(FDSEmpresa);
    except
      on E: Exception do
        Res.Status(500).Send('Ocorreu um erro interno no servidor.'+ E.Message);
    end;

    //Obt�m os dados JSON do corpo da requisi��o da tabela('endereco')
    LArrayEndereco := LObjectEmpresa.Get('endereco').JsonValue as TJSONArray;
    try
      // Loop do(s) endere�o(s)
      for I := 0 to LArrayEndereco.Count - 1 do
      begin
        LObjectEndereco := LArrayEndereco.Items[I] as TJSONObject;
        FController
          .FactoryEntidade
            .DAOEndereco
              .This
                .Id            (LObjectEndereco.GetValue<Integer>('id'))
                .Cep           (LObjectEndereco.GetValue<String>('cep'))
                .IBGE          (LObjectEndereco.GetValue<Integer>('ibge'))
                .UF            (LObjectEndereco.GetValue<String>('uf'))
                .TipoLogradouro(LObjectEndereco.GetValue<String>('tipoLogradouro'))
                .Logradouro    (LObjectEndereco.GetValue<String>('Logradouro'))
                .Bairro        (LObjectEndereco.GetValue<String>('bairro'))
                .GIA           (LObjectEndereco.GetValue<Integer>('gia'))
                .DDD           (LObjectEndereco.GetValue<String>('ddd'))
              .&End
            .Put
            .DataSet(FDSEndereco);
        //Inserindo dados na tabela numero
        LObjectNumero := TJSONObject(LObjectEndereco.GetValue('numero'));
        FController
              .FactoryEntidade
                .DAONumero
                  .This
                    .Id                 (LObjectNumero  .GetValue<Integer>('id'))
                    .IdEndereco         (LObjectEndereco.GetValue<Integer>('id'))
                    .NumeroEndereco     (LObjectNumero  .GetValue<String>('numeroendereco'))
                    .ComplementoEndereco(LObjectNumero  .GetValue<String>('complementoendereco'))
                  .&End
                .Put;
        //Inserindo dados na tabela enderecoempresa
        FController
               .FactoryEntidade
                 .DAOEnderecoEmpresa
                   .This
                     .IdEndereco(LObjectEndereco.GetValue<Integer>('id'))
                     .IdEmpresa (LObjectEmpresa .GetValue('id').Value.ToInteger)
                   .&End
                 .Put;
      end;
    except
      on E: Exception do
        Res.Status(500).Send('Ocorreu um erro interno no servidor.'+ E.Message);
    end;

    //Obt�m os dados JSON do corpo da requisi��o da tabela('emailempresa')
    LArrayEmail := LObjectEmpresa.Get('emailempresa').JsonValue as TJSONArray;
    try
      //Loop emails
      for I := 0 to LArrayEmail.Count - 1 do
      begin
        //Extraindo os dados do(s) emai(s)  e salvando no banco de dados
        LObjectEmail :=  LArrayEmail.Items[I] as TJSONObject;
        FController
               .FactoryEntidade
                 .DAOEmailEmpresa
                   .This
                     .Id       (LObjectEmail  .GetValue<Integer>('id'))
                     .IdEmpresa(LObjectEmpresa.GetValue<Integer>('id'))
                     .Email    (LObjectEmail  .GetValue<String> ('email'))
                     .TipoEmail(LObjectEmail  .GetValue<String> ('tipoemail'))
                     .Ativo    (LObjectEmail  .GetValue<Integer>('ativo'))
                   .&End
                 .Put;
      end;
    except
      on E: Exception do
        Res.Status(500).Send('Ocorreu um erro interno no servidor.'+ E.Message);
    end;

    //Obt�m os dados JSON do corpo da requisi��o da tabela('telefoneempresa')
    LArrayTelefone := LObjectEmpresa.Get('telefoneempresa').JsonValue as TJSONArray;
    try
      //Loop telefone(s)
      for I := 0 to LArrayTelefone.Count - 1 do
      begin
        //Extraindo os dados do(s) telefone(s) e salvando no banco de dados
        LObjectTelefone := LArrayTelefone.Items[I] as TJSONObject;
        FController
               .FactoryEntidade
                 .DAOTelefoneEmpresa
                   .This
                     .Id            (LObjectTelefone.GetValue<Integer>('id'))
                     .IdEmpresa     (LObjectEmpresa .GetValue<Integer>('id'))
                     .Operadora     (LObjectTelefone.GetValue<String> ('operadora'))
                     .DDD           (LObjectTelefone.GetValue<String> ('ddd'))
                     .NumeroTelefone(LObjectTelefone.GetValue<String> ('numerotelefone'))
                     .TipoTelefone  (LObjectTelefone.GetValue<String> ('tipotelefone'))
                     .Ativo         (LObjectTelefone.GetValue<Integer>('ativo'))
                   .&End
                 .Put;
      end;
    except
      on E: Exception do
        Res.Status(500).Send('Ocorreu um erro interno no servidor.'+ E.Message);
    end;
  finally
    Res.Status(204).Send('Registro alterado com sucesso!');
  end;
end;

procedure TViewControllerEmpresa.Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    FController
      .FactoryEntidade
        .DAOEmpresa
          .This
            .Id(Req.Params['id'].ToInt64)
          .&End
          .Delete
          .DataSet(FDSEmpresa);
    except
      on E: Exception do
      raise Res.Status(500).Send('Ocorreu um erro interno no servidor.'+ E.Message);
  End;
    Res.Status(204).Send('Registro exclu�do com sucesso!');
end;

procedure TViewControllerEmpresa.Registry;
begin
  THorse
      .Group
        .Prefix  ('bmw')
          .Get   ('/empresa'     , GetAll)
          .Get   ('/empresa/:id' , GetbyId)
          .Post  ('empresa'      , Post)
          .Put   ('empresa/:id'  , Put)
          .Delete('empresa/:id'  , Delete);
end;

end.
