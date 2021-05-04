unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc, MSXML,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    XMLDocument1: TXMLDocument;
    BtnText: TButton;
    Memo2: TMemo;
    BtnConverter: TButton;
    EdtXml: TLabeledEdit;
    BtnExemplotx2: TButton;
    BtnNodexmlCTE: TButton;
    BtnNodexmlMDFe: TButton;
    procedure BtnTextClick(Sender: TObject);
    procedure BtnConverterClick(Sender: TObject);
    procedure tx2Cte;
    procedure tx2MDFe;
    procedure BtnExemplotx2Click(Sender: TObject);
    procedure BtnNodexmlCTEClick(Sender: TObject);
    procedure BtnNodexmlMDFeClick(Sender: TObject);
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


procedure TForm1.BtnExemplotx2Click(Sender: TObject);
var
 i:integer;
begin
//  for i := 0 to Pred(Memo1.Lines.Count) do
//  begin

    Memo2.Lines.Clear;
    Memo2.Lines.Add('Formato=TX2');

    Memo2.Lines.Add('incluirenviCTe');
    Memo2.Lines.Add('idLote=9996');
    Memo2.Lines.Add('versao=3.00');
    Memo2.Lines.Add('salvarenviCTe');

  {

    if (Memo1.Lines.Strings[i].Contains('<cDV>') = True) then Memo2.Lines.Add('cDV_16='+RemoverTag('cDV',memo1.Lines.Strings[i]));

  }


    Memo2.Lines.Add('');

    if (Memo1.Lines.Strings[i].Contains('<infCte ') = True) then Memo2.Lines.Add('incluirCTe'); //Memo2.Lines.Add('incluirCTe');
    if (Memo1.Lines.Strings[i].Contains('versao=') = True) then Memo2.Lines.Add('versao_2=3.00'); //Memo2.Lines.Add('versao_2=3.00');
    if (Memo1.Lines.Strings[i].Contains('<cUF>') = True) then Memo2.Lines.Add('cUF_5='+RemoverTag('cUF',memo1.Lines.Strings[i]));  //Memo2.Lines.Add('cUF_5=43');
    if (Memo1.Lines.Strings[i].Contains('<cCT>') = True) then Memo2.Lines.Add('cCT_6='+RemoverTag('cCT',memo1.Lines.Strings[i])); //Memo2.Lines.Add('cCT_6=00000000');
    if (Memo1.Lines.Strings[i].Contains('<CFOP>') = True) then Memo2.Lines.Add('CFOP_7='+RemoverTag('CFOP',memo1.Lines.Strings[i])); //Memo2.Lines.Add('CFOP_7=5357');
    if (Memo1.Lines.Strings[i].Contains('<natOp>') = True) then Memo2.Lines.Add('natOp_8='+RemoverTag('natOp',memo1.Lines.Strings[i])); //Memo2.Lines.Add('natOp_8=TRANSPORTE RODOVIARIO DE CARGAS');
    if (Memo1.Lines.Strings[i].Contains('<mod>') = True) then Memo2.Lines.Add('mod_10='+RemoverTag('mod',memo1.Lines.Strings[i])); //Memo2.Lines.Add('mod_10=57');
    if (Memo1.Lines.Strings[i].Contains('<serie>') = True) then Memo2.Lines.Add('serie_11='+RemoverTag('serie',memo1.Lines.Strings[i])); //Memo2.Lines.Add('serie_11=579');
    if (Memo1.Lines.Strings[i].Contains('<nCT>') = True) then Memo2.Lines.Add('nCT_12='+RemoverTag('nCT',memo1.Lines.Strings[i])); //Memo2.Lines.Add('nCT_12=10');
    if (Memo1.Lines.Strings[i].Contains('<dhEmi>') = True) then Memo2.Lines.Add('dhEmi_13='+RemoverTag('dhEmi',memo1.Lines.Strings[i])); //Memo2.Lines.Add('dhEmi_13=2018-05-15T08:50:00-03:00');
    if (Memo1.Lines.Strings[i].Contains('<tpImp>') = True) then Memo2.Lines.Add('tpImp_14='+RemoverTag('tpImp',memo1.Lines.Strings[i])); //Memo2.Lines.Add('tpImp_14=1');
    if (Memo1.Lines.Strings[i].Contains('<tpEmis>') = True) then Memo2.Lines.Add('tpEmis_15='+RemoverTag('tpEmis',memo1.Lines.Strings[i])); //Memo2.Lines.Add('tpEmis_15=1');
    if (Memo1.Lines.Strings[i].Contains('<tpAmb>') = True) then Memo2.Lines.Add('tpAmb_17='+RemoverTag('tpAmb',memo1.Lines.Strings[i])); //Memo2.Lines.Add('tpAmb_17=2');
    if (Memo1.Lines.Strings[i].Contains('<tpCTe>') = True) then Memo2.Lines.Add('tpCTe_18='+RemoverTag('tpCTe',memo1.Lines.Strings[i])); //Memo2.Lines.Add('tpCTe_18=0');
    if (Memo1.Lines.Strings[i].Contains('<procEmi>') = True) then Memo2.Lines.Add('procEmi_19='+RemoverTag('tpprocEmiAmb',memo1.Lines.Strings[i])); //Memo2.Lines.Add('procEmi_19=0');
    if (Memo1.Lines.Strings[i].Contains('<verProc>') = True) then Memo2.Lines.Add('verProc_20='+RemoverTag('verProc',memo1.Lines.Strings[i])); //Memo2.Lines.Add('verProc_20=1');
    if (Memo1.Lines.Strings[i].Contains('<cMunEnv>') = True) then Memo2.Lines.Add('cMunEnv_672='+RemoverTag('cMunEnv',memo1.Lines.Strings[i])); //Memo2.Lines.Add('cMunEnv_672=4302105');
    if (Memo1.Lines.Strings[i].Contains('<xMunEnv>') = True) then Memo2.Lines.Add('xMunEnv_673='+RemoverTag('xMunEnv',memo1.Lines.Strings[i])); //Memo2.Lines.Add('xMunEnv_673=BENTO GONCALVES');
    if (Memo1.Lines.Strings[i].Contains('<UFEnv>') = True) then Memo2.Lines.Add('UFEnv_674='+RemoverTag('UFEnv',memo1.Lines.Strings[i])); //Memo2.Lines.Add('UFEnv_674=RS');
    if (Memo1.Lines.Strings[i].Contains('<modal>') = True) then Memo2.Lines.Add('tmodal_25='+RemoverTag('modal',memo1.Lines.Strings[i])); //Memo2.Lines.Add('modal_25=01');
    if (Memo1.Lines.Strings[i].Contains('<tpServ>') = True) then Memo2.Lines.Add('tpServ_26='+RemoverTag('tpServ',memo1.Lines.Strings[i])); //Memo2.Lines.Add('tpServ_26=0');

    Memo2.Lines.Add('');

    if (Memo1.Lines.Strings[i].Contains('<cMunIni>') = True) then Memo2.Lines.Add('cMunIni_27='+RemoverTag('cMunIni',memo1.Lines.Strings[i])); //Memo2.Lines.Add('cMunIni_27=4302105');
    if (Memo1.Lines.Strings[i].Contains('<xMunIni>') = True) then Memo2.Lines.Add('xMunIni_28='+RemoverTag('xMunIni',memo1.Lines.Strings[i])); // Memo2.Lines.Add('xMunIni_28=BENTO GONCALVES');
    if (Memo1.Lines.Strings[i].Contains('<UFIni>') = True) then Memo2.Lines.Add('UFIni_29='+RemoverTag('UFIni',memo1.Lines.Strings[i])); //Memo2.Lines.Add('UFIni_29=RS');
    if (Memo1.Lines.Strings[i].Contains('<cMunFim>') = True) then Memo2.Lines.Add('cMunFim_30='+RemoverTag('cMunFim',memo1.Lines.Strings[i])); //Memo2.Lines.Add('cMunFim_30=4302105');
    Memo2.Lines.Add('xMunFim_31=BENTO GONCALVES');
    Memo2.Lines.Add('UFFim_32=RS');
    Memo2.Lines.Add('retira_33=0');
    Memo2.Lines.Add('toma_38=4');
    Memo2.Lines.Add('xDetRetira_34=detalhes teste');
    Memo2.Lines.Add('indIEToma_1406=1');
    Memo2.Lines.Add('CNPJ_39=99999999999999');
    Memo2.Lines.Add('IE_41=999999999');
    Memo2.Lines.Add('xNome_42=Teste');
    Memo2.Lines.Add('xFant_43=Teste');
    Memo2.Lines.Add('fone_44=9999999999');
    Memo2.Lines.Add('xLgr_46=Rua teste');
    Memo2.Lines.Add('nro_47=10');
    Memo2.Lines.Add('xCPL_48=Complemento Teste');
    Memo2.Lines.Add('xBairro_49=Bairro Teste');
    Memo2.Lines.Add('cMun_50=9999999');
    Memo2.Lines.Add('xMun_51=Teste');
    Memo2.Lines.Add('CEP_52=999999999');
    Memo2.Lines.Add('UF_53=41');
    Memo2.Lines.Add('cPais_54=1058');
    Memo2.Lines.Add('xPais_55=BRASIL');
    Memo2.Lines.Add('Email_601=teste@teste.com.br');
    Memo2.Lines.Add('dhCont_602=2018-05-15T08:50:00-03:00');
    Memo2.Lines.Add('xJust_603=Justificativa Teste');
    Memo2.Lines.Add('xDest_64=123456');
    Memo2.Lines.Add('xRota_65=123456');
    Memo2.Lines.Add('xDest_64=123456');
    Memo2.Lines.Add('xRota_65=123456');
    Memo2.Lines.Add('xDest_64=123456');
    Memo2.Lines.Add('xRota_65=123456');
    Memo2.Lines.Add('CNPJ_95=99999999999999');
    Memo2.Lines.Add('IE_96=99999999999');
    Memo2.Lines.Add('xNome_97=Nome teste');
    Memo2.Lines.Add('xFant_98=Nome teste');
    Memo2.Lines.Add('xLgr_100=Rua teste');
    Memo2.Lines.Add('nro_101=300');
    Memo2.Lines.Add('xCpl_102=10 andar');
    Memo2.Lines.Add('xBairro_103=BAIRRO TESTE');
    Memo2.Lines.Add('cMun_104=4302105');
    Memo2.Lines.Add('xMun_105=BENTO GONCALVES');
    Memo2.Lines.Add('CEP_106=89233198');
    Memo2.Lines.Add('UF_107=RS');
    Memo2.Lines.Add('fone_110=1132433400');
    Memo2.Lines.Add('CNPJ_112=08187168000160');
    Memo2.Lines.Add('IE_114=9044016688');
    Memo2.Lines.Add('xNome_115=CT-E EMITIDO EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL');
    Memo2.Lines.Add('xFant_116=CT-E EMITIDO EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL');
    Memo2.Lines.Add('fone_117=4430283749');
    Memo2.Lines.Add('xLgr_119=RUA DUQUE DE CAXIAS S/N');
    Memo2.Lines.Add('nro_120=0');
    Memo2.Lines.Add('xBairro_122=PARANA');
    Memo2.Lines.Add('cMun_123=4115200');
    Memo2.Lines.Add('xMun_124=PARANA');
    Memo2.Lines.Add('CEP_125=01000000');
    Memo2.Lines.Add('UF_126=PR');
    Memo2.Lines.Add('cPais_127=1058');
    Memo2.Lines.Add('xPais_128=BRASIL');
    Memo2.Lines.Add('email_604=x@tecnospeed.com.br');
    Memo2.Lines.Add('CPF_200=22233344405');
    Memo2.Lines.Add('IE_201=0500048665');
    Memo2.Lines.Add('xNome_202=CT-E EMITIDO EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL');
    Memo2.Lines.Add('xLgr_206=Praca Matriz');
    Memo2.Lines.Add('nro_207=0');
    Memo2.Lines.Add('xBairro_209=Centro');
    Memo2.Lines.Add('cMun_210=4302105');
    Memo2.Lines.Add('xMun_211=BENTO GONCALVES');
    Memo2.Lines.Add('CEP_212=01000000');
    Memo2.Lines.Add('UF_213=RS');
    Memo2.Lines.Add('cPais_214=1058');
    Memo2.Lines.Add('xPais_215=BRASIL');
    Memo2.Lines.Add('email_608=teste.teste@teste.com.br');
    Memo2.Lines.Add('vTPrest_228=200.00');
    Memo2.Lines.Add('vRec_229=200.00');
    Memo2.Lines.Add('CST_609=00');
    Memo2.Lines.Add('vBC_610=0.01');
    Memo2.Lines.Add('pICMS_611=7.00');
    Memo2.Lines.Add('vICMS_612=0.01');
    Memo2.Lines.Add('versaoModal_636=3.00');
    Memo2.Lines.Add('vCarga_671=1000.00');
    Memo2.Lines.Add('proPred_271=LATA');

    Memo2.Lines.Add('');

    Memo2.Lines.Add('vBCUFFim_676=1.10');
    Memo2.Lines.Add('pFCPUFFim_682=1.10');
    Memo2.Lines.Add('pICMSUFFim_677=40');
    Memo2.Lines.Add('pICMSInter_678=12.00');
    Memo2.Lines.Add('vICMSUFFim_680=1.10');
    Memo2.Lines.Add('vICMSUFIni_681=1.10');
    Memo2.Lines.Add('vFCPUFFim_683=1.10');

    Memo2.Lines.Add('');

    Memo2.Lines.Add('salvarCTe');

    Memo2.Lines.Add('');

    Memo2.Lines.Add('incluirpass');
    Memo2.Lines.Add('xPass_63=123456');
    Memo2.Lines.Add('salvarpass');

    Memo2.Lines.Add('');

    Memo2.Lines.Add('incluirpass');
    Memo2.Lines.Add('xPass_63=123456');
    Memo2.Lines.Add('salvarpass');

    Memo2.Lines.Add('');

    Memo2.Lines.Add('incluirpass');
    Memo2.Lines.Add('xPass_63=123456');
    Memo2.Lines.Add('salvarpass');

    Memo2.Lines.Add('');

    Memo2.Lines.Add('incluirinfOutros');
    Memo2.Lines.Add('tpDoc_159=00');
    Memo2.Lines.Add('nDoc_161=123456');
    Memo2.Lines.Add('dEmi_162=2011-03-22');
    Memo2.Lines.Add('vDocFisc_163=1.00');
    Memo2.Lines.Add('incluirinfUnidCarga');
    Memo2.Lines.Add('tpUnidCarga_810=1');
    Memo2.Lines.Add('idUnidCarga_811=1');
    Memo2.Lines.Add('salvarinfUnidCarga');
    Memo2.Lines.Add('salvarinfOutros');

    Memo2.Lines.Add('');

    Memo2.Lines.Add('incluirinfQ');
    Memo2.Lines.Add('cUnid_274=00');
    Memo2.Lines.Add('tpMed_275=m3');
    Memo2.Lines.Add('qCarga_276=1');
    Memo2.Lines.Add('salvarinfQ');

    Memo2.Lines.Add('');

    Memo2.Lines.Add('IncluirRodo');
    Memo2.Lines.Add('RNTRC_305=00000012');
    Memo2.Lines.Add('SalvarRodo');

    Memo2.Lines.Add('');

    Memo2.Lines.Add('incluirOcc');
    Memo2.Lines.Add('serie_312=1');
    Memo2.Lines.Add('nOcc_313=1');
    Memo2.Lines.Add('dEmi_314=2018-05-15');
    Memo2.Lines.Add('CNPJ_316=08187168000160');
    Memo2.Lines.Add('cInt_317=10');
    Memo2.Lines.Add('IE_318=0500077436');
    Memo2.Lines.Add('UF_319=PR');
    Memo2.Lines.Add('fone_320=99999999');
    Memo2.Lines.Add('salvarOcc');

  end;


