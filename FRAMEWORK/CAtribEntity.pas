unit CAtribEntity;

interface

type
  TableName = Class(TCustomAttribute)

  private
    FName: String;
    procedure SetName(const Value: String);

  public
  constructor Create(aName:String);
  property Name:String read FName write SetName;

End;

type
  KeyField = Class(TCustomAttribute)

  private
    FName: String;
    procedure SetName(const Value: String);

  public
  constructor Create(aName:String);
  property Name:String read FName write SetName;
End;

type
  FieldName = Class(TCustomAttribute)

  private
    FName: String;
    procedure SetName(const Value: String);

  public
  constructor Create(aName:String);
  property Name:String read FName write SetName;

End;


implementation

{ FieldName }

constructor FieldName.Create(aName: String);
begin
  FName := aName;
end;

procedure FieldName.SetName(const Value: String);
begin
  FName := Value;
end;

{ TableName }

constructor TableName.Create(aName: String);
begin
  FName := aName;
end;

procedure TableName.SetName(const Value: String);
begin
  FName := Value;
end;

{ KeyField }

constructor KeyField.Create(aName: String);
begin
  FName := aName;
end;

procedure KeyField.SetName(const Value: String);
begin
  FName := Value;
end;

end.
