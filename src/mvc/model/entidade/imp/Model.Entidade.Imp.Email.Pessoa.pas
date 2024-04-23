{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          Início do projeto 18/03/2024 13:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2004/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Imp.Email.Pessoa;

interface

uses
  Model.Entidade.Email.Pessoa.Interfaces;

type
    TEntidadeEmailPessoa<T : iInterface> = class(TInterfacedObject, iEntidadeEmailPessoa<T>)
      private
        [Weak]
        FParent    : T;
        FId        : Integer;
        FIdEmpresa : Integer;
        FIdPessoa  : Integer;
        FEmail     : String;
        FTipoEMail : String;
        FAtivo     : Integer;
      public
        constructor Create(Parent : T);
        destructor Destroy; override;
        class function New(Parent : T) : iEntidadeEmailPessoa<T>;

        function Id       (Value : Integer) : iEntidadeEmailPessoa<T>; overload;
        function Id                         : Integer;                 overload;
        function IdEmpresa(Value : Integer) : iEntidadeEmailPessoa<T>; overload;
        function IdEmpresa                  : Integer;                 overload;
        function IdPessoa (Value : Integer) : iEntidadeEmailPessoa<T>; overload;
        function IdPessoa                   : Integer;                 overload;
        function Email    (Value : String)  : iEntidadeEmailPessoa<T>; overload;
        function Email                      : String;                  overload;
        function TipoEmail(Value : String)  : iEntidadeEmailPessoa<T>; overload;
        function TipoEmail                  : String;                  overload;
        function Ativo    (Value : Integer) : iEntidadeEmailPessoa<T>; overload;
        function Ativo                      : Integer;                 overload;

        function &End : T;
    end;

implementation

constructor TEntidadeEmailPessoa<T>.Create(Parent: T);
begin
  FParent := Parent;
end;

destructor TEntidadeEmailPessoa<T>.Destroy;
begin
  inherited;
end;

class function TEntidadeEmailPessoa<T>.New(Parent: T): iEntidadeEmailPessoa<T>;
begin
  Result := Self.Create(Parent);
end;

function TEntidadeEmailPessoa<T>.Id(Value: Integer): iEntidadeEmailPessoa<T>;
begin
  Result := Self;
  FId    := Value;
end;

function TEntidadeEmailPessoa<T>.Id: Integer;
begin
  Result := FId;
end;

function TEntidadeEmailPessoa<T>.IdEmpresa(Value: Integer): iEntidadeEmailPessoa<T>;
begin
  Result := Self;
  FIdEmpresa := Value;
end;

function TEntidadeEmailPessoa<T>.IdEmpresa: Integer;
begin
  Result := FIdEmpresa;
end;

function TEntidadeEmailPessoa<T>.IdPessoa(Value: Integer): iEntidadeEmailPessoa<T>;
begin
  Result    := Self;
  FIdPessoa := Value;
end;

function TEntidadeEmailPessoa<T>.IdPessoa: Integer;
begin
  Result := FIdPessoa;
end;


function TEntidadeEmailPessoa<T>.Email(Value: String): iEntidadeEmailPessoa<T>;
begin
  Result := Self;
  FEmail := Value;
end;

function TEntidadeEmailPessoa<T>.Email: String;
begin
  Result := FEmail;
end;

function TEntidadeEmailPessoa<T>.TipoEmail(Value: String): iEntidadeEmailPessoa<T>;
begin
  Result := Self;
  FTipoEmail := Value;
end;

function TEntidadeEmailPessoa<T>.TipoEMail: String;
begin
  Result := FTipoEmail;
end;

function TEntidadeEmailPessoa<T>.Ativo(Value: Integer): iEntidadeEmailPessoa<T>;
begin
  Result := Self;
  FAtivo := Value;
end;

function TEntidadeEmailPessoa<T>.Ativo: Integer;
begin
  Result := FAtivo;
end;

function TEntidadeEmailPessoa<T>.&End: T;
begin
  Result := FParent;
end;

end.