procedure TForm1.BtnNodexmlCTEClick(Sender: TObject);
var
  nodeInfCTe, nodeIde, nodeemit, noderem, nodereceb, nodedest, nodeenderEmit, nodeenderReme,
  nodeenderDest, nodeenderReceb, nodetoma, nodecompl, nodevPrest, nodeComp, nodeimp, nodeICMS,
  nodeimpInfCTe, nodeinfCteComp, nodeautXML, nodeinfCTeSupl, nodeObsCont, nodeinfCTeNorm,
  nodeinfCargaMDFe, nodeinfDocMDFe, nodeinfQMDFe, nodeinfDoc, nodeinfNFeMDFe, nodeinfModal,
  noderodo, nodeaquav,nodeenderToma : IXMLNode;
  i,e, f: Integer;
begin
  Memo2.Lines.Clear;
  XMLDocument1.LoadFromFile(EdtXml.Text);
  XMLDocument1.Active := True;

  nodeInfCTe := XMLDocument1.ChildNodes.FindNode('CTe').ChildNodes.FindNode('infCte');
  nodeIde := nodeInfCTe.ChildNodes.FindNode('ide');



  Memo2.Lines.Clear;
//  Memo2.Lines.Add('Formato=TX2');
//  Memo2.Lines.Add('incluirenviCTe');
//  Memo2.Lines.Add('idLote=9996');
//  Memo2.Lines.Add('versao=3.00');
//  Memo2.Lines.Add('salvarenviCTe');


