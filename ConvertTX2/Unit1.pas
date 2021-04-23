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
    procedure tx2Cte;
    procedure tx2MDFe;
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
begin
  Memo2.Lines.Clear;

  for i := 0 to Pred(Memo1.Lines.Count) do
  begin
   if (Memo1.Lines.Strings[i].Contains('<infCte ') = True) then
       tx2Cte;
   if (Memo1.Lines.Strings[i].Contains('<infMDFe ') = True) then
       tx2MDFe;

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


procedure TForm1.tx2Cte;
var
 i:integer;
 m: string;
begin

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
    if (Memo1.Lines.Strings[i].Contains('<xTexto>') = True) then Memo2.Lines.Add('xTexto='+RemoverTag('xTexto',memo1.Lines.Strings[i]));

    if (Memo1.Lines.Strings[i].Contains('<emit>') = True) then Memo2.Lines.Add('emit='+RemoverTag('emit',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CNPJ>') = True) then Memo2.Lines.Add('CNPJ_95='+RemoverTag('CNPJ',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<IE>') = True) then Memo2.Lines.Add('IE_96='+RemoverTag('IE',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xNome>') = True) then Memo2.Lines.Add('xNome_97='+RemoverTag('xNome',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xFant>') = True) then Memo2.Lines.Add('xFant_98='+RemoverTag('xFant',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<enderEmit>') = True) then Memo2.Lines.Add('enderEmit='+RemoverTag('enderEmit',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xLgr>') = True) then Memo2.Lines.Add('xLgr_100='+RemoverTag('xLgr',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nro>') = True) then Memo2.Lines.Add('nro_101='+RemoverTag('nro',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xCpl>') = True) then Memo2.Lines.Add('xCpl_102='+RemoverTag('xCpl',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xBairro>') = True) then Memo2.Lines.Add('xBairro_103='+RemoverTag('xBairro',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<cMun>') = True) then Memo2.Lines.Add('cMun_104='+RemoverTag('cMun',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xMun>') = True) then Memo2.Lines.Add('xMun_105='+RemoverTag('xMun',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CEP>') = True) then Memo2.Lines.Add('CEP_106='+RemoverTag('CEP',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<UF>') = True) then Memo2.Lines.Add('UF_107='+RemoverTag('UF',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<fone>') = True) then Memo2.Lines.Add('fone_110='+RemoverTag('fone',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<rem>') = True) then Memo2.Lines.Add('rem='+RemoverTag('rem',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CNPJ>') = True) then Memo2.Lines.Add('CNPJ_112='+RemoverTag('CNPJ',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CPF>') = True) then Memo2.Lines.Add('CPF_113='+RemoverTag('CPF',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<IE>') = True) then Memo2.Lines.Add('IE_114='+RemoverTag('IE',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xNome>') = True) then Memo2.Lines.Add('xNome_115='+RemoverTag('xNome',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xFant>') = True) then Memo2.Lines.Add('xFant_116='+RemoverTag('xFant',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<fone>') = True) then Memo2.Lines.Add('fone_117='+RemoverTag('fone',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<enderReme>') = True) then Memo2.Lines.Add('enderReme='+RemoverTag('enderReme',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xLgr>') = True) then Memo2.Lines.Add('xLgr_119='+RemoverTag('xLgr',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nro>') = True) then Memo2.Lines.Add('nro_120='+RemoverTag('nro',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xCpl>') = True) then Memo2.Lines.Add('xCpl_121='+RemoverTag('xCpl',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xBairro>') = True) then Memo2.Lines.Add('xBairro_122='+RemoverTag('xBairro',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<cMun>') = True) then Memo2.Lines.Add('cMun_123='+RemoverTag('cMun',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xMun>') = True) then Memo2.Lines.Add('xMun_124='+RemoverTag('xMun',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CEP>') = True) then Memo2.Lines.Add('CEP_125='+RemoverTag('CEP',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<UF>') = True) then Memo2.Lines.Add('UF_126='+RemoverTag('UF',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<cPais>') = True) then Memo2.Lines.Add('cPais_127='+RemoverTag('cPais',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xPais>') = True) then Memo2.Lines.Add('xPais_128='+RemoverTag('xPais',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<email>') = True) then Memo2.Lines.Add('email_604='+RemoverTag('email',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<locColeta>') = True) then Memo2.Lines.Add('locColeta='+RemoverTag('locColeta',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CNPJ>') = True) then Memo2.Lines.Add('CNPJ_165='+RemoverTag('CNPJ',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CPF>') = True) then Memo2.Lines.Add('CPF_166='+RemoverTag('CPF',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xNome>') = True) then Memo2.Lines.Add('xNome_168='+RemoverTag('xNome',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xLgr>') = True) then Memo2.Lines.Add('xLgr_171='+RemoverTag('xLgr',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nro>') = True) then Memo2.Lines.Add('nro_172='+RemoverTag('nro',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xCpl>') = True) then Memo2.Lines.Add('xCpl_173='+RemoverTag('xCpl',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xBairro>') = True) then Memo2.Lines.Add('xBairro_174='+RemoverTag('xBairro',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<cMun>') = True) then Memo2.Lines.Add('cMun_175='+RemoverTag('cMun',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xMun>') = True) then Memo2.Lines.Add('xMun_176='+RemoverTag('xMun',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<UF>') = True) then Memo2.Lines.Add('UF_178='+RemoverTag('UF',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<exped>') = True) then Memo2.Lines.Add('exped='+RemoverTag('exped',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CNPJ>') = True) then Memo2.Lines.Add('CNPJ_182='+RemoverTag('CNPJ',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CPF>') = True) then Memo2.Lines.Add('CPF_183='+RemoverTag('CPF',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<IE>') = True) then Memo2.Lines.Add('IE_184='+RemoverTag('IE',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xNome>') = True) then Memo2.Lines.Add('xNome='+RemoverTag('xNome',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<fone>') = True) then Memo2.Lines.Add('fone_186='+RemoverTag('fone',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<enderExped>') = True) then Memo2.Lines.Add('enderExped='+RemoverTag('enderExped',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xLgr>') = True) then Memo2.Lines.Add('xLgr_188='+RemoverTag('xLgr',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nro>') = True) then Memo2.Lines.Add('nro_189='+RemoverTag('nro',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xCpl>') = True) then Memo2.Lines.Add('xCpl_190='+RemoverTag('xCpl',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xBairro>') = True) then Memo2.Lines.Add('xBairro_191='+RemoverTag('xBairro',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<cMun>') = True) then Memo2.Lines.Add('cMun_192='+RemoverTag('cMun',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xMun>') = True) then Memo2.Lines.Add('xMun_193='+RemoverTag('xMun',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CEP>') = True) then Memo2.Lines.Add('CEP_194='+RemoverTag('CEP',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<UF>') = True) then Memo2.Lines.Add('UF_195='+RemoverTag('UF',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<cPais>') = True) then Memo2.Lines.Add('cPais_196='+RemoverTag('cPais',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xPais>') = True) then Memo2.Lines.Add('xPais_197='+RemoverTag('xPais',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<email>') = True) then Memo2.Lines.Add('email_607='+RemoverTag('email',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<receb>') = True) then Memo2.Lines.Add('receb='+RemoverTag('receb',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CNPJ>') = True) then Memo2.Lines.Add('CNPJ_199='+RemoverTag('CNPJ',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CPF>') = True) then Memo2.Lines.Add('CPF_200='+RemoverTag('CPF',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<IE>') = True) then Memo2.Lines.Add('IE_201='+RemoverTag('IE',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xNome>') = True) then Memo2.Lines.Add('xNome_202='+RemoverTag('xNome',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<fone>') = True) then Memo2.Lines.Add('fone_203='+RemoverTag('fone',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<enderReceb>') = True) then Memo2.Lines.Add('enderReceb='+RemoverTag('enderReceb',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xLgr>') = True) then Memo2.Lines.Add('xLgr_206='+RemoverTag('xLgr',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nro>') = True) then Memo2.Lines.Add('nro_207='+RemoverTag('nro',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xCpl>') = True) then Memo2.Lines.Add('xCpl_208='+RemoverTag('xCpl',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xBairro>') = True) then Memo2.Lines.Add('xBairro_209='+RemoverTag('xBairro',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<cMun>') = True) then Memo2.Lines.Add('cMun_210='+RemoverTag('cMun',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xMun>') = True) then Memo2.Lines.Add('xMun_211='+RemoverTag('xMun',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CEP>') = True) then Memo2.Lines.Add('CEP_212='+RemoverTag('CEP',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<UF>') = True) then Memo2.Lines.Add('UF_213='+RemoverTag('UF',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<cPais>') = True) then Memo2.Lines.Add('cPais_214='+RemoverTag('cPais',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xPais>') = True) then Memo2.Lines.Add('xPais_215='+RemoverTag('xPais',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<email>') = True) then Memo2.Lines.Add('email_608='+RemoverTag('email',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<dest>') = True) then Memo2.Lines.Add('dest='+RemoverTag('dest',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CNPJ>') = True) then Memo2.Lines.Add('CNPJ='+RemoverTag('CNPJ',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CPF>') = True) then Memo2.Lines.Add('CPF='+RemoverTag('CPF',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<IE>') = True) then Memo2.Lines.Add('IE='+RemoverTag('IE',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xNome>') = True) then Memo2.Lines.Add('xNome='+RemoverTag('xNome',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<fone>') = True) then Memo2.Lines.Add('fone='+RemoverTag('fone',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<ISUF>') = True) then Memo2.Lines.Add('ISUF='+RemoverTag('ISUF',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<enderDest>') = True) then Memo2.Lines.Add('enderDest='+RemoverTag('enderDest',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xLgr>') = True) then Memo2.Lines.Add('xLgr='+RemoverTag('xLgr',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nro>') = True) then Memo2.Lines.Add('nro='+RemoverTag('nro',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xCpl>') = True) then Memo2.Lines.Add('xCpl='+RemoverTag('xCpl',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xBairro>') = True) then Memo2.Lines.Add('xBairro='+RemoverTag('xBairro',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<cMun>') = True) then Memo2.Lines.Add('cMun='+RemoverTag('cMun',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xMun>') = True) then Memo2.Lines.Add('xMun='+RemoverTag('xMun',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CEP>') = True) then Memo2.Lines.Add('CEP='+RemoverTag('CEP',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<UF>') = True) then Memo2.Lines.Add('UF='+RemoverTag('UF',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<cPais>') = True) then Memo2.Lines.Add('cPais='+RemoverTag('cPais',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xPais>') = True) then Memo2.Lines.Add('xPais='+RemoverTag('xPais',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<email>') = True) then Memo2.Lines.Add('email='+RemoverTag('email',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<locEnt>') = True) then Memo2.Lines.Add('locEnt='+RemoverTag('locEnt',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CNPJ>') = True) then Memo2.Lines.Add('CNPJ='+RemoverTag('CNPJ',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CPF>') = True) then Memo2.Lines.Add('CPF='+RemoverTag('CPF',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xNome>') = True) then Memo2.Lines.Add('xNome='+RemoverTag('xNome',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xLgr>') = True) then Memo2.Lines.Add('xLgr='+RemoverTag('xLgr',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nro>') = True) then Memo2.Lines.Add('nro='+RemoverTag('nro',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xCpl>') = True) then Memo2.Lines.Add('xCpl='+RemoverTag('xCpl',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xBairro>') = True) then Memo2.Lines.Add('xBairro='+RemoverTag('xBairro',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<cMun>') = True) then Memo2.Lines.Add('cMun='+RemoverTag('cMun',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xMun>') = True) then Memo2.Lines.Add('xMun='+RemoverTag('xMun',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<UF>') = True) then Memo2.Lines.Add('UF='+RemoverTag('UF',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vPrest>') = True) then Memo2.Lines.Add('vPrest='+RemoverTag('vPrest',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vTPrest>') = True) then Memo2.Lines.Add('vTPrest_228='+RemoverTag('vTPrest',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vRec>') = True) then Memo2.Lines.Add('vRec_229='+RemoverTag('vRec',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<Comp>') = True) then Memo2.Lines.Add('Comp='+RemoverTag('Comp',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xNome>') = True) then Memo2.Lines.Add('xNome='+RemoverTag('xNome',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vComp>') = True) then Memo2.Lines.Add('vComp='+RemoverTag('vComp',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<imp>') = True) then Memo2.Lines.Add('imp='+RemoverTag('imp',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<ICMS>') = True) then Memo2.Lines.Add('ICMS='+RemoverTag('ICMS',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<ICMS00>') = True) then Memo2.Lines.Add('ICMS00='+RemoverTag('ICMS00',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CST>') = True) then Memo2.Lines.Add('CST_609='+RemoverTag('CST',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vBC>') = True) then Memo2.Lines.Add('vBC_610='+RemoverTag('vBC',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<pICMS>') = True) then Memo2.Lines.Add('pICMS_611='+RemoverTag('pICMS',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vICMS>') = True) then Memo2.Lines.Add('vICMS_612='+RemoverTag('vICMS',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<ICMS20>') = True) then Memo2.Lines.Add('ICMS20='+RemoverTag('ICMS20',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CST>') = True) then Memo2.Lines.Add('CST_613='+RemoverTag('CST',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<pRedBC>') = True) then Memo2.Lines.Add('pRedBC_614='+RemoverTag('pRedBC',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vBC>') = True) then Memo2.Lines.Add('vBC_615='+RemoverTag('vBC',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<pICMS>') = True) then Memo2.Lines.Add('pICMS_616='+RemoverTag('pICMS',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vICMS>') = True) then Memo2.Lines.Add('vICMS_617='+RemoverTag('vICMS',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<ICMS45>') = True) then Memo2.Lines.Add('ICMS45='+RemoverTag('ICMS45',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CST>') = True) then Memo2.Lines.Add('CST_618='+RemoverTag('CST',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<ICMS60>') = True) then Memo2.Lines.Add('ICMS60='+RemoverTag('ICMS60',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CST>') = True) then Memo2.Lines.Add('CST_619='+RemoverTag('CST',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vBCSTRet>') = True) then Memo2.Lines.Add('vBCSTRet_620='+RemoverTag('vBCSTRet',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vICMSSTRet>') = True) then Memo2.Lines.Add('vICMSSTRet_621='+RemoverTag('vICMSSTRet',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<pICMSSTRet>') = True) then Memo2.Lines.Add('pICMSSTRet_622='+RemoverTag('pICMSSTRet',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vCred>') = True) then Memo2.Lines.Add('vCred_623='+RemoverTag('vCred',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<ICMS90>') = True) then Memo2.Lines.Add('ICMS90='+RemoverTag('ICMS90',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CST>') = True) then Memo2.Lines.Add('CST_624='+RemoverTag('CST',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<pRedBC>') = True) then Memo2.Lines.Add('pRedBC_625='+RemoverTag('pRedBC',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vBC>') = True) then Memo2.Lines.Add('vBC_626='+RemoverTag('vBC',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<pICMS>') = True) then Memo2.Lines.Add('pICMS_627='+RemoverTag('pICMS',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vICMS>') = True) then Memo2.Lines.Add('VICMS_628='+RemoverTag('vICMS',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vCred>') = True) then Memo2.Lines.Add('vCred_629='+RemoverTag('vCred',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<UCMSOutraUF>') = True) then Memo2.Lines.Add('ICMSOutraUF='+RemoverTag('UCMSOutraUF',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CST>') = True) then Memo2.Lines.Add('CST_630='+RemoverTag('CST',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<pRedBCOutraUF>') = True) then Memo2.Lines.Add('pRedBCOutraUF_631='+RemoverTag('pRedBCOutraUF',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vBCOutraUF>') = True) then Memo2.Lines.Add('vBCOutraUF_632='+RemoverTag('vBCOutraUF',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<pICMSOutraUF>') = True) then Memo2.Lines.Add('pICMSOutraUF_633='+RemoverTag('pICMSOutraUF',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vICMSOutraUF>') = True) then Memo2.Lines.Add('vICMSOutraUF_634='+RemoverTag('vICMSOutraUF',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<ICMSSN>') = True) then Memo2.Lines.Add('ICMSSN='+RemoverTag('ICMSSN',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<cst>') = True) then Memo2.Lines.Add('CST='+RemoverTag('cst',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<indSN>') = True) then Memo2.Lines.Add('indSN_635='+RemoverTag('indSN',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<ICMSUFFim>') = True) then Memo2.Lines.Add('ICMSUFFim='+RemoverTag('ICMSUFFim',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vBCUFFim>') = True) then Memo2.Lines.Add('vBCUFFim_676='+RemoverTag('vBCUFFim',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<pFCPUFFim>') = True) then Memo2.Lines.Add('pFCPUFFim_682='+RemoverTag('pFCPUFFim',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<pICMSUFFim>') = True) then Memo2.Lines.Add('pICMSUFFim_677='+RemoverTag('pICMSUFFim',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<pICMSInter>') = True) then Memo2.Lines.Add('pICMSInter_678='+RemoverTag('pICMSInter',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vFCPUFFim>') = True) then Memo2.Lines.Add('vFCPUFFim_683='+RemoverTag('vFCPUFFim',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vICMSUFFim>') = True) then Memo2.Lines.Add('vICMSUFFim_680='+RemoverTag('vICMSUFFim',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vICMSUFIni>') = True) then Memo2.Lines.Add('vICMSUFIni_681='+RemoverTag('vICMSUFIni',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vTotTrib>') = True) then Memo2.Lines.Add('vTotTrib_268='+RemoverTag('vTotTrib',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<infAdFisco>') = True) then Memo2.Lines.Add('infAdFisco_267='+RemoverTag('infAdFisco',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<infCTeNorm>') = True) then Memo2.Lines.Add('infCTeNorm='+RemoverTag('infCTeNorm',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<infCarga>') = True) then Memo2.Lines.Add('infCarga='+RemoverTag('infCarga',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vCarga>') = True) then Memo2.Lines.Add('vCarga_671='+RemoverTag('vCarga',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<proPred>') = True) then Memo2.Lines.Add('proPred_271='+RemoverTag('proPred',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xOutCat>') = True) then Memo2.Lines.Add('xOutCat_272='+RemoverTag('xOutCat',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<infQ>') = True) then Memo2.Lines.Add('infQ='+RemoverTag('infQ',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<cUnid>') = True) then Memo2.Lines.Add('cUnid_274='+RemoverTag('cUnid',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<tpMed>') = True) then Memo2.Lines.Add('tpMed_275='+RemoverTag('tpMed',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<qCarga>') = True) then Memo2.Lines.Add('qCarga_276='+RemoverTag('qCarga',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<infDoc>') = True) then Memo2.Lines.Add('infDoc='+RemoverTag('infDoc',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<infNF>') = True) then Memo2.Lines.Add('infNF='+RemoverTag('infNF',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nRoma>') = True) then Memo2.Lines.Add('nRoma_130='+RemoverTag('nRoma',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nPed>') = True) then Memo2.Lines.Add('nPed_131='+RemoverTag('nPed',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<mod>') = True) then Memo2.Lines.Add('mod_605='+RemoverTag('mod',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<serie>') = True) then Memo2.Lines.Add('serie_132='+RemoverTag('serie',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nDoc>') = True) then Memo2.Lines.Add('nDoc_133='+RemoverTag('nDoc',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<dEmi>') = True) then Memo2.Lines.Add('dEmi_134='+RemoverTag('dEmi',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vBC>') = True) then Memo2.Lines.Add('vBC_135='+RemoverTag('vBC',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vICMS>') = True) then Memo2.Lines.Add('vICMS_136='+RemoverTag('vICMS',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vBCST>') = True) then Memo2.Lines.Add('vBCST_137='+RemoverTag('vBCST',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vST>') = True) then Memo2.Lines.Add('vST_138='+RemoverTag('vST',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vProd>') = True) then Memo2.Lines.Add('vProd_139='+RemoverTag('vProd',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vNF>') = True) then Memo2.Lines.Add('vNF_140='+RemoverTag('vNF',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nCFOP>') = True) then Memo2.Lines.Add('nCFOP_141='+RemoverTag('nCFOP',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vPeso>') = True) then Memo2.Lines.Add('vPeso='+RemoverTag('vPeso',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<infUnidTransp>') = True) then Memo2.Lines.Add('infUnidTransp='+RemoverTag('infUnidTransp',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<tpUnidTranssp>') = True) then Memo2.Lines.Add('tpUnidTransp='+RemoverTag('tpUnidTranssp',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<idUnidTransp>') = True) then Memo2.Lines.Add('idUnidTransp='+RemoverTag('idUnidTransp',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<lacUnidTransp>') = True) then Memo2.Lines.Add('lacUnidTransp='+RemoverTag('lacUnidTransp',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nLacre>') = True) then Memo2.Lines.Add('nLacre='+RemoverTag('nLacre',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<infUnidCarga>') = True) then Memo2.Lines.Add('infUnidCarga='+RemoverTag('infUnidCarga',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<tpUnidCarga>') = True) then Memo2.Lines.Add('tpUnidCarga='+RemoverTag('tpUnidCarga',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<idUnidCarga>') = True) then Memo2.Lines.Add('idUnidCarga='+RemoverTag('idUnidCarga',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<lacUnidCarga>') = True) then Memo2.Lines.Add('lacUnidCarga='+RemoverTag('lacUnidCarga',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nLacre>') = True) then Memo2.Lines.Add('nLacre='+RemoverTag('nLacre',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<qtdRat>') = True) then Memo2.Lines.Add('qtdRat='+RemoverTag('qtdRat',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<qtdRat>') = True) then Memo2.Lines.Add('qtdRat='+RemoverTag('qtdRat',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<infUnidCarga>') = True) then Memo2.Lines.Add('infUnidCarga='+RemoverTag('infUnidCarga',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<tpUnidCarga>') = True) then Memo2.Lines.Add('tpUnidCarga='+RemoverTag('tpUnidCarga',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<idUnidCarga>') = True) then Memo2.Lines.Add('idUnidCarga='+RemoverTag('idUnidCarga',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<lacUnidCarga>') = True) then Memo2.Lines.Add('lacUnidCarga='+RemoverTag('lacUnidCarga',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nLacre>') = True) then Memo2.Lines.Add('nLacre='+RemoverTag('nLacre',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<qtdRat>') = True) then Memo2.Lines.Add('qtdRat='+RemoverTag('qtdRat',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<infNFe>') = True) then Memo2.Lines.Add('infNFe='+RemoverTag('infNFe',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<chave>') = True) then Memo2.Lines.Add('chave='+RemoverTag('chave',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<PIN>') = True) then Memo2.Lines.Add('PIN='+RemoverTag('PIN',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<dPrev>') = True) then Memo2.Lines.Add('dPrev='+RemoverTag('dPrev',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<infUnidTransp>') = True) then Memo2.Lines.Add('infUnidTransp='+RemoverTag('infUnidTransp',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<tpUnidTransp>') = True) then Memo2.Lines.Add('tpUnidTransp='+RemoverTag('tpUnidTransp',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<idUnidTransp>') = True) then Memo2.Lines.Add('idUnidTransp='+RemoverTag('idUnidTransp',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<lacUnidTransp>') = True) then Memo2.Lines.Add('lacUnidTransp='+RemoverTag('lacUnidTransp',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nLacre>') = True) then Memo2.Lines.Add('nLacre='+RemoverTag('nLacre',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<infUnidCarga>') = True) then Memo2.Lines.Add('infUnidCarga='+RemoverTag('infUnidCarga',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<tpUnidCarga>') = True) then Memo2.Lines.Add('tpUnidCarga='+RemoverTag('tpUnidCarga',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<idUnidCarga>') = True) then Memo2.Lines.Add('idUnidCarga='+RemoverTag('idUnidCarga',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<lacUnidCarga>') = True) then Memo2.Lines.Add('lacUnidCarga='+RemoverTag('lacUnidCarga',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nLacre>') = True) then Memo2.Lines.Add('nLacre='+RemoverTag('nLacre',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<qtdRat>') = True) then Memo2.Lines.Add('qtdRat='+RemoverTag('qtdRat',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<qtdRat>') = True) then Memo2.Lines.Add('qtdRat='+RemoverTag('qtdRat',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<infUnidCarga>') = True) then Memo2.Lines.Add('infUnidCarga='+RemoverTag('infUnidCarga',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<tpUnidCarga>') = True) then Memo2.Lines.Add('tpUnidCarga='+RemoverTag('tpUnidCarga',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<idUnidCarga>') = True) then Memo2.Lines.Add('idUnidCarga='+RemoverTag('idUnidCarga',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<lacUnidCarga>') = True) then Memo2.Lines.Add('lacUnidCarga='+RemoverTag('lacUnidCarga',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nLacre>') = True) then Memo2.Lines.Add('nLacre='+RemoverTag('nLacre',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<qtdRat>') = True) then Memo2.Lines.Add('qtdRat='+RemoverTag('qtdRat',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<infOutros>') = True) then Memo2.Lines.Add('infOutros='+RemoverTag('infOutros',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<tpDoc>') = True) then Memo2.Lines.Add('tpDoc='+RemoverTag('tpDoc',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<descOutros>') = True) then Memo2.Lines.Add('descOutros='+RemoverTag('descOutros',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nDoc>') = True) then Memo2.Lines.Add('nDoc='+RemoverTag('nDoc',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<dEmi>') = True) then Memo2.Lines.Add('dEmi='+RemoverTag('dEmi',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vDocFisc>') = True) then Memo2.Lines.Add('vDocFisc='+RemoverTag('vDocFisc',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<dPrev>') = True) then Memo2.Lines.Add('dPrev='+RemoverTag('dPrev',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<infUnidTtransp>') = True) then Memo2.Lines.Add('infUnidTransp='+RemoverTag('infUnidTtransp',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<tpUnidTransp>') = True) then Memo2.Lines.Add('tpUnidTransp='+RemoverTag('tpUnidTransp',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<idUnidTransp>') = True) then Memo2.Lines.Add('idUnidTransp='+RemoverTag('idUnidTransp',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<lacUnidTransp>') = True) then Memo2.Lines.Add('lacUnidTransp='+RemoverTag('lacUnidTransp',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nLacre>') = True) then Memo2.Lines.Add('nLacre='+RemoverTag('nLacre',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<infUnidCarga>') = True) then Memo2.Lines.Add('infUnidCarga='+RemoverTag('infUnidCarga',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<tpUnidCarga>') = True) then Memo2.Lines.Add('tpUnidCarga='+RemoverTag('tpUnidCarga',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<idUnidCarga>') = True) then Memo2.Lines.Add('idUnidCarga='+RemoverTag('idUnidCarga',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<lacUnidCarga>') = True) then Memo2.Lines.Add('lacUnidCarga='+RemoverTag('lacUnidCarga',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nLacre>') = True) then Memo2.Lines.Add('nLacre='+RemoverTag('nLacre',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<qtdRat>') = True) then Memo2.Lines.Add('qtdRat='+RemoverTag('qtdRat',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<qtdRat>') = True) then Memo2.Lines.Add('qtdRat='+RemoverTag('qtdRat',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<infUnidCarga>') = True) then Memo2.Lines.Add('infUnidCarga='+RemoverTag('infUnidCarga',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<tpUnidCarga>') = True) then Memo2.Lines.Add('tpUnidCarga='+RemoverTag('tpUnidCarga',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<idUnidCarga>') = True) then Memo2.Lines.Add('idUnidCarga='+RemoverTag('idUnidCarga',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<lacUnidCarga>') = True) then Memo2.Lines.Add('lacUnidCarga='+RemoverTag('lacUnidCarga',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nLacre>') = True) then Memo2.Lines.Add('nLacre='+RemoverTag('nLacre',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<qtdRat>') = True) then Memo2.Lines.Add('qtdRat='+RemoverTag('qtdRat',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<docAnt>') = True) then Memo2.Lines.Add('docAnt='+RemoverTag('docAnt',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<emiDocAnt>') = True) then Memo2.Lines.Add('emiDocAnt='+RemoverTag('emiDocAnt',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CNPJ>') = True) then Memo2.Lines.Add('CNPJ='+RemoverTag('CNPJ',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CPF>') = True) then Memo2.Lines.Add('CPF='+RemoverTag('CPF',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<IE>') = True) then Memo2.Lines.Add('IE='+RemoverTag('IE',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<UF>') = True) then Memo2.Lines.Add('UF='+RemoverTag('UF',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xNome>') = True) then Memo2.Lines.Add('xNome='+RemoverTag('xNome',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<idDocAnt>') = True) then Memo2.Lines.Add('idDocAnt='+RemoverTag('idDocAnt',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<idDocAntPap>') = True) then Memo2.Lines.Add('idDocAntPap='+RemoverTag('idDocAntPap',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<tpDoc>') = True) then Memo2.Lines.Add('tpDoc='+RemoverTag('tpDoc',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<serie>') = True) then Memo2.Lines.Add('serie='+RemoverTag('serie',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<subser>') = True) then Memo2.Lines.Add('subser='+RemoverTag('subser',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nDoc>') = True) then Memo2.Lines.Add('nDoc='+RemoverTag('nDoc',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<dEmi>') = True) then Memo2.Lines.Add('dEmi='+RemoverTag('dEmi',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<idDocAntEle>') = True) then Memo2.Lines.Add('idDocAntEle='+RemoverTag('idDocAntEle',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<chave>') = True) then Memo2.Lines.Add('chCTe='+RemoverTag('chave',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<respSeg>') = True) then Memo2.Lines.Add('respSeg='+RemoverTag('respSeg',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xSeg>') = True) then Memo2.Lines.Add('xSeg='+RemoverTag('xSeg',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nApol>') = True) then Memo2.Lines.Add('nApol='+RemoverTag('nApol',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nAver>') = True) then Memo2.Lines.Add('nAver='+RemoverTag('nAver',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vCarga>') = True) then Memo2.Lines.Add('vCarga='+RemoverTag('vCarga',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<infModal>') = True) then Memo2.Lines.Add('infModal='+RemoverTag('infModal',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<versaoModal>') = True) then Memo2.Lines.Add('versaoModal='+RemoverTag('versaoModal',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<rodo>') = True) then Memo2.Lines.Add('rodo='+RemoverTag('rodo',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<RNTRC>') = True) then Memo2.Lines.Add('RNTRC='+RemoverTag('RNTRC',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<occ>') = True) then Memo2.Lines.Add('occ='+RemoverTag('occ',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<serie>') = True) then Memo2.Lines.Add('serie='+RemoverTag('serie',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nOcc>') = True) then Memo2.Lines.Add('nOcc='+RemoverTag('nOcc',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<dEmi>') = True) then Memo2.Lines.Add('dEmi='+RemoverTag('dEmi',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<emiOcc>') = True) then Memo2.Lines.Add('emiOcc='+RemoverTag('emiOcc',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CNPJ>') = True) then Memo2.Lines.Add('CNPJ='+RemoverTag('CNPJ',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<cInt>') = True) then Memo2.Lines.Add('cInt='+RemoverTag('cInt',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<IE>') = True) then Memo2.Lines.Add('IE='+RemoverTag('IE',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<UF>') = True) then Memo2.Lines.Add('UF='+RemoverTag('UF',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<fone>') = True) then Memo2.Lines.Add('fone='+RemoverTag('fone',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<aereo>') = True) then Memo2.Lines.Add('aereo='+RemoverTag('aereo',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nMinu>') = True) then Memo2.Lines.Add('nMinu='+RemoverTag('nMinu',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nOCA>') = True) then Memo2.Lines.Add('nOCA='+RemoverTag('nOCA',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<dPrevAereo>') = True) then Memo2.Lines.Add('dPrevAereo='+RemoverTag('dPrevAereo',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xLagEmi>') = True) then Memo2.Lines.Add('xLAgEmi='+RemoverTag('xLagEmi',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<IdT>') = True) then Memo2.Lines.Add('IdT='+RemoverTag('IdT',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<tarifa>') = True) then Memo2.Lines.Add('tarifa='+RemoverTag('tarifa',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CL>') = True) then Memo2.Lines.Add('CL='+RemoverTag('CL',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<cTar>') = True) then Memo2.Lines.Add('cTar='+RemoverTag('cTar',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vTar>') = True) then Memo2.Lines.Add('vTar='+RemoverTag('vTar',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<natCarga>') = True) then Memo2.Lines.Add('natCarga='+RemoverTag('natCarga',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xDime>') = True) then Memo2.Lines.Add('xDime='+RemoverTag('xDime',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<cInfManu>') = True) then Memo2.Lines.Add('cInfManu='+RemoverTag('cInfManu',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<cIMP>') = True) then Memo2.Lines.Add('cIMP='+RemoverTag('cIMP',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<aquav>') = True) then Memo2.Lines.Add('aquav='+RemoverTag('aquav',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vPrest>') = True) then Memo2.Lines.Add('vPrest='+RemoverTag('vPrest',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vAFRMM>') = True) then Memo2.Lines.Add('vAFRMM='+RemoverTag('vAFRMM',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nCtrl>') = True) then Memo2.Lines.Add('nCtrl='+RemoverTag('nCtrl',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xNavio>') = True) then Memo2.Lines.Add('xNavio='+RemoverTag('xNavio',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<balsa>') = True) then Memo2.Lines.Add('balsa='+RemoverTag('balsa',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xBalsa>') = True) then Memo2.Lines.Add('xBalsa='+RemoverTag('xBalsa',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nViag>') = True) then Memo2.Lines.Add('nViag='+RemoverTag('nViag',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<direc>') = True) then Memo2.Lines.Add('direc='+RemoverTag('direc',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<tpNav>') = True) then Memo2.Lines.Add('irin='+RemoverTag('tpNav',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<irin>') = True) then Memo2.Lines.Add('tpNav='+RemoverTag('irin',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<ferrov>') = True) then Memo2.Lines.Add('ferrov='+RemoverTag('ferrov',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<tpTraf>') = True) then Memo2.Lines.Add('tpTraf='+RemoverTag('tpTraf',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<trafMut>') = True) then Memo2.Lines.Add('trafMut='+RemoverTag('trafMut',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<respFat>') = True) then Memo2.Lines.Add('respFat='+RemoverTag('respFat',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<terrEmi>') = True) then Memo2.Lines.Add('terrEmi='+RemoverTag('terrEmi',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<fluxo>') = True) then Memo2.Lines.Add('fluxo='+RemoverTag('fluxo',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<idTrem>') = True) then Memo2.Lines.Add('idTrem='+RemoverTag('idTrem',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vFrete>') = True) then Memo2.Lines.Add('vFrete='+RemoverTag('vFrete',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<ferroEnv>') = True) then Memo2.Lines.Add('ferroEnv='+RemoverTag('ferroEnv',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CNPJ>') = True) then Memo2.Lines.Add('CNPJ='+RemoverTag('CNPJ',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<cInt>') = True) then Memo2.Lines.Add('cInt='+RemoverTag('cInt',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<IE>') = True) then Memo2.Lines.Add('IE='+RemoverTag('IE',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xNome>') = True) then Memo2.Lines.Add('xNome='+RemoverTag('xNome',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<enderFerro>') = True) then Memo2.Lines.Add('enderFerro='+RemoverTag('enderFerro',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xLgr>') = True) then Memo2.Lines.Add('xLgr='+RemoverTag('xLgr',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nro>') = True) then Memo2.Lines.Add('nro='+RemoverTag('nro',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xCpl>') = True) then Memo2.Lines.Add('xCpl='+RemoverTag('xCpl',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xBairro>') = True) then Memo2.Lines.Add('xBairro='+RemoverTag('xBairro',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<cMun>') = True) then Memo2.Lines.Add('cMun='+RemoverTag('cMun',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xMun>') = True) then Memo2.Lines.Add('xMun='+RemoverTag('xMun',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CEP>') = True) then Memo2.Lines.Add('CEP='+RemoverTag('CEP',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<UF>') = True) then Memo2.Lines.Add('UF='+RemoverTag('UF',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<detVag>') = True) then Memo2.Lines.Add('detVag='+RemoverTag('detVag',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nVag>') = True) then Memo2.Lines.Add('nVag='+RemoverTag('nVag',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<cap>') = True) then Memo2.Lines.Add('cap='+RemoverTag('cap',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<tpVag>') = True) then Memo2.Lines.Add('tpVag='+RemoverTag('tpVag',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<pesoR>') = True) then Memo2.Lines.Add('pesoR='+RemoverTag('pesoR',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<pesoBC>') = True) then Memo2.Lines.Add('pesoBC='+RemoverTag('pesoBC',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<duto>') = True) then Memo2.Lines.Add('duto='+RemoverTag('duto',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vTar>') = True) then Memo2.Lines.Add('vTar='+RemoverTag('vTar',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<dIni>') = True) then Memo2.Lines.Add('dIni='+RemoverTag('dIni',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<dFim>') = True) then Memo2.Lines.Add('dFim='+RemoverTag('dFim',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<multimodal>') = True) then Memo2.Lines.Add('multimodal='+RemoverTag('multimodal',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<COTM>') = True) then Memo2.Lines.Add('COTM='+RemoverTag('COTM',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<indNegociavel>') = True) then Memo2.Lines.Add('indNegociavel='+RemoverTag('indNegociavel',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<peri>') = True) then Memo2.Lines.Add('peri='+RemoverTag('peri',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nONU>') = True) then Memo2.Lines.Add('nONU='+RemoverTag('nONU',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xNomeAE>') = True) then Memo2.Lines.Add('xNomeAE='+RemoverTag('xNomeAE',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xClaRisco>') = True) then Memo2.Lines.Add('xClaRisco='+RemoverTag('xClaRisco',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<grEmb>') = True) then Memo2.Lines.Add('grEmb='+RemoverTag('grEmb',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<qTotProd>') = True) then Memo2.Lines.Add('qTotProd='+RemoverTag('qTotProd',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<qVolTipo>') = True) then Memo2.Lines.Add('qVolTipo='+RemoverTag('qVolTipo',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<pontoFulgor>') = True) then Memo2.Lines.Add('pontoFulgor='+RemoverTag('pontoFulgor',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<veicNovos>') = True) then Memo2.Lines.Add('veicNovos='+RemoverTag('veicNovos',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<chassi>') = True) then Memo2.Lines.Add('chassi='+RemoverTag('chassi',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<cCor>') = True) then Memo2.Lines.Add('cCor='+RemoverTag('cCor',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xCor>') = True) then Memo2.Lines.Add('xCor='+RemoverTag('xCor',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<cMod>') = True) then Memo2.Lines.Add('cMod='+RemoverTag('cMod',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vUnit>') = True) then Memo2.Lines.Add('vUnit='+RemoverTag('vUnit',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vFrete>') = True) then Memo2.Lines.Add('vFrete='+RemoverTag('vFrete',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<cobr>') = True) then Memo2.Lines.Add('cobr='+RemoverTag('cobr',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<fat>') = True) then Memo2.Lines.Add('fat='+RemoverTag('fat',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nFat>') = True) then Memo2.Lines.Add('nFat='+RemoverTag('nFat',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vOrig>') = True) then Memo2.Lines.Add('vOrig='+RemoverTag('vOrig',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vDesc>') = True) then Memo2.Lines.Add('vDesc='+RemoverTag('vDesc',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vLiq>') = True) then Memo2.Lines.Add('vLiq='+RemoverTag('vLiq',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<dup>') = True) then Memo2.Lines.Add('dup='+RemoverTag('dup',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nDup>') = True) then Memo2.Lines.Add('nDup='+RemoverTag('nDup',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<dVenc>') = True) then Memo2.Lines.Add('dVenc='+RemoverTag('dVenc',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<vDuq>') = True) then Memo2.Lines.Add('vDuq='+RemoverTag('vDuq',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<infCteSub>') = True) then Memo2.Lines.Add('infCteSub='+RemoverTag('infCteSub',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<chCte>') = True) then Memo2.Lines.Add('chCte='+RemoverTag('chCte',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<tomaICMS>') = True) then Memo2.Lines.Add('tomaICMS='+RemoverTag('tomaICMS',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<refNFe>') = True) then Memo2.Lines.Add('refNFe='+RemoverTag('refNFe',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<refNF>') = True) then Memo2.Lines.Add('refNF='+RemoverTag('refNF',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CNPJ>') = True) then Memo2.Lines.Add('CNPJ='+RemoverTag('CNPJ',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CPF>') = True) then Memo2.Lines.Add('CPF='+RemoverTag('CPF',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<mod>') = True) then Memo2.Lines.Add('mod='+RemoverTag('mod',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<serie>') = True) then Memo2.Lines.Add('serie='+RemoverTag('serie',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<subserie>') = True) then Memo2.Lines.Add('subserie='+RemoverTag('subserie',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<nro>') = True) then Memo2.Lines.Add('nro='+RemoverTag('nro',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<valor>') = True) then Memo2.Lines.Add('valor='+RemoverTag('valor',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<dEmi>') = True) then Memo2.Lines.Add('dEmi='+RemoverTag('dEmi',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<refCte>') = True) then Memo2.Lines.Add('refCte='+RemoverTag('refCte',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<refCteAnu>') = True) then Memo2.Lines.Add('refCteAnu='+RemoverTag('refCteAnu',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<indAlteraToma>') = True) then Memo2.Lines.Add('indAlteraToma='+RemoverTag('indAlteraToma',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<infCteComp>') = True) then Memo2.Lines.Add('infCteComp='+RemoverTag('infCteComp',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<chCTe>') = True) then Memo2.Lines.Add('chCTe='+RemoverTag('chCTe',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<infCteAnu>') = True) then Memo2.Lines.Add('infCteAnu='+RemoverTag('infCteAnu',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<chCte>') = True) then Memo2.Lines.Add('chCte='+RemoverTag('chCte',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<dEmi>') = True) then Memo2.Lines.Add('dEmi='+RemoverTag('dEmi',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<autXML>') = True) then Memo2.Lines.Add('autXML='+RemoverTag('autXML',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CNPJ>') = True) then Memo2.Lines.Add('CNPJ='+RemoverTag('CNPJ',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<CPF>') = True) then Memo2.Lines.Add('CPF='+RemoverTag('CPF',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<dadosAdic>') = True) then Memo2.Lines.Add('dadosAdic='+RemoverTag('dadosAdic',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<B2B>') = True) then Memo2.Lines.Add('B2B='+RemoverTag('B2B',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<type>') = True) then Memo2.Lines.Add('type='+RemoverTag('type',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<PIN>') = True) then Memo2.Lines.Add('PIN='+RemoverTag('PIN',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<tpUnidTranssp>') = True) then Memo2.Lines.Add('tpUnidTranssp='+RemoverTag('tpUnidTranssp',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<dPrev>') = True) then Memo2.Lines.Add('dPrev='+RemoverTag('dPrev',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<infGlobalizado>') = True) then Memo2.Lines.Add('infGlobalizado='+RemoverTag('infGlobalizado',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<xObs>') = True) then Memo2.Lines.Add('xObs_1413='+RemoverTag('xObs',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<infServVinc>') = True) then Memo2.Lines.Add('infServVinc='+RemoverTag('infServVinc',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<infCTeMultimodal>') = True) then Memo2.Lines.Add('infCTeMultimodal='+RemoverTag('infCTeMultimodal',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<chCTeMultimodal>') = True) then Memo2.Lines.Add('ChCTeMultimodal_1415='+RemoverTag('chCTeMultimodal',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<infCTeSupl>') = True) then Memo2.Lines.Add('infCTeSupl='+RemoverTag('infCTeSupl',memo1.Lines.Strings[i]));
    if (Memo1.Lines.Strings[i].Contains('<qrCodCTe>') = True) then Memo2.Lines.Add('qrCodCTe='+RemoverTag('qrCodCTe',memo1.Lines.Strings[i]));

  end;


end;

procedure TForm1.tx2MDFe;
var
 i:integer;
 m: string;
begin

  for i := 0 to Pred(Memo1.Lines.Count) do
  begin
    if (Memo1.Lines.Strings[i].Contains('<infMDFe ') = True) then Memo2.Lines.Add('incluirMDFe');
  end;
end;
end.
