unit Parans;

interface

var
  FIdParans : Variant;

function ParansId(Value : Variant) : Variant; overload;
function ParansId : Variant; overload;

implementation

function ParansId(Value : Variant) : Variant;
begin
  Result := Value;
end;

function ParansId : Variant;
begin
  Result := FIdParans;
end;

end.