//  node ide*****************************************************************************************
  Memo2.Lines.Add('Inicio  <ide> incluirCTe');
  for i := 0 to nodeIde.ChildNodes.Count-1 do
  begin
    if (nodeIde.ChildNodes[i].NodeName = 'toma3') then
    begin
      if not (nodeIde.ChildNodes.FindNode('toma3') = nil) then
      begin
        Memo2.Lines.Add('    Inicio  <toma3>');
        nodetoma := nodeIde.ChildNodes.FindNode('toma3');
        for e := 0 to nodetoma.ChildNodes.Count-1 do
          Memo2.Lines.Add('          '+nodetoma.ChildNodes[e].NodeName+' = '+nodetoma.ChildNodes[e].Text);
        Memo2.Lines.Add('    Fim  <toma3>');
      end
    end
    else
    if (nodeIde.ChildNodes[i].NodeName = 'toma4') then
    begin
      if not (nodeIde.ChildNodes.FindNode('toma4') = nil) then
      begin
        Memo2.Lines.Add('    Inicio  <toma4>');
        nodetoma := nodeIde.ChildNodes.FindNode('toma4');
        for e := 0 to nodetoma.ChildNodes.Count-1 do
        begin
          if (nodetoma.ChildNodes[e].NodeName <> 'enderToma') then
            Memo2.Lines.Add('          '+nodetoma.ChildNodes[e].NodeName+' = '+nodetoma.ChildNodes[e].Text)
            else
            begin
              nodeenderToma := nodetoma.ChildNodes.FindNode('enderToma');
              Memo2.Lines.Add('         Inicio  <enderToma>');
              for f := 0 to nodeenderToma.ChildNodes.Count-1 do
                Memo2.Lines.Add('               '+nodeenderToma.ChildNodes[f].NodeName+' = '+nodeenderToma.ChildNodes[f].Text);
              Memo2.Lines.Add('         Fim  </enderToma>');
          end;
        end;
        Memo2.Lines.Add('    Fim  </toma4>');
      end;
    end
    else
      Memo2.Lines.Add('     '+ nodeIde.ChildNodes[i].NodeName+' = '+nodeIde.ChildNodes[i].Text)
  end;
  Memo2.Lines.Add('Fim  </ide> SalvarCTe');

//  node ide*****************************************************************************************

//  node compl*****************************************************************************************
   nodecompl := nodeInfCTe.ChildNodes.FindNode('compl');
   Memo2.Lines.Add('Inicio  <compl>');
   for i := 0 to nodecompl.ChildNodes.Count-1 do
     if not (nodecompl = nil) then
       if (nodecompl.ChildNodes[i].NodeName <> 'ObsCont') then
         Memo2.Lines.Add('     '+ nodecompl.ChildNodes[i].NodeName+' = '+nodecompl.ChildNodes[i].Text)
       else
       begin
         nodeObsCont := nodecompl.ChildNodes.FindNode('ObsCont');
         if not (nodeObsCont = nil) then
         repeat
           if not (nodeObsCont = nil) then
           begin
             Memo2.Lines.Add('      <ObsCont>');
             for e := 0 to nodeObsCont.ChildNodes.Count-1 do
                Memo2.Lines.Add('          '+nodeObsCont.ChildNodes[e].NodeName+' = '+nodeObsCont.ChildNodes[e].Text);

             Memo2.Lines.Add('      </ObsCont>');
             nodeObsCont := nodeObsCont.NextSibling;
           end;
          nodecompl := nodecompl.NextSibling;
         until nodecompl = nil ;
       end;
   Memo2.Lines.Add('    Fim  </compl> ');
