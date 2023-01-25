unit SQLWriter;

interface

uses
  Classes, Generics.Collections, SqlExpr, Variants;

type
  TStringListHelper = class helper for TStringList

  public
    function Implode: string;
  end;

  TSQLParam = TDictionary<string, Variant>;

  TSQLWriter = class

  type
    TCase = (cUpper, cLower);

  const
    tipoVarNumericFB = 273;

  private
    FReservedWordsCase: TCase;
    FFieldsCase: TCase;
    FBindPrefix: string;
    FFieldWrapper: string;
    FTableWrapper: string;
    FTreatEmptyStringAsNull: Boolean;
    FDoubleSlashes: Boolean;

    function WrapField(Field: string): string;
    function WrapFields(Params: TArray<string>): TStringList;
    function WrapTable(TableName: string): string;
    function PrepareSequentialFields(Params: TArray<string>; Glue: Char = ','): string;
    function PrepareSequentialValues(Params: TSQLParam; UseBind: Boolean; Glue: Char = ','): string;
    function PrepareKeyValueFields(Params: TSQLParam; UseBind: Boolean; Glue: string = ' AND '; NullFilter: Boolean = False): string;
    function QuoteValue(Value: Variant): string;
    function QuoteValues(Values: TArray<Variant>): TStringList;

    procedure RemoveInvalid(Params: TSQLParam);

  public
    constructor Create; overload;
    constructor Create(SQL: TSQLConnection); overload;

    function insertSQL(TableName: string; Params: TSQLParam; UseBind: Boolean = True): string;
    function deleteSQL(TableName: string; Filters: TSQLParam; UseBind: Boolean = True): string;
    function updateSQL(TableName: string; Fields, Filters: TSQLParam; UseBind: Boolean = True): string;
    function selectSQL(TableName: string; Fields, Filters: TSQLParam; UseBind: Boolean): string;
    function replaceSQL(TableName: string; Params: TSQLParam; UseBind: Boolean = True): string;

    property FieldWrapper: string read FFieldWrapper write FFieldWrapper;
    property TableWrapper: string read FTableWrapper write FTableWrapper;
    property ReservedWordsCase: TCase read FReservedWordsCase write FReservedWordsCase;
    property FieldsCase: TCase read FFieldsCase write FFieldsCase;
    property BindPrefix: string read FBindPrefix write FBindPrefix;
    property TreatEmptyStringAsNull: Boolean read FTreatEmptyStringAsNull write FTreatEmptyStringAsNull;
  end;

implementation

uses
  SysUtils, StrUtils, RegularExpressions;

{ TSQLWriter }

constructor TSQLWriter.Create;
begin
  FReservedWordsCase := cUpper;
  FFieldsCase := cUpper;
  FBindPrefix := ':';
  FFieldWrapper := '';
  FTableWrapper := '';
  FTreatEmptyStringAsNull := True;
  FDoubleSlashes := False;
end;

constructor TSQLWriter.Create(SQL: TSQLConnection);
begin
  FBindPrefix := ':';
  FTreatEmptyStringAsNull := True;

  if SQL.DriverName = 'MySQL' then
  begin
    FReservedWordsCase := cLower;
    FFieldsCase := cLower;
    FFieldWrapper := '`';
    FTableWrapper := '`';
    FDoubleSlashes := True;
  end
  else
  begin
    FReservedWordsCase := cUpper;
    FFieldsCase := cUpper;
    FFieldWrapper := '';
    FTableWrapper := '';
    FDoubleSlashes := False;
  end;
end;

function TSQLWriter.deleteSQL(TableName: string; Filters: TSQLParam; UseBind: Boolean): string;
const
  SQLUpper = 'DELETE FROM %s WHERE %s';
  SQLLower = 'delete from %s where %s';
var
  DeleteFilters: string;
begin
  TableName := WrapTable(TableName);
  DeleteFilters := PrepareKeyValueFields(Filters, UseBind, ' AND ');
  Result := Format(IfThen(FReservedWordsCase = cUpper, SQLUpper, SQLLower),
    [TableName, DeleteFilters]);

end;

function TSQLWriter.insertSQL(TableName: string; Params: TSQLParam; UseBind: Boolean = True): string;
const
  SQLUpper = 'INSERT INTO %s (%s) VALUES (%s)';
  SQLLower = 'insert into %s (%s) values (%s)';
var
  InsertFields, InsertValues: string;
begin
  RemoveInvalid(Params);

  TableName := WrapTable(TableName);

  InsertFields := PrepareSequentialFields(Params.Keys.ToArray);
  InsertValues := PrepareSequentialValues(Params, UseBind, ',');
  Result := Format(IfThen(FReservedWordsCase = cUpper, SQLUpper, SQLLower),
    [TableName, InsertFields, InsertValues]);
