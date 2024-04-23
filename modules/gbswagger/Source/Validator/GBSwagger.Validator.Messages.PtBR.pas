unit GBSwagger.Validator.Messages.PtBR;

interface

uses
  GBSwagger.Validator.Messages.Interfaces,
  GBSwagger.Validator.Messages.Base;

type
  TGBSwaggerValidatorMessagesPtBR = class(TGBSwaggerValidatorMessagesBase, IGBSwaggerValidatorMessages)
  public
    constructor Create;
    class function New: IGBSwaggerValidatorMessages;
  end;

implementation

{ TGBSwaggerValidatorMessagesPtBR }

constructor TGBSwaggerValidatorMessagesPtBR.Create;
begin
  inherited;
  FEnumValueMessage := 'Os valores aceitos da propriedade %s s�o [%s]';
  FMaximumLengthMessage := 'O tamanho m�ximo da propriedade %s � %d.';
  FMaximumValueMessage := 'O valor m�ximo da propriedade %s � %s.';
  FMinimumLengthMessage := 'O tamanho m�nimo da propriedade %s � %d.';
  FMinimumValueMessage := 'O valor m�nimo da propriedade %s � %s.';
  FPositiveMessage := 'O valor da propriedade %s deve ser positiva.';
  FRequiredMessage := 'A propriedade %s � obrigat�ria.';
end;

class function TGBSwaggerValidatorMessagesPtBR.New: IGBSwaggerValidatorMessages;
begin
  Result := Self.Create;
end;

end.