//  node compl*****************************************************************************************



//  node emit*****************************************************************************************
  nodeemit := nodeInfCTe.ChildNodes.FindNode('emit');
  Memo2.Lines.Add('Inicio  <emit>');
  for i := 0 to nodeemit.ChildNodes.Count-1 do
  begin
    if (nodeemit.ChildNodes[i].NodeName <> 'enderEmit') then
      Memo2.Lines.Add('     '+ nodeemit.ChildNodes[i].NodeName+' = '+nodeemit.ChildNodes[i].Text)
    else
    begin
      Memo2.Lines.Add('    Inicio  <enderEmit>');
      nodeenderEmit := nodeemit.ChildNodes.FindNode('enderEmit');
      for e := 0 to nodeenderEmit.ChildNodes.Count-1 do
        Memo2.Lines.Add('          '+nodeenderEmit.ChildNodes[e].NodeName+' = '+nodeenderEmit.ChildNodes[e].Text);
      Memo2.Lines.Add('    Fim  </enderEmit>');
    end;
  end;
  Memo2.Lines.Add('Fim  </emit>');
//  node emit*****************************************************************************************


//  node rem*****************************************************************************************
  noderem := nodeInfCTe.ChildNodes.FindNode('rem');
  Memo2.Lines.Add('Inicio  <rem>');
  for i := 0 to noderem.ChildNodes.Count-1 do
  begin
    if (noderem.ChildNodes[i].NodeName <> 'enderReme') then
      Memo2.Lines.Add('     '+ noderem.ChildNodes[i].NodeName+' = '+noderem.ChildNodes[i].Text)
    else
    begin
       Memo2.Lines.Add('    Inicio  <enderReme>');
       nodeenderReme := noderem.ChildNodes.FindNode('enderReme');
       for e := 0 to nodeenderReme.ChildNodes.Count-1 do
         Memo2.Lines.Add('          '+nodeenderReme.ChildNodes[e].NodeName+' = '+nodeenderReme.ChildNodes[e].Text);
       Memo2.Lines.Add('    Fim  </enderReme>');
    end;
  end;
  Memo2.Lines.Add('Fim  </rem>');
//  node rem*****************************************************************************************


//  node receb*****************************************************************************************
   nodereceb := nodeInfCTe.ChildNodes.FindNode('receb');
   if not (nodereceb = nil) then
   begin
     Memo2.Lines.Add('Inicio  <receb>');
     for i := 0 to nodereceb.ChildNodes.Count-1 do
     begin
       if (nodereceb.ChildNodes[i].NodeName <> 'enderReceb') then
        Memo2.Lines.Add('     '+ nodereceb.ChildNodes[i].NodeName+' = '+nodereceb.ChildNodes[i].Text)
       else
       begin
         Memo2.Lines.Add('    Inicio  <enderReceb>');
         nodeenderReceb := nodereceb.ChildNodes.FindNode('enderReceb');
         for e := 0 to nodeenderReceb.ChildNodes.Count-1 do
         Memo2.Lines.Add('          '+nodeenderReceb.ChildNodes[e].NodeName+' = '+nodeenderReceb.ChildNodes[e].Text);
         Memo2.Lines.Add('    Fim  </enderReceb>');
       end;
     end;
     Memo2.Lines.Add('Fim  </receb>');
   end;
//  node receb*****************************************************************************************


//  node dest*****************************************************************************************
    nodedest := nodeInfCTe.ChildNodes.FindNode('dest');
    Memo2.Lines.Add('Inicio  <dest>');
    for i := 0 to nodedest.ChildNodes.Count-1 do
    begin
      if (nodedest.ChildNodes[i].NodeName <> 'enderDest') then
         Memo2.Lines.Add('     '+ nodedest.ChildNodes[i].NodeName+' = '+nodedest.ChildNodes[i].Text)
      else
      begin
        Memo2.Lines.Add('    Inicio  <enderDest>');
        nodeenderDest := nodedest.ChildNodes.FindNode('enderDest');
        for e := 0 to nodeenderDest.ChildNodes.Count-1 do
          Memo2.Lines.Add('          '+nodeenderDest.ChildNodes[e].NodeName+' = '+nodeenderDest.ChildNodes[e].Text);
        Memo2.Lines.Add('    Fim  </enderDest>');
      end;
    end;
    Memo2.Lines.Add('Fim  </dest>');
//  node dest*****************************************************************************************



//  node vPrest*****************************************************************************************
    nodevPrest := nodeInfCTe.ChildNodes.FindNode('vPrest');
   Memo2.Lines.Add('Inicio  <vPrest>');
   for i := 0 to nodevPrest.ChildNodes.Count-1 do
     if not (nodevPrest = nil) then
       if (nodevPrest.ChildNodes[i].NodeName <> 'Comp') then
         Memo2.Lines.Add('     '+ nodevPrest.ChildNodes[i].NodeName+' = '+nodevPrest.ChildNodes[i].Text)
       else
       begin
         nodeComp := nodevPrest.ChildNodes.FindNode('Comp');
         if not (nodeComp = nil) then
         repeat
           if not (nodeComp = nil) then
           begin
             Memo2.Lines.Add('      <Comp>');
             for e := 0 to nodeComp.ChildNodes.Count-1 do
                Memo2.Lines.Add('          '+nodeComp.ChildNodes[e].NodeName+' = '+nodeComp.ChildNodes[e].Text);

             Memo2.Lines.Add('      </Comp>');
             nodeComp := nodeComp.NextSibling;
           end;
          nodevPrest := nodevPrest.NextSibling;
         until nodevPrest = nil ;
       end;
   Memo2.Lines.Add('    Fim  </vPrest> ');
//  node vPrest*****************************************************************************************