end;

function TSQLWriter.replaceSQL(TableName: string; Params: TSQLParam; UseBind: Boolean = True): string;
const
  SQLUpper = 'REPLACE INTO %s (%s) VALUES (%s)';
  SQLLower = 'replace into %s (%s) values (%s)';

var
  ReplaceFields, ReplaceValues: string;
begin
  RemoveInvalid(Params);

  TableName := WrapTable(TableName);

  ReplaceFields := PrepareSequentialFields(Params.Keys.ToArray);
  ReplaceValues := PrepareSequentialValues(Params, UseBind, ',');
  Result := Format(IfThen(FReservedWordsCase = cUpper, SQLUpper, SQLLower),
    [TableName, ReplaceFields, ReplaceValues]);
end;

function TSQLWriter.PrepareKeyValueFields(Params: TSQLParam; UseBind: Boolean; Glue: string; NullFilter: Boolean): string;
var
  KeyValueList: TStringList;
  Item: TPair<string, Variant>;
  FieldName, FieldValue: string;
begin
  Glue := IfThen(FReservedWordsCase = cUpper, UpperCase(Glue), LowerCase(Glue));
  KeyValueList := TStringList.Create;
  try
    for Item in Params do
    begin
      FieldName := WrapField(Item.Key);
      FieldValue := IfThen(UseBind, FBindPrefix + Item.Key, QuoteValue(Item.Value));
      if NullFilter then
      begin
        if UpperCase(FieldValue) = 'NULL' then
          KeyValueList.Add(FieldName + IfThen(FReservedWordsCase = cUpper, ' IS ', ' is ') + FieldValue)
        else
          KeyValueList.Add(FieldName + ' = ' + FieldValue);
      end
      else
        KeyValueList.Add(FieldName + ' = ' + FieldValue);
    end;
    KeyValueList.Delimiter := '§';
    Result := StringReplace(KeyValueList.Implode, '§', Glue, [rfReplaceAll]);
  finally
    KeyValueList.Free;
  end;
end;

function TSQLWriter.PrepareSequentialFields(Params: TArray<string>; Glue: Char = ','): string;
var
  WrappedFields: TStringList;
begin
  WrappedFields := WrapFields(Params);
  try
    WrappedFields.Delimiter := Glue;
    Result := WrappedFields.Implode;
  finally
    WrappedFields.Free;
  end;
end;

function TSQLWriter.PrepareSequentialValues(Params: TSQLParam; UseBind: Boolean; Glue: Char): string;
var
  BindFields: TStringList;
  FieldName: string;
begin
  if UseBind then
  begin
    BindFields := TStringList.Create;
    try
      for FieldName in Params.Keys.ToArray do
        BindFields.Add(FBindPrefix + FieldName);
      BindFields.Delimiter := Glue;
      Result := BindFields.Implode;
    finally
      BindFields.Free;
    end;
  end
  else
  begin
    BindFields := QuoteValues(Params.Values.ToArray);
    try
      BindFields.Delimiter := Glue;
      Result := BindFields.Implode;
    finally
      BindFields.Free;
    end;
  end;
end;

function TSQLWriter.QuoteValue(Value: Variant): string;
var
  Match: TMatch;
  VarData: TVarData absolute Value;
