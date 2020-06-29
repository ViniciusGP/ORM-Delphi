unit UJsonUtil;

interface
uses
  Data.DBXJSON,Data.DBXJSONReflect,Generics.Collections;
type
  TJsonUtil =  Class
    private
      class var JSONMarshal: TJSONMarshal;
      class var JsonUnMarshal: TJSONUnMarshal;
    public
      class function ObjectToJSON<T: class> (AObject: T): TJSONValue;
      class function JSONToObject<T: class>(AJSON:TJSONValue): T;
      class function ListToJSONArray<T: class>(AList: TList<T>):TJSONArray;
      class function JSONArrayToList<T: class>(AJSONArray:TJSONArray):TList<T>;

  End;


implementation

{ TJsonUtil }

class function TJsonUtil.JSONArrayToList<T>(AJSONArray: TJSONArray): TList<T>;
var
  I: Integer;
begin
  Result := TList<T>.Create;
  for I := 0 to AJSONArray.size -1 do
  begin
    Result.Add(Self.JSONToObject<T>(AJSONArray.Get(i)));
  end;

end;

class function TJsonUtil.JSONToObject<T>(AJSON: TJSONValue): T;
begin
  if AJSON is TJSONNul then
  begin
    Exit(nil);
  end;
  if not Assigned(JsonUnMarshal) then
  begin
    JsonUnMarshal := TJSONUnMarshal.Create;
    Result := T(JSONUnMarshal.UnMarshal(AJSON));
  end;


end;

class function TJsonUtil.ListToJSONArray<T>(AList: TList<T>): TJSONArray;
var
  i:integer;
begin
  Result := TJSONArray.Create;
  for i := 0 to AList.Count -1 do
  begin
    Result.AddElement(Self.ObjectToJSON(Alist[i]));
  end;
end;

class function TJsonUtil.ObjectToJSON<T>(AObject: T): TJSONValue;
begin
  if Assigned(AObject) then
  begin
    if not Assigned(JSONMarshal) then
    begin
      JSONMarshal :=  TJSONMarshal.Create;
      Result := JSONMarshal.Marshal(AObject);
    end
    else
    begin
      Exit(TJSONNull.Create);
    end;
  end;
end;

end.