//  node imp********************************************************************************************

  if not (nodeinfCte.ChildNodes.FindNode('imp') = nil) then
  begin
    nodeimpInfCTe := nodeinfCte.ChildNodes.FindNode('imp').ChildNodes.FindNode('ICMS');
    Memo2.Lines.Add('Inicio  <imp> ');
    Memo2.Lines.Add('    Inicio  <ICMS> ');

    if not (nodeimpInfCTe.ChildNodes.FindNode('ICMS00') = nil) then
    begin
      nodeICMS := nodeimpInfCTe.ChildNodes.FindNode('ICMS00');
      Memo2.Lines.Add('      Inicio  <ICMS00>');
      for i := 0 to nodeICMS.ChildNodes.Count-1 do
      begin
        if (nodeICMS.ChildNodes[i].NodeName <> 'ICMS00') then
         Memo2.Lines.Add('         '+ nodeICMS.ChildNodes[i].NodeName+' = '+nodeICMS.ChildNodes[i].Text)
        else
      end;
      Memo2.Lines.Add('      Inicio  </ICMS00>');
    end
    else
    if not (nodeimpInfCTe.ChildNodes.FindNode('ICMS20') = nil) then
    begin
      nodeICMS := nodeimpInfCTe.ChildNodes.FindNode('ICMS20');
      Memo2.Lines.Add('      Inicio  <ICMS20>');
      for i := 0 to nodeICMS.ChildNodes.Count-1 do
      begin
        if (nodeICMS.ChildNodes[i].NodeName <> 'ICMS20') then
         Memo2.Lines.Add('          '+ nodeICMS.ChildNodes[i].NodeName+' = '+nodeICMS.ChildNodes[i].Text)
        else
      end;
      Memo2.Lines.Add('      Inicio  </ICMS20>');
    end
    else
    if not (nodeimpInfCTe.ChildNodes.FindNode('ICMS45') = nil) then
    begin
      nodeICMS := nodeimpInfCTe.ChildNodes.FindNode('ICMS45');
      Memo2.Lines.Add('      Inicio  <ICMS45>');
      for i := 0 to nodeICMS.ChildNodes.Count-1 do
      begin
        if (nodeICMS.ChildNodes[i].NodeName <> 'ICMS45') then
         Memo2.Lines.Add('          '+ nodeICMS.ChildNodes[i].NodeName+' = '+nodeICMS.ChildNodes[i].Text)
        else
      end;
      Memo2.Lines.Add('      Inicio  </ICMS45>');
    end
    else
    if not (nodeimpInfCTe.ChildNodes.FindNode('ICMS60') = nil) then
    begin
      nodeICMS := nodeimpInfCTe.ChildNodes.FindNode('ICMS60');
      Memo2.Lines.Add('      Inicio  <ICMS60>');
      for i := 0 to nodeICMS.ChildNodes.Count-1 do
      begin
        if (nodeICMS.ChildNodes[i].NodeName <> 'ICMS60') then
         Memo2.Lines.Add('          '+ nodeICMS.ChildNodes[i].NodeName+' = '+nodeICMS.ChildNodes[i].Text)
        else
      end;
      Memo2.Lines.Add('      Inicio  </ICMS60>');
    end
    else
    if not (nodeimpInfCTe.ChildNodes.FindNode('ICMSSN') = nil) then
    begin
      nodeICMS := nodeimpInfCTe.ChildNodes.FindNode('ICMSSN');
      Memo2.Lines.Add('      Inicio  <ICMSSN>');
      for i := 0 to nodeICMS.ChildNodes.Count-1 do
      begin
        if (nodeICMS.ChildNodes[i].NodeName <> 'ICMSSN') then
         Memo2.Lines.Add('          '+ nodeICMS.ChildNodes[i].NodeName+' = '+nodeICMS.ChildNodes[i].Text)
        else
      end;
      Memo2.Lines.Add('      Inicio  </ICMSSN>');
    end
    else

    if not (nodeimpInfCTe.ChildNodes.FindNode('ICMSOutraUF') = nil) then
    begin
      nodeICMS := nodeimpInfCTe.ChildNodes.FindNode('ICMSOutraUF');
      Memo2.Lines.Add('      Inicio    <ICMSOutraUF>');
      for i := 0 to nodeICMS.ChildNodes.Count-1 do
      begin
        if (nodeICMS.ChildNodes[i].NodeName <> 'ICMSOutraUF') then
         Memo2.Lines.Add('         '+ nodeICMS.ChildNodes[i].NodeName+' = '+nodeICMS.ChildNodes[i].Text)
        else
      end;
      Memo2.Lines.Add('      Fim      </ICMSOutraUF>');
    end;
    Memo2.Lines.Add('    Fim  <ICMS> ');
    Memo2.Lines.Add('Fim  <imp> ');
  end;
//  node imp**************************************************************************************************

//  node infCTeNorm**************************************************************************************************

   if not (nodeinfCte.ChildNodes.FindNode('infCTeNorm') = nil) then
   begin
   nodeinfCTeNorm := nodeinfCte.ChildNodes.FindNode('infCTeNorm');
     Memo2.Lines.Add('Inicio  <infCTeNorm>');
     for i := 0 to nodeinfCTeNorm.ChildNodes.Count-1 do
     begin
       if (nodeinfCTeNorm.ChildNodes[i].NodeName = 'infCarga') then
       begin
         Memo2.Lines.Add('    Inicio  <infCarga>');
         nodeinfCargaMDFe := nodeinfCTeNorm.ChildNodes.FindNode('infCarga');
         for e := 0 to nodeinfCargaMDFe.ChildNodes.Count-1 do
         begin
           if not (nodeinfCargaMDFe = nil) then
             if (nodeinfCargaMDFe.ChildNodes[e].NodeName <> 'infQ') then
               Memo2.Lines.Add('          '+nodeinfCargaMDFe.ChildNodes[e].NodeName+' = '+nodeinfCargaMDFe.ChildNodes[e].Text)
             else
             begin
               nodeinfQMDFe := nodeinfCargaMDFe.ChildNodes.FindNode('infQ');
               if not (nodeinfQMDFe = nil) then
               repeat
                 if not (nodeinfQMDFe = nil) then
                 begin
                   Memo2.Lines.Add('         Inicio  <infQ>');
                   for f := 0 to nodeinfQMDFe.ChildNodes.Count-1 do
                     Memo2.Lines.Add('                '+nodeinfQMDFe.ChildNodes[f].NodeName+' = '+nodeinfQMDFe.ChildNodes[f].Text);
                   Memo2.Lines.Add('         Fim </infQ>');
                   nodeinfQMDFe := nodeinfQMDFe.NextSibling;
                   if not (nodeinfCargaMDFe = nil) then
                      nodeinfCargaMDFe := nodeinfCargaMDFe.NextSibling;
                 end;
                 if not (nodeinfCargaMDFe = nil) then
                   nodeinfCargaMDFe := nodeinfCargaMDFe.NextSibling;
               until nodeinfQMDFe = nil;
            end;
          end;
          Memo2.Lines.Add('    Fim  </infCarga>');
       end
       else
       if (nodeinfCTeNorm.ChildNodes[i].NodeName = 'infDoc') then
       begin
         nodeinfDoc := nodeinfCTeNorm.ChildNodes.FindNode('infDoc');
         if not (nodeinfDoc = nil) then
         begin
           Memo2.Lines.Add('    Inicio  <infDoc>');
           for e := 0 to nodeinfDoc.ChildNodes.Count-1 do
           begin
             if not (nodeinfDoc = nil) then
             begin
             nodeinfNFeMDFe := nodeinfDoc.ChildNodes.FindNode('infNFe');
               repeat
                 if not (nodeinfNFeMDFe = nil) then
                 begin
                   for f := 0 to nodeinfNFeMDFe.ChildNodes.Count-1 do
                   begin
                     Memo2.Lines.Add('         Inicio  <infNFe>');
                     Memo2.Lines.Add('               '+nodeinfNFeMDFe.ChildNodes[f].NodeName+' = '+nodeinfNFeMDFe.ChildNodes[f].Text);
                     Memo2.Lines.Add('         Fim  </infNFe>');
                   end;
                   nodeinfNFeMDFe := nodeinfNFeMDFe.NextSibling;
                 end;
               until nodeinfNFeMDFe = nil;
               nodeinfDoc := nodeinfDoc.NextSibling;
             end;
           end;
         end;
         Memo2.Lines.Add('    Fim  </infDoc>');
       end
       else if (nodeinfCTeNorm.ChildNodes[i].NodeName = 'infModal') then
       begin
         if not (nodeinfCTeNorm.ChildNodes.FindNode('infModal') = nil) then
         begin
           nodeinfModal := nodeinfCTeNorm.ChildNodes.FindNode('infModal');
           if not (nodeinfModal = nil) then
           begin
             Memo2.Lines.Add('    Inicio  <infModal>');
             if not (nodeinfModal.ChildNodes.FindNode('rodo') = nil) then
               begin
               noderodo := nodeinfModal.ChildNodes.FindNode('rodo');
               if not (noderodo = nil) then
               begin
                 Memo2.Lines.Add('        Inicio  <rodo>');
                 for e := 0 to noderodo.ChildNodes.Count-1 do
                 begin
                   Memo2.Lines.Add('              '+noderodo.ChildNodes[e].NodeName+' = '+noderodo.ChildNodes[e].Text);
                 end;
                 Memo2.Lines.Add('        Fim  </rodo>');
               end;
             end
             else
             if not (nodeinfModal.ChildNodes.FindNode('aquav') = nil) then
             begin
               nodeaquav := nodeinfModal.ChildNodes.FindNode('aquav');
               if not (nodeaquav = nil) then
               begin
                 Memo2.Lines.Add('        Inicio  <aquav>');
                 for e := 0 to nodeaquav.ChildNodes.Count-1 do
                 begin
                   Memo2.Lines.Add('              '+nodeaquav.ChildNodes[e].NodeName+' = '+nodeaquav.ChildNodes[e].Text);
                 end;
                 Memo2.Lines.Add('        Fim  </aquav>');
               end;
             end;
             Memo2.Lines.Add('    Fim  </infModal>');
           end;
         end;
       end;
     end;
     Memo2.Lines.Add('Fim  </infCTeNorm>');
   end;