begin
    if (VarIsNumeric(Value)) or (vartype(Value) = tipoVarNumericFB) then
    Result := StringReplace(FloatToStr(Value), ',', '.', [rfReplaceAll])
  else if VarIsNull(Value) then
    Result := IfThen(FReservedWordsCase = cUpper, 'NULL', 'null')
  else if (VarData.VType = varDate) or (VarData.VType = 271) then
  begin
    if Value > 0 then
    begin
      if TRegEx.IsMatch(Value, '[0-9]{2}\/[0-9]{2}\/[0-9]{2,4} [0-9]{2}:[0-9]{2}:[0-9]{2}', [roIgnoreCase]) then
      begin
        Match := TRegEx.Match(Value, '([0-9]{2})\/([0-9]{2})\/([0-9]{2,4}) ([0-9]{2}:[0-9]{2}:[0-9]{2})', [roIgnoreCase]);
        Result := QuotedStr(Match.Groups[3].Value + '-' + Match.Groups[2].Value + '-' + Match.Groups[1].Value + ' ' + Match.Groups[4].Value)
      end
      else if TRegEx.IsMatch(Value, '[0-9]{2}\/[0-9]{2}\/[0-9]{2,4}', [roIgnoreCase]) then
      begin
        Match := TRegEx.Match(Value, '([0-9]{2})\/([0-9]{2})\/([0-9]{2,4})', [roIgnoreCase]);
        Result := QuotedStr(Match.Groups[3].Value + '-' + Match.Groups[2].Value + '-' + Match.Groups[1].Value);
      end
      else
        Result := QuotedStr(Value);
    end
    else
      Result := IfThen(FReservedWordsCase = cUpper, 'NULL', 'null');
  end
  else if (VarIsStr(Value)) then
  begin
    if (Value = '') and FTreatEmptyStringAsNull then
      Result := IfThen(FReservedWordsCase = cUpper, 'NULL', 'null')
    else
    begin
      Match := TRegEx.Match(Value, '^([0-9]{2})\/([0-9]{2})\/([0-9]{2,4})(?:( [0-9]{2}:[0-9]{2}:[0-9]{2}))?$', [roIgnoreCase]);
      if Match.Success then
      begin
        if Match.Groups.Count = 5 then
          Result := Match.Groups[3].Value + '-' + Match.Groups[2].Value + '-' + Match.Groups[1].Value + Match.Groups[4].Value
        else
          Result := Match.Groups[3].Value + '-' + Match.Groups[2].Value + '-' + Match.Groups[1].Value;
      end
      else if (FDoubleSlashes) then
        Result := TRegEx.Replace(Value, '\\', '\\\\', [])
      else
        Result := Value;

      Result := QuotedStr(Result);
    end;
  end
  else
    Result := Value;
end;

function TSQLWriter.QuoteValues(Values: TArray<Variant>): TStringList;
var
  Value: Variant;
begin
  Result := TStringList.Create;

  for Value in Values do
    Result.Add(QuoteValue(Value));
end;

procedure TSQLWriter.RemoveInvalid(Params: TSQLParam);
var
  Pair: TPair<string, Variant>;
  str: TStringList;
  s: string;
begin
  str := TStringList.Create;
  try
    for Pair in Params do
      if VarIsEmpty(Pair.Value) then
        str.Add(Pair.Key);

    for s in str do
      Params.Remove(s);
  finally
    str.Free;
  end;
end;

function TSQLWriter.selectSQL(TableName: string; Fields, Filters: TSQLParam; UseBind: Boolean): string;
const
  SQLUpper = 'SELECT %s FROM %s%s';
  SQLLower = 'select %s from %s%s';
var
  SelectFields, SelectFilters: string;
begin
  TableName := WrapTable(TableName);
  if not Assigned(Fields) or (Fields.Count = 0) then
    SelectFields := '*'
  else
    SelectFields := PrepareSequentialFields(Fields.Keys.ToArray, ',');

  if not Assigned(Filters) or (Filters.Count = 0) then
    SelectFilters := ''
  else
  begin
    SelectFilters := IfThen(FReservedWordsCase = cUpper, ' WHERE %s', ' where %s');
    SelectFilters := Format(SelectFilters, [PrepareKeyValueFields(Filters, UseBind, ' AND ', True)]);
  end;

  Result := Format(IfThen(FReservedWordsCase = cUpper, SQLUpper, SQLLower), [SelectFields, TableName, SelectFilters]);
end;

function TSQLWriter.updateSQL(TableName: string; Fields, Filters: TSQLParam; UseBind: Boolean): string;
const
  SQLUpper = 'UPDATE %s SET %s WHERE %s';
  SQLLower = 'update %s set %s where %s';
var
  UpdateFields, UpdateFilters: string;
begin
  RemoveInvalid(Fields);
  RemoveInvalid(Filters);

  TableName := WrapTable(TableName);
  UpdateFields := PrepareKeyValueFields(Fields, UseBind, ',');
  UpdateFilters := PrepareKeyValueFields(Filters, UseBind);
  Result := Format(IfThen(FReservedWordsCase = cUpper, SQLUpper, SQLLower),
    [TableName, UpdateFields, UpdateFilters]);
end;

function TSQLWriter.WrapField(Field: string): string;
begin
  Field := IfThen(FFieldsCase = cUpper, UpperCase(Field), LowerCase(Field));
  Result := FFieldWrapper + Field + FFieldWrapper;
end;

function TSQLWriter.WrapFields(Params: TArray<string>): TStringList;
var
  FieldName: string;
begin
  Result := TStringList.Create;
  for FieldName in Params do
    Result.Add(WrapField(FieldName));
end;

function TSQLWriter.WrapTable(TableName: string): string;
begin
  Result := FTableWrapper + TableName + FTableWrapper;
end;

{ TStringListHelper }

function TStringListHelper.Implode: string;
var
  Linha: string;
begin
  for Linha in Self do
    Result := Result + Delimiter + Linha;
  System.Delete(Result, 1, 1);
end;

end.
