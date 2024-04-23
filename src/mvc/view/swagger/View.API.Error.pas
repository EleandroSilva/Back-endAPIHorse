unit View.API.Error;

interface

type
  TAPIError = class
    private
      FErrorMessage : String;
    public
      property ErrorMessage : string  read FErrorMessage write FErrorMessage;
  end;

implementation

end.