//  node infCTeNorm**************************************************************************************************

      {
//  node infCteComp*******************************************************************************************
    nodeinfCteComp := nodeinfCte.ChildNodes.FindNode('infCteComp');
    if not (nodeinfCteComp = nil) then
    begin
      Memo2.Lines.Add('Inicio  <infCteComp>');
      for i := 0 to nodeinfCteComp.ChildNodes.Count-1 do
      begin
         if (nodeinfCteComp.ChildNodes[i].NodeName <> 'infCteComp') then
          Memo2.Lines.Add('     '+ nodeinfCteComp.ChildNodes[i].NodeName+' = '+nodeinfCteComp.ChildNodes[i].Text)
         else
      end;
      Memo2.Lines.Add('Fim  </infCteComp>');
    end;
//  node infCteComp*******************************************************************************************

//  node autXML**********************************************************************************************
   nodeautXML := nodeinfCte.ChildNodes.FindNode('autXML');
    Memo2.Lines.Add('Inicio  <autXML>');
    for i := 0 to nodeautXML.ChildNodes.Count-1 do
    begin
       if (nodeautXML.ChildNodes[i].NodeName <> 'autXML') then
        Memo2.Lines.Add('     '+ nodeautXML.ChildNodes[i].NodeName+' = '+nodeautXML.ChildNodes[i].Text)
       else
    end;
    Memo2.Lines.Add('   Fim  </autXML>');
    Memo2.Lines.Add('Fim  </infCte>');
//  node autXML*******************************************************************************************

//  node infCTeSupl*******************************************************************************************
   nodeinfCTeSupl := XMLDocument1.ChildNodes.FindNode('CTe').ChildNodes.FindNode('infCTeSupl');
    Memo2.Lines.Add('Inicio  <infCTeSupl>');
    for i := 0 to nodeinfCTeSupl.ChildNodes.Count-1 do
    begin
       if (nodeinfCTeSupl.ChildNodes[i].NodeName <> 'infCTeSupl') then
        Memo2.Lines.Add('     '+ nodeinfCTeSupl.ChildNodes[i].NodeName+' = '+nodeinfCTeSupl.ChildNodes[i].Text)
       else
    end;
    Memo2.Lines.Add('   Fim  </infCTeSupl>');
    Memo2.Lines.Add('Fim  </Cte>');
//  node infCTeSupl*******************************************************************************************
                           }


  Memo2.Lines.Add(' ');
  Memo2.Lines.Add(' ');
  Memo2.Lines.Add('-------------------------------------------------');


//  Memo2.Lines.Add('incluirpass');
//      {Falta colocar as tags}
//  Memo2.Lines.Add('Salvarpass');

//  Memo2.Lines.Add('incluirinfOutros');
//     {Falta colocar as tags}
//  Memo2.Lines.Add('salvarinfOutros');

//  Memo2.Lines.Add('incluirinfQ');
    {Falta colocar as tags}
//  Memo2.Lines.Add('salvarinfQ');

//  Memo2.Lines.Add('IncluirRodo');
   {Falta colocar as tags}
//  Memo2.Lines.Add('SalvarRodo');

//  Memo2.Lines.Add('incluirOcc');
   {Falta colocar as tags}
//  Memo2.Lines.Add('salvarOcc');}










end;

procedure TForm1.BtnNodexmlMDFeClick(Sender: TObject);

var
  nodeinfMDFe, nodeIdeMDFe, infMunCarregaMDFe, nodeemitMDFe, enderEmitMDFe, noderodoMDFe, nodeinfANTTMDFe, nodeveicTracaoMDFe,
  nodeinfContratanteMDFe, nodepropMDFe, nodeprop1MDFe, nodecondutorMDFe, nodeveicReboqueMDFe, nodeinfDocMDFe, nodeinfMunDescargaMDFe,
  nodeinfCTeMDFe, nodeseg, nodeinfResp, nodeinfSeg, nodetot, nodeautXML, nodeinfMDFeSupl  : IXMLNode ;
  i, e, f: Integer;

begin
  Memo2.Lines.Clear;
//  XMLDocument1.LoadFromFile(EdtXml.Text);
  XMLDocument1.LoadFromFile('C:\gabriel\XMLs\Exemplo_MDFe.xml');
  XMLDocument1.Active := True;

  nodeinfMDFe := XMLDocument1.ChildNodes.FindNode('MDFe').ChildNodes.FindNode('infMDFe');
  nodeIdeMDFe := nodeinfMDFe.ChildNodes.FindNode('ide');


