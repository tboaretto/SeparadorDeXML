unit clsSLGXMLDocument;

interface

uses Classes, XMLDoc, XMLIntf, XMLDOM, MSXML, msxmldom;

type
  TSLGXMLDocument = class(TXMLDocument)
  private
    FRootNode: IXMLNode;
    function SearchNode(NodeName: string; ParentNodeList: IXMLNodeList): IXMLNode;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    function SetRootNode(RootNodePath: string): Boolean;
    function LocateNode(NodeName: string; out Node: IXMLNode): Boolean;
    procedure LoadFromXML(const XML: DOMString); reintroduce;

    procedure Write(Path, Value: string);
    function FindXMLNode(NodePath: string; RootNode: IXMLNode = nil; CreateIfNotExists: Boolean = False; CreateNew: Boolean = False): IXMLNode; overload;
    function FindXMLNodeValue(NodePath: string; RootNode: IXMLNode = nil): string;
    function FindXMLAttribute(NodePath, AttributeName: string; RootNode: IXMLNode = nil): string;
    function SearchXMLNode(NodeName: string): IXMLNode; overload;
  end;

implementation

uses ActiveX, RegularExpressions, StrUtils, SysUtils, Forms;

{ TSLGXMLDocument }

function TSLGXMLDocument.FindXMLAttribute(NodePath, AttributeName: string; RootNode: IXMLNode): string;
var Node: IXMLNode;
begin
  Result := '';
  Node := FindXMLNode(NodePath, RootNode);
  if Assigned(Node) then
    if Node.HasAttribute(AttributeName) then
      Result := Node.Attributes[AttributeName];
end;

function TSLGXMLDocument.FindXMLNode(NodePath: string; RootNode: IXMLNode = nil; CreateIfNotExists: Boolean = False; CreateNew: Boolean = False): IXMLNode;
var NextPath, CurrentTag, CurrentTagUP: string;
    CurrentNodes: IXMLNodeList;
    Node: IXMLNode;
    NodeIndex: Integer;
    CurrentNodeName: string;
begin
  // Em caso de erro não retorna lixo de memória
  Result := nil;

  // Quebra o caminho em um array contendo o nome das tags
  CurrentTag := TRegEx.Match(NodePath, '\/[^/]+').Value;
  NextPath := TRegex.Replace(NodePath, CurrentTag + '(?=/|$)', '');
  CurrentTag := TRegEx.Match(CurrentTag, '[^/]+').Value;
  CurrentTagUP := UpperCase(CurrentTag);

  // Se nenhum nó foi especificado, começa do elemento raiz (Document)
  if Assigned(RootNode) then
    CurrentNodes := RootNode.ChildNodes
  else if Assigned(FRootNode) then
    CurrentNodes := FRootNode.ChildNodes
  else
    CurrentNodes := ChildNodes;


  // Percorre a lista de tags
  if CreateNew then
    Node := CurrentNodes.Nodes[CurrentNodes.Add(CreateElement(CurrentTag, ''))]
  else
  begin
    // Procura sempre a ultima tag adicionada
    for NodeIndex := CurrentNodes.Count - 1 downto 0 do
    begin
      CurrentNodeName := UpperCase(CurrentNodes.Nodes[NodeIndex].NodeName);
      if CurrentNodeName = CurrentTagUP then
      begin
        Node := CurrentNodes.Nodes[NodeIndex];
        Break;
      end;
    end;

    // Se a tag não foi encontrada
    if not Assigned(Node) then
      // Se podemos criar as tags faltantes
      if CreateIfNotExists then
        Node := CurrentNodes.Nodes[CurrentNodes.Add(CreateElement(CurrentTag, ''))]
      else
        // Retornamos nil pois não encontramos a tag desejada
        Exit(nil);
  end;

  // Se chegamos ao fim do caminho
  if NextPath = '' then
    Result := Node
  else
    Result := FindXMLNode(NextPath, Node, CreateIfNotExists, CreateNew);
end;

function TSLGXMLDocument.FindXMLNodeValue(NodePath: string; RootNode: IXMLNode): string;
var Node: IXMLNode;
begin
  Result := '';
  Node := FindXMLNode(NodePath, RootNode);
  if Assigned(Node) then
    Result := Node.Text;
end;

procedure TSLGXMLDocument.LoadFromXML(const XML: DOMString);
begin
  CoInitialize(nil);
  inherited LoadFromXML(XML);
  CoUninitialize;
end;

function TSLGXMLDocument.LocateNode(NodeName: string; out Node: IXMLNode): Boolean;
begin
  Node := nil;
  Node := SearchNode(NodeName, DocumentElement.ChildNodes);
  Result := Assigned(Node);
end;

constructor TSLGXMLDocument.Create;
begin
  inherited Create(Application);
  CoInitialize(nil);
end;

destructor TSLGXMLDocument.Destroy;
begin
  CoUninitialize;
  inherited;
end;

function TSLGXMLDocument.SearchNode(NodeName: string; ParentNodeList: IXMLNodeList): IXMLNode;
var i: Integer;
begin
  Result := ParentNodeList.FindNode(NodeName);
  if not Assigned(Result) then
    for i := 0 to ParentNodeList.Count - 1 do
    begin
      Result := SearchNode(NodeName, ParentNodeList.Nodes[i].ChildNodes);
      if Assigned(Result) then
        Break;
    end;
end;

function TSLGXMLDocument.SearchXMLNode(NodeName: string): IXMLNode;
  function FindInSUbNode(ParentNode: IXMLNode): IXMLNode;
  var i: Integer;
  begin
    Result := nil;
    for i := 0 to ParentNode.ChildNodes.Count - 1 do
      if ParentNode.ChildNodes.Nodes[i].NodeName = NodeName then
        Exit(ParentNode.ChildNodes.Nodes[i])
      else if ParentNode.ChildNodes.Nodes[i].HasChildNodes then
      begin
        Result := FindInSUbNode(ParentNode.ChildNodes.Nodes[i]);
        if Assigned(Result) then
          Break;
      end;
  end;
begin
  if DocumentElement.NodeName = NodeName then
    Exit(DocumentElement);
  Result := FindInSubNode(DocumentElement);
end;

function TSLGXMLDocument.SetRootNode(RootNodePath: string): Boolean;
begin
  FRootNode := nil;
  try
    FRootNode := FindXMLNode(RootNodePath);
  except
    FRootNode := nil;
  end;
  Result := Assigned(FRootNode);
end;

procedure TSLGXMLDocument.Write(Path, Value: string);
begin

end;

initialization
  DefaultDOMVendor := SMSXML;

end.
