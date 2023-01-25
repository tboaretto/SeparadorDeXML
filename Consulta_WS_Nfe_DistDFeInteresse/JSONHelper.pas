unit JSONHelper;

interface

uses DBXJSON, Variants, DB, DBClient, System.JSON;

type
  TJSONObjectHelper = class helper for TJSONObject
  private
    function PrepareString(Input: string): string;
  public
    function GetValue(Key: string): Variant; overload;
    function GetString(Key: string): string;
    function GetFloat(Key: string): Real;
    function GetInteger(Key: string): Integer;
    function GetBoolean(Key: string): Boolean;
    function GetObj(Key: string): TJSONObject;
    function GetArray(Key: string): TJSONArray;
    function IsNull(Key: string): Boolean;

    function FindPair(Key: string; var Pair: TJSONPair): Boolean;
    function FindObject(Key: string; Obj: TJSONObject): Boolean;
    function AddObject(Key: string): TJSONObject;

    procedure AddPair(const Str: UnicodeString; const Val: string); overload;
    procedure AddPair(const Str: UnicodeString; const Val: Boolean); overload;
    procedure AddPair(const Str: UnicodeString; const Val: Variant); overload;

    class function CdsToJSON(ADataSet: TClientDataSet): TJSONObject;
  end;

  TJSONArrayHelper = class helper for TJSONArray
  private
    function PrepareString(Input: string): string;
  public
    function GetValue(Key: Integer): Variant;
    function GetObj(Key: Integer): TJSONObject;
    function GetString(Key: Integer): string;
    function GetFloat(Key: Integer): Real;
    function GetInteger(Key: Integer): Integer;
    function GetBoolean(Key: Integer): Boolean;
    function GetArray(Key: Integer): TJSONArray;
    function GetList(Delimiter: Char = ','): string;
    procedure AddElement(Value: Variant); overload;
  end;

  TSerializableClientDataSet = class helper for TClientDataSet
  public
    function ToJSON: TJSONObject;
    procedure FromJSON(Source: TJSONObject);
  end;

implementation

uses SysUtils, RegularExpressions, Classes;

{ TJSONHelper }

function TJSONObjectHelper.GetArray(Key: string): TJSONArray;
var
  Pair: TJSONPair;
begin
  Pair := Get(Key);
  if Assigned(Pair) then
  begin
    if Pair.JsonValue is TJSONArray then
      Result := (Pair.JsonValue as TJSONArray)
    else
      Result := nil;
  end
  else
    raise Exception.CreateFmt('Invalid index name: %s', [Key]);
end;

function TJSONObjectHelper.GetBoolean(Key: string): Boolean;
var
  Pair: TJSONPair;
begin
  if FindPair(Key, Pair) then
  begin
    if (Pair.JsonValue is TJSONFalse) then
      Result := False
    else if (Pair.JsonValue is TJSONTrue) then
      Result := True
    else
      raise Exception.Create('Invalid type.');
  end
  else
    raise Exception.Create('Invalid key.');
end;

function TJSONObjectHelper.GetFloat(Key: string): Real;
var
  Pair: TJSONPair;
begin
  if FindPair(Key, Pair) then
  begin
    if Pair.JsonValue is TJSONNumber then
      Result := (Pair.JsonValue as TJSONNumber).AsDouble
    else
      raise Exception.Create('Invalid type.');
  end
  else
    raise Exception.Create('Invalid key.');
end;

function TJSONObjectHelper.GetInteger(Key: string): Integer;
var
  Pair: TJSONPair;
begin
  if FindPair(Key, Pair) then
  begin
    if Pair.JsonValue is TJSONNumber then
      Result := (Pair.JsonValue as TJSONNumber).AsInt
    else
      raise Exception.Create('Invalid type.');
  end
  else
    raise Exception.Create('Invalid key.');
end;

function TJSONObjectHelper.GetObj(Key: string): TJSONObject;
var
  Pair: TJSONPair;