//   node ide*****************************************************************************************
  Memo2.Lines.Add('Inicio  <ide> incluirMDFe');
  for i := 0 to nodeIdeMDFe.ChildNodes.Count-1 do
  begin
    if (nodeIdeMDFe.ChildNodes[i].NodeName <> 'infMunCarrega') then
     Memo2.Lines.Add('     '+ nodeIdeMDFe.ChildNodes[i].NodeName+' = '+nodeIdeMDFe.ChildNodes[i].Text)
    else
    begin
      Memo2.Lines.Add('    Inicio  <infMunCarrega>');
      infMunCarregaMDFe := nodeIdeMDFe.ChildNodes.FindNode('infMunCarrega');
      for e := 0 to infMunCarregaMDFe.ChildNodes.Count-1 do
      Memo2.Lines.Add('          '+infMunCarregaMDFe.ChildNodes[e].NodeName+' = '+infMunCarregaMDFe.ChildNodes[e].Text);
      Memo2.Lines.Add('    Fim  <infMunCarrega>');
    end;
  end;
  Memo2.Lines.Add('Fim  </ide> SalvarMDFe');
//   node ide*****************************************************************************************


//   node emit*****************************************************************************************
   nodeemitMDFe := nodeinfMDFe.ChildNodes.FindNode('emit');
   Memo2.Lines.Add('Inicio  <emit>');
   for i := 0 to nodeemitMDFe.ChildNodes.Count-1 do
   begin
     if (nodeemitMDFe.ChildNodes[i].NodeName <> 'enderEmit') then
      Memo2.Lines.Add('     '+ nodeemitMDFe.ChildNodes[i].NodeName+' = '+nodeemitMDFe.ChildNodes[i].Text)
     else
     begin
         Memo2.Lines.Add('    Inicio  <enderEmit>');
         enderEmitMDFe := nodeemitMDFe.ChildNodes.FindNode('enderEmit');
         for e := 0 to enderEmitMDFe.ChildNodes.Count-1 do
           Memo2.Lines.Add('          '+enderEmitMDFe.ChildNodes[e].NodeName+' = '+enderEmitMDFe.ChildNodes[e].Text);
         Memo2.Lines.Add('    Fim  <enderEmit>');
     end;
   end;
   Memo2.Lines.Add('Fim  </emit>');
//   node emit*****************************************************************************************


    noderodoMDFe := nodeinfMDFe.ChildNodes.FindNode('infModal').ChildNodes.FindNode('rodo');
    nodeinfANTTMDFe := noderodoMDFe.ChildNodes.FindNode('infANTT');
    nodeveicTracaoMDFe := noderodoMDFe.ChildNodes.FindNode('veicTracao');
    nodeveicReboqueMDFe := noderodoMDFe.ChildNodes.FindNode('veicReboque');

//   node infModal*****************************************************************************************
   Memo2.Lines.Add('Inicio  <infModal> ');
   Memo2.Lines.Add('  Inicio  <rodo> ');
   Memo2.Lines.Add('    Inicio  <infANTT> ');

   for i := 0 to nodeinfANTTMDFe.ChildNodes.Count-1 do
     if not (nodeinfANTTMDFe = nil) then
       if (nodeinfANTTMDFe.ChildNodes[i].NodeName <> 'infContratante') then
         Memo2.Lines.Add('     '+ nodeinfANTTMDFe.ChildNodes[i].NodeName+' = '+nodeinfANTTMDFe.ChildNodes[i].Text)
       else
       begin
         nodeinfContratanteMDFe := nodeinfANTTMDFe.ChildNodes.FindNode('infContratante');
         if not (nodeinfContratanteMDFe = nil) then
         repeat
           if not (nodeinfContratanteMDFe = nil) then
           begin
             Memo2.Lines.Add('      <infContratante>');
             for e := 0 to nodeinfContratanteMDFe.ChildNodes.Count-1 do
                Memo2.Lines.Add('          '+nodeinfContratanteMDFe.ChildNodes[e].NodeName+' = '+nodeinfContratanteMDFe.ChildNodes[e].Text);

             Memo2.Lines.Add('      </infContratante>');
             nodeinfContratanteMDFe := nodeinfContratanteMDFe.NextSibling;
           end;
          nodeinfANTTMDFe := nodeinfANTTMDFe.NextSibling;
         until nodeinfANTTMDFe = nil ;
       end;
   Memo2.Lines.Add('    Fim  </infANTT> ');
//   node infModal*****************************************************************************************



//   node veicTracao*****************************************************************************************
  nodeveicTracaoMDFe := noderodoMDFe.ChildNodes.FindNode('veicTracao');
  Memo2.Lines.Add('Inicio  <veicTracao>');
  for i := 0 to nodeveicTracaoMDFe.ChildNodes.Count-1 do
  begin
    if (nodeveicTracaoMDFe.ChildNodes[i].NodeName = 'prop') then
    begin
      Memo2.Lines.Add('    Inicio  <prop>');
      nodepropMDFe := nodeveicTracaoMDFe.ChildNodes.FindNode('prop');
      for e := 0 to nodepropMDFe.ChildNodes.Count-1 do
      Memo2.Lines.Add('          '+nodepropMDFe.ChildNodes[e].NodeName+' = '+nodepropMDFe.ChildNodes[e].Text);
      Memo2.Lines.Add('    Fim  </prop>');
    end else
    if (nodeveicTracaoMDFe.ChildNodes[i].NodeName = 'condutor') then
    begin
      Memo2.Lines.Add('    Inicio  <condutor>');
      nodecondutorMDFe := nodeveicTracaoMDFe.ChildNodes.FindNode('condutor');
      for e:= 0 to nodecondutorMDFe.ChildNodes.Count-1 do
      Memo2.Lines.Add('          '+nodecondutorMDFe.ChildNodes[e].NodeName+' = '+nodecondutorMDFe.ChildNodes[e].Text);
      Memo2.Lines.Add('    Fim  </condutor>');
    end else
      Memo2.Lines.Add('     '+ nodeveicTracaoMDFe.ChildNodes[i].NodeName+' = '+nodeveicTracaoMDFe.ChildNodes[i].Text)
  end;

  Memo2.Lines.Add('      Fim </veicTracao>');
//   node veicTracao*****************************************************************************************

