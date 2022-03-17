unit AssociativeArray;

interface

uses
  Generics.Collections, Classes, Variants;

type
  TAssocArray = class(TDictionary<string, Variant>)
  strict private
    function GetItem(const Index: string): Variant;
    procedure SetItem(const Index: string; const Value: Variant);
  public
    procedure Assign(Source: TAssocArray);
    property Item[const Index: string]: Variant read GetItem write SetItem; default;
  end;

implementation

{ TAssocArray<TDataType> }

function TAssocArray.GetItem(const Index: string): Variant;
begin
  if ContainsKey(Index) then
    Result := Items[Index]
  else
    Result := Unassigned;
end;

procedure TAssocArray.SetItem(const Index: string; const Value: Variant);
begin
  Items[Index] := Value;
end;

procedure TAssocArray.Assign(Source: TAssocArray);
var Item: TPair<string, Variant>;
begin
  Clear;
  for Item in Source do
    Self[Item.Key] := Item.Value;
end;

end.