begin
  Result := nil;
  Pair := Get(Key);
  if Assigned(Pair) then
  begin
    if Pair.JsonValue is TJSONObject then
      Result := (Pair.JsonValue as TJSONObject);
  end
  else
    raise Exception.CreateFmt('Invalid index name: %s', [Key]);
end;

function TJSONObjectHelper.GetString(Key: string): string;
var
  Pair: TJSONPair;
begin
  if FindPair(Key, Pair) then
  begin
    if Pair.JsonValue is TJSONString then
    begin
      Result := Pair.JsonValue.Value;
      Result := StringReplace(Result, #10, #13#10, [rfReplaceAll]);
    end
    else
      raise Exception.Create('Invalid type.');
  end
  else
    raise Exception.Create('Invalid key.');
end;

function TJSONObjectHelper.GetValue(Key: string): Variant;
var
  Pair: TJSONPair;
begin
  if FindPair(Key, Pair) then
  begin
    if Pair.JsonValue is TJSONTrue then
      Result := True
    else if Pair.JsonValue is TJSONFalse then
      Result := False
    else if Pair.JsonValue is TJSONNumber then
      Result := (Pair.JsonValue as TJSONNumber).AsDouble
    else if Pair.JsonValue is TJSONNull then
      Result := Variants.Null
    else if Pair.JsonValue is TJSONString then
    begin
      Result := Pair.JsonValue.Value;
      Result := StringReplace(Result, #10, #13#10, [rfReplaceAll]);
    end
    else
      raise Exception.Create('Invalid type.');
  end
  else
    Result := Unassigned;
end;

function TJSONObjectHelper.IsNull(Key: string): Boolean;
begin
  Result := Self.GetValue(Key) = Variants.Null;
end;

function TJSONObjectHelper.PrepareString(Input: string): string;
begin
  Input := TRegEx.Replace(Input, '("|\\)', '\\\1', [roIgnoreCase]);
  Input := TRegEx.Replace(Input, '\r', '');
  Result := TRegEx.Replace(Input, '\n', '\\n');
end;

function TJSONObjectHelper.AddObject(Key: string): TJSONObject;
begin
  Result := TJSONObject.Create;
  AddPair(Key, Result);
end;

procedure TJSONObjectHelper.AddPair(const Str: UnicodeString; const Val: Variant);
var
  vType: string;
  Value: TJSONValue;
  Pair: TJSONPair;
begin
  Value := nil;
  vType := VarTypeAsText(VarType(Val));
  if VarIsNull(Val) then
    Value := TJSONNull.Create
  else if VarIsNumeric(Val) or VarIsFloat(Val) or VarIsOrdinal(Val) or (vType = 'FMTBcdVariantType') then
    Value := TJSONNumber.Create(Val)
  else if VarIsType(Val, varDate) then
    Value := TJSONNumber.Create(Val)
  else if VarIsStr(Val) then
    Value := TJSONString.Create(PrepareString(Val));

  if FindPair(Str, Pair) then
  begin
    Pair.JsonValue.Free;
    Pair.JsonValue := Value
  end
  else
    Self.AddPair(Str, Value);
end;

class function TJSONObjectHelper.CdsToJSON(ADataSet: TClientDataSet): TJSONObject;
var
  Field: TField;
begin
  Result := TJSONObject.Create;
  for Field in ADataSet.Fields do
    if not(Field.IsNull) and (Field.DataType in [ftDate, ftDateTime, ftTime, ftTimeStamp]) then
      Result.AddPair(UpperCase(Field.FieldName), Field.AsString)
    else
      Result.AddPair(UpperCase(Field.FieldName), Field.Value);
end;

procedure TJSONObjectHelper.AddPair(const Str: UnicodeString; const Val: string);
var
  Pair: TJSONPair;
  Tmp: UnicodeString;
begin
  Tmp := PrepareString(Val);
  if FindPair(Str, Pair) then
  begin
    Pair.JsonValue.Free;
    Pair.JsonValue := TJSONString.Create(Tmp);
  end
  else
    Self.AddPair(Str, TJSONString.Create(Tmp));
end;

function TJSONObjectHelper.FindObject(Key: string; Obj: TJSONObject): Boolean;
begin
  Obj := GetObj(Key);
  Result := Assigned(Obj);
end;

function TJSONObjectHelper.FindPair(Key: string; var Pair: TJSONPair): Boolean;
begin
  Pair := Get(Key);
  Result := Assigned(Pair);
end;

procedure TJSONObjectHelper.AddPair(const Str: UnicodeString; const Val: Boolean);
var
  Pair: TJSONPair;
  Value: TJSONValue;
begin
  Value := nil;
  if Val then
    Value := TJSONTrue.Create
  else if not Val then
    Value := TJSONFalse.Create;

  if FindPair(Str, Pair) then
  begin
    Pair.JsonValue.Free;
    Pair.JsonValue := Value
  end
  else
    Self.AddPair(Str, Value);
end;

{ TJSONArrayHelper }

function TJSONArrayHelper.GetArray(Key: Integer): TJSONArray;
var
  Value: TJSONValue;
begin
  Result := nil;
  Value := Items[Key];
  if Assigned(Value) then
  begin
    if Value is TJSONArray then
      Result := (Value as TJSONArray);
  end
  else
    raise Exception.Create('Invalid index name.');
end;

function TJSONArrayHelper.GetBoolean(Key: Integer): Boolean;
var
  Value: TJSONValue;
begin
  Value := Items[Key];
  if Assigned(Value) then
  begin
    if Value is TJSONTrue then
      Result := True
    else if Value is TJSONFalse then
      Result := False
    else
      raise Exception.Create('Invalid type');
  end
  else
    raise Exception.Create('Invalid key');
end;

function TJSONArrayHelper.GetFloat(Key: Integer): Real;
var
  Value: TJSONValue;
begin
  Value := Items[Key];
  if Assigned(Value) then
  begin
    if Value is TJSONNumber then
      Result := (Value as TJSONNumber).AsDouble
    else
      raise Exception.Create('Invalid type');
  end
  else
    raise Exception.Create('Invalid key');
end;

function TJSONArrayHelper.GetInteger(Key: Integer): Integer;
var
  Value: TJSONValue;
begin
  Value := Items[Key];
  if Assigned(Value) then
  begin
    if Value is TJSONNumber then
      Result := (Value as TJSONNumber).AsInt
    else
      raise Exception.Create('Invalid type');
  end
  else
    raise Exception.Create('Invalid key');
end;

function TJSONArrayHelper.GetList(Delimiter: Char = ','): string;
var
  ListValue: TStringList;
  Index: Integer;
begin
  ListValue := TStringList.Create;
  try
    ListValue.Delimiter := Delimiter;

    for Index := 0 to Count - 1 do
      ListValue.Add(GetString(Index));

    Result := ListValue.DelimitedText;
  finally
    ListValue.Free;
  end;
end;

procedure TJSONArrayHelper.AddElement(Value: Variant);
var
  vType: string;
  Element: TJSONValue;
begin
  Element := nil;
  vType := VarTypeAsText(VarType(Value));
  if VarIsNull(Value) then
    Element := TJSONNull.Create
  else if VarIsNumeric(Value) or VarIsFloat(Value) or VarIsOrdinal(Value) or (vType = 'FMTBcdVariantType') then
    Element := TJSONNumber.Create(Value)
  else if VarIsType(Value, varDate) then
    Element := TJSONNumber.Create(Value)
  else if VarIsStr(Value) then
    Element := TJSONString.Create(PrepareString(Value))
  else if VarIsArray(Value) then
    Element := TJSONString.Create(Value);

  AddElement(Element);
end;

function TJSONArrayHelper.GetObj(Key: Integer): TJSONObject;
var
  Value: TJSONValue;
begin
  Result := nil;
  Value := Items[Key];
  if Assigned(Value) then
  begin
    if Value is TJSONObject then
      Result := (Value as TJSONObject);
  end
  else
    raise Exception.Create('Invalid index name.');
end;

function TJSONArrayHelper.PrepareString(Input: string): string;
begin
  Input := TRegEx.Replace(Input, '("|\\)', '\\\1', [roIgnoreCase]);
  Input := TRegEx.Replace(Input, '\r', '');
  Result := TRegEx.Replace(Input, '\n', '\\n');
end;

function TJSONArrayHelper.GetString(Key: Integer): string;
var
  Value: TJSONValue;
begin
  Value := Items[Key];
  if Assigned(Value) then
  begin
    if Value is TJSONString then
      Result := Value.Value
    else
      raise Exception.Create('Invalid type');
  end
  else
    raise Exception.Create('Invalid key');
end;

function TJSONArrayHelper.GetValue(Key: Integer): Variant;
var
  Value: TJSONValue;
begin
  Value := Items[Key];
  if Assigned(Value) then
  begin
    if Value is TJSONTrue then
      Result := True
    else if Value is TJSONFalse then
      Result := False
    else if Value is TJSONNumber then
      Result := (Value as TJSONNumber).AsDouble
    else if Value is TJSONNull then
      Result := Null
    else if Value is TJSONString then
      Result := Value.Value
    else
      raise Exception.Create('Invalid type');
  end
  else
    Result := Unassigned;
end;

{ TSerializableClientDataSet }

procedure TSerializableClientDataSet.FromJSON(Source: TJSONObject);

  procedure CreateFieldDefs;
  var
    JSONFields: TJSONArray;
    JSONField: TJSONObject;
    i: Integer;
  begin
    // EmptyDataSet;
    // ClearFields;
    JSONFields := Source.GetArray('columns');
    for i := 0 to JSONFields.Count - 1 do
    begin
      JSONField := TJSONObject(JSONFields.Items[i] as TJSONObject);
      FieldDefs.Add(JSONField.GetValue('name'), TFieldType(JSONField.GetValue('type')), JSONField.GetValue('size'));
    end;
    CreateDataSet;
  end;

  procedure LoadData;
  var
    JSONData, RowData: TJSONArray;
    i, j: Integer;
  begin
    JSONData := Source.GetArray('data');
    for i := 0 to JSONData.Count - 1 do
    begin
      RowData := JSONData.GetArray(i);
      Append;
      for j := 0 to RowData.Count - 1 do
        Fields[j].Value := RowData.GetValue(j);
      Post;
    end;
  end;

begin
  CreateFieldDefs;
  LoadData;
end;

function TSerializableClientDataSet.ToJSON: TJSONObject;
var
  JSONDataSet: TJSONObject;

  procedure AddColumns;
  var
    JSONColumns: TJSONArray;
    Field: TField;
    Column: TJSONObject;
  begin
    JSONColumns := TJSONArray.Create;
    for Field in Fields do
    begin
      Column := TJSONObject.Create;
      Column.AddPair('name', Field.FieldName);
      Column.AddPair('type', Field.DataType);
      Column.AddPair('size', Field.Size);
      JSONColumns.Add(Column);
    end;
    JSONDataSet.AddPair('columns', JSONColumns);
  end;

  procedure AddData;
  var
    JSONData, JSONRow: TJSONArray;
    Field: TField;
  begin
    JSONData := TJSONArray.Create;

    First;
    while not Eof do
      try
        JSONRow := TJSONArray.Create;
        for Field in Fields do
        begin
          if Field.DataType = ftBlob then
            JSONRow.AddElement(Field.AsString)
          else
            JSONRow.AddElement(Field.Value);
        end;
        JSONData.AddElement(JSONRow);
      finally
        Next;
      end;

    JSONDataSet.AddPair('data', JSONData);
  end;

begin
  JSONDataSet := TJSONObject.Create;

  JSONDataSet.AddPair('recordCount', RecordCount);
  AddColumns;
  AddData;

  Result := JSONDataSet;
end;

end.