//   node veicReboque*****************************************************************************************
     nodeveicReboqueMDFe := noderodoMDFe.ChildNodes.FindNode('veicReboque');
     Memo2.Lines.Add('Inicio  <veicReboque>');
     for i := 0 to nodeveicReboqueMDFe.ChildNodes.Count-1 do
     begin
       if (nodeveicReboqueMDFe.ChildNodes[i].NodeName <> 'prop') then
        Memo2.Lines.Add('     '+ nodeveicReboqueMDFe.ChildNodes[i].NodeName+' = '+nodeveicReboqueMDFe.ChildNodes[i].Text)
       else
       begin
         Memo2.Lines.Add('    Inicio  <prop>');
         nodeprop1MDFe := nodeveicReboqueMDFe.ChildNodes.FindNode('prop');
         for e := 0 to nodeprop1MDFe.ChildNodes.Count-1 do
           Memo2.Lines.Add('          '+nodeprop1MDFe.ChildNodes[e].NodeName+' = '+nodeprop1MDFe.ChildNodes[e].Text);
         Memo2.Lines.Add('    Fim  </prop>');
       end;
     end;
     Memo2.Lines.Add('Inicio  </veicReboque>');
     Memo2.Lines.Add('  Fim</rodo>');
  Memo2.Lines.Add('Fim</infModal>');
//   node veicReboque*****************************************************************************************



//   node infDoc**********************************************************************************************
  nodeinfDocMDFe := nodeinfMDFe.ChildNodes.FindNode('infDoc');
       Memo2.Lines.Add('Inicio  <infDoc>');
       for i := 0 to nodeinfDocMDFe.ChildNodes.Count-1 do
       begin
         if (nodeinfDocMDFe.ChildNodes[i].NodeName <> 'infMunDescarga') then
            Memo2.Lines.Add('     '+ nodeinfDocMDFe.ChildNodes[i].NodeName+' = '+nodeinfDocMDFe.ChildNodes[i].Text)
         else
         begin
            Memo2.Lines.Add('    Inicio  <infMunDescarga>');
            nodeinfMunDescargaMDFe := nodeinfDocMDFe.ChildNodes.FindNode('infMunDescarga');
            for e := 0 to nodeinfMunDescargaMDFe.ChildNodes.Count-1 do
            begin
             if not (nodeinfMunDescargaMDFe = nil) then
               if (nodeinfMunDescargaMDFe.ChildNodes[e].NodeName <> 'infCTe') then
                 Memo2.Lines.Add('          '+nodeinfMunDescargaMDFe.ChildNodes[e].NodeName+' = '+nodeinfMunDescargaMDFe.ChildNodes[e].Text)
               else
               begin
                 nodeinfCTeMDFe := nodeinfMunDescargaMDFe.ChildNodes.FindNode('infCTe');
                 if not (nodeinfCTeMDFe = nil) then
                 repeat
                   if not (nodeinfCTeMDFe = nil) then
                   begin
                     Memo2.Lines.Add('    Inicio  <infCTe>');
                     for f := 0 to nodeinfCTeMDFe.ChildNodes.Count-1 do
                       Memo2.Lines.Add('          '+nodeinfCTeMDFe.ChildNodes[f].NodeName+' = '+nodeinfCTeMDFe.ChildNodes[f].Text);

                     Memo2.Lines.Add('     Fim </infCTe>');
                     nodeinfCTeMDFe := nodeinfCTeMDFe.NextSibling;
                   end;
                 until nodeinfCTeMDFe = nil;
                 nodeinfMunDescargaMDFe := nodeinfMunDescargaMDFe.NextSibling;
              end;
            end;

         end ;
       end;
       Memo2.Lines.Add('    Fim  </infDoc>');
//   node infDoc**********************************************************************************************


//   node seg**********************************************************************************************
    nodeseg := nodeinfMDFe.ChildNodes.FindNode('seg');
    Memo2.Lines.Add('Inicio  <seg>');
    for i := 0 to nodeseg.ChildNodes.Count-1 do
    begin
      if (nodeseg.ChildNodes[i].NodeName = 'infResp') then
      begin
        Memo2.Lines.Add('    Inicio  <infResp>');
        nodeinfResp := nodeseg.ChildNodes.FindNode('infResp');
        for e := 0 to nodeinfResp.ChildNodes.Count-1 do
          Memo2.Lines.Add('          '+nodeinfResp.ChildNodes[e].NodeName+' = '+nodeinfResp.ChildNodes[e].Text);
        Memo2.Lines.Add('    Fim  </infResp>');
      end
      else if (nodeseg.ChildNodes[i].NodeName = 'infSeg') then
      begin
        Memo2.Lines.Add('    Inicio  <infSeg>');
        nodeinfSeg := nodeseg.ChildNodes.FindNode('infSeg');
        for e := 0 to nodeinfSeg.ChildNodes.Count-1 do
          Memo2.Lines.Add('          '+nodeinfSeg.ChildNodes[e].NodeName+' = '+nodeinfSeg.ChildNodes[e].Text);
        Memo2.Lines.Add('    Fim  </infSeg>');
      end
      else
        Memo2.Lines.Add('     '+ nodeseg.ChildNodes[i].NodeName+' = '+nodeseg.ChildNodes[i].Text);
    end;
    Memo2.Lines.Add('Fim  </seg>');
//   node seg**********************************************************************************************

//   node tot**********************************************************************************************
    nodetot := nodeinfMDFe.ChildNodes.FindNode('tot');
    Memo2.Lines.Add('Inicio  <tot>');
    for i := 0 to nodetot.ChildNodes.Count-1 do
    begin
       if (nodetot.ChildNodes[i].NodeName <> 'tot') then
        Memo2.Lines.Add('     '+ nodetot.ChildNodes[i].NodeName+' = '+nodetot.ChildNodes[i].Text)
       else

    end;
    Memo2.Lines.Add('Fim  </tot>');
//   node tot**********************************************************************************************

//   node autXML**********************************************************************************************
    nodeautXML := nodeinfMDFe.ChildNodes.FindNode('autXML');
    Memo2.Lines.Add('Inicio  <autXML>');
    for i := 0 to nodeautXML.ChildNodes.Count-1 do
    begin
      if (nodeautXML.ChildNodes[i].NodeName <> 'autXML') then
        Memo2.Lines.Add('     '+ nodeautXML.ChildNodes[i].NodeName+' = '+nodeautXML.ChildNodes[i].Text)
      else
    end;
    Memo2.Lines.Add('  Fim  </autXML>');
    Memo2.Lines.Add('Fim  </infMDFe>');
//   node autXML**********************************************************************************************

//   node infMDFeSupl**********************************************************************************************
    nodeinfMDFeSupl := XMLDocument1.ChildNodes.FindNode('MDFe').ChildNodes.FindNode('infMDFeSupl');
    Memo2.Lines.Add('Inicio  <infMDFeSupl>');
    for i := 0 to nodeinfMDFeSupl.ChildNodes.Count-1 do
    begin
      if (nodeinfMDFeSupl.ChildNodes[i].NodeName <> 'infMDFeSupl') then
        Memo2.Lines.Add('     '+ nodeinfMDFeSupl.ChildNodes[i].NodeName+' = '+nodeinfMDFeSupl.ChildNodes[i].Text)
      else
    end;
    Memo2.Lines.Add('  Fim  </infMDFeSupl>');
    Memo2.Lines.Add('Fim  </MDFe>');
//   node infMDFeSupl**********************************************************************************************
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
