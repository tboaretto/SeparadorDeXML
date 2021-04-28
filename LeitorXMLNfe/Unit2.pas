unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc,
  Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    XMLDocument1: TXMLDocument;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);

var
nodeInfNfe: IXMLNode;
nodeenderEmit, nodeIde, nodeemit: IXMLNode;
i,e : Integer;

begin
  Memo1.Lines.Clear;

  XMLDocument1.LoadFromFile('C:\gabriel\XMLs\xml_nfe_1.xml');
  nodeInfNfe := XMLDocument1.ChildNodes.FindNode('nfeProc').ChildNodes.FindNode('NFe').ChildNodes.FindNode('infNFe');
  nodeIde := nodeInfNfe.ChildNodes.FindNode('ide');
  for i := 0 to nodeIde.ChildNodes.Count-1 do
    Memo1.Lines.Add(nodeIde.ChildNodes[i].NodeName+' = '+nodeIde.ChildNodes[i].Text);


  nodeemit := nodeInfNfe.ChildNodes.FindNode('emit');
  for i := 0 to nodeemit.ChildNodes.Count-1 do
  begin

    if (nodeemit.ChildNodes[i].NodeName <> 'enderEmit') then
      Memo1.Lines.Add(nodeemit.ChildNodes[i].NodeName+' = '+nodeemit.ChildNodes[i].Text)
    else
    begin
      nodeenderEmit := nodeemit.ChildNodes.FindNode('enderEmit');
      for e := 0 to nodeenderEmit.ChildNodes.Count-1 do
        Memo1.Lines.Add(nodeenderEmit.ChildNodes[e].NodeName+' = '+nodeenderEmit.ChildNodes[e].Text)
    end;


  end;





end;

end.
