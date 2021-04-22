unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    XMLDocument1: TXMLDocument;
    BtnText: TButton;
    Memo2: TMemo;
    BtnConverter: TButton;
    EdtXml: TLabeledEdit;
    procedure BtnTextClick(Sender: TObject);
    procedure BtnConverterClick(Sender: TObject);
  private

    { Private declarations }
  public
    function RemoverTag(tag: string; valor: string): string;
    { Public declarations }

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BtnConverterClick(Sender: TObject);
var
 i:integer;
// Posicao: integer;
 m: string;
begin
  Memo2.Lines.Clear;
  for i := 0 to Pred(Memo1.Lines.Count) do
  begin
//    if (Memo1.Lines.Strings[i].Contains('<ide>') = True) then Memo2.Lines.Add(memo1.Lines.Strings[i]);
    if (Memo1.Lines.Strings[i].Contains('<infCte ') = True) then Memo2.Lines.Add('incluirCTe');
    if (Memo1.Lines.Strings[i].Contains('versao=') = True) then Memo2.Lines.Add('versao_2=3.00');
    if (Memo1.Lines.Strings[i].Contains('<cUF>') = True) then Memo2.Lines.Add('cUF_5='+RemoverTag('cUF',memo1.Lines.Strings[i]));

    if (Memo1.Lines.Strings[i].Contains('<cCT>') = True) then Memo2.Lines.Add('cCT_6='+RemoverTag('cCT',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CFOP>') = True) then Memo2.Lines.Add('CFOP_7='+RemoverTag('CFOP',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<natOp>') = True) then Memo2.Lines.Add('natOp_8='+RemoverTag('natOp',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<mod>') = True) then Memo2.Lines.Add('mod_10='+RemoverTag('mod',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<serie>') = True) then Memo2.Lines.Add('serie_11='+RemoverTag('serie',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nCT>') = True) then Memo2.Lines.Add('nCT_12='+RemoverTag('nCT',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<dhEmi>') = True) then Memo2.Lines.Add('dhEmi_13='+RemoverTag('dhEmi',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<tpImp>') = True) then Memo2.Lines.Add('tpImp_14='+RemoverTag('tpImp',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<tpEmis>') = True) then Memo2.Lines.Add('tpEmis_15='+RemoverTag('tpEmis',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<cDV>') = True) then Memo2.Lines.Add('cDV_16='+RemoverTag('cDV',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<tpAmb>') = True) then Memo2.Lines.Add('tpAmb_17='+RemoverTag('tpAmb',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<tpCTe>') = True) then Memo2.Lines.Add('tpCTe_18='+RemoverTag('tpCTe',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<procEmi>') = True) then Memo2.Lines.Add('procEmi_19='+RemoverTag('tpprocEmiAmb',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<verProc>') = True) then Memo2.Lines.Add('verProc_20='+RemoverTag('verProc',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<cMunEnv>') = True) then Memo2.Lines.Add('cMunEnv_672='+RemoverTag('cMunEnv',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xMunEnv>') = True) then Memo2.Lines.Add('xMunEnv_673='+RemoverTag('xMunEnv',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<UFEnv>') = True) then Memo2.Lines.Add('UFEnv_674='+RemoverTag('UFEnv',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<modal>') = True) then Memo2.Lines.Add('tmodal_25='+RemoverTag('modal',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<tpServ>') = True) then Memo2.Lines.Add('tpServ_26='+RemoverTag('tpServ',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<cMunIni>') = True) then Memo2.Lines.Add('cMunIni_27='+RemoverTag('cMunIni',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xMunIni>') = True) then Memo2.Lines.Add('xMunIni_28='+RemoverTag('xMunIni',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<UFIni>') = True) then Memo2.Lines.Add('UFIni_29='+RemoverTag('UFIni',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<cMunFim>') = True) then Memo2.Lines.Add('cMunFim_30='+RemoverTag('cMunFim',memo1.Lines.Strings[i]));


    if (Memo1.Lines.Strings[i].Contains('<xMunFim>') = True) then Memo2.Lines.Add('xMunFim_31='+RemoverTag('xMunFim',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<UFFim>') = True) then Memo2.Lines.Add('UFFim_32='+RemoverTag('UFFim',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<retira>') = True) then Memo2.Lines.Add('retira_33='+RemoverTag('retira',memo1.Lines.Strings[i]));

   if (Memo1.Lines.Strings[i].Contains('<retira>') = True) then Memo2.Lines.Add('retira_33='+RemoverTag('retira',memo1.Lines.Strings[i]));
//   if (Memo1.Lines.Strings[i].Contains('<xDetRetira>') = True) then Memo2.Lines.Add('xDetRetira_34='+RemoverTag('xDetRetira',memo1.Lines.Strings[i]));

    if (Memo1.Lines.Strings[i].Contains('<indIEToma>') = True) then Memo2.Lines.Add('toma_36=0');
    if (Memo1.Lines.Strings[i].Contains('<indIEToma>') = True) then Memo2.Lines.Add('toma_38=');


    if (Memo1.Lines.Strings[i].Contains('</ide>') = True) then Memo2.Lines.Add('</ide>');
    if (Memo1.Lines.Strings[i].Contains('<compl>') = True) then Memo2.Lines.Add('<compl>');
    if (Memo1.Lines.Strings[i].Contains('<xObs>') = True) then Memo2.Lines.Add('xObs_87='+RemoverTag('xObs',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<ObsCont ') = True) then Memo2.Lines.Add('<ObsCont xCampo="LEI_TRANSP">');
    if (Memo1.Lines.Strings[i].Contains('<xTexto>') = True) then Memo2.Lines.Add('xObs_90='+RemoverTag('xTexto',memo1.Lines.Strings[i]));






  end;
end;


procedure TForm1.BtnTextClick(Sender: TObject);
begin
Memo1.Lines.Clear;

//   memo1.Lines.LoadFromFile('C:\XMLs\Exemplo_CTE.xml');
   memo1.Lines.LoadFromFile(EdtXml.Text);

end;



function TForm1.RemoverTag(tag, valor: string): string;
var
 x : string;
begin
  Result := '';
  x:= StringReplace(valor,'<'+tag+'>',' ',[]);
  x:= StringReplace(x,'</'+tag+'>',' ',[]);
  Result := Trim(x);
end;


end.
