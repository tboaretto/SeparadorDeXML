unit UntSeparadordeXML;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc,
  Vcl.StdCtrls, Vcl.ExtCtrls,VCL.FileCtrl, System.ZLib ,SevenZip;

type
  TFrmSeparadordeXML = class(TForm)
    XMLDocument1: TXMLDocument;
    pnl1: TPanel;
    Button1: TButton;
    EdtOrigemXML: TLabeledEdit;
    EdtDestinoXML: TLabeledEdit;
    BtnOrigemXML: TButton;
    BtnDestinoXML: TButton;
    procedure Button1Click(Sender: TObject);
    procedure BtnOrigemXMLClick(Sender: TObject);
    procedure BtnDestinoXMLClick(Sender: TObject);
  private
    procedure Executar;
    function TemAtributo(Attr, Val: Integer): Boolean;
    function RecursiveDelete(FullPath: String): Boolean;
    function BuscaTomador: string;
    function BuscaEmitente: string;
    function VerificaDiretorioFinal(Diret: String): string;
    function TrocaCaracterEspecial(aTexto : string; aLimExt : boolean) : string;
    procedure Eventos(DiretorioDase, DiretorioDestino, NomeArquivo: string);
    procedure Inutilizacao(DiretorioDase, DiretorioDestino, NomeArquivo: string);
    procedure CTEs(DiretorioDase, DiretorioDestino, NomeArquivo: string);

    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSeparadordeXML: TFrmSeparadordeXML;

implementation

{$R *.dfm}

procedure TFrmSeparadordeXML.BtnDestinoXMLClick(Sender: TObject);
var
  selDir:string;
begin
  if SelectDirectory('Selecione uma pasta', '', selDir) then
       EdtDestinoXML.Text := selDir;
end;

procedure TFrmSeparadordeXML.BtnOrigemXMLClick(Sender: TObject);
var
  selDir:string;
begin
  if SelectDirectory('Selecione uma pasta', '', selDir) then
     EdtOrigemXML.Text := selDir;
end;

function TFrmSeparadordeXML.BuscaEmitente: string;
var
  emit: IXMLNode;
begin
  emit := XMLDocument1.ChildNodes.FindNode('cteProc').ChildNodes.FindNode('CTe').ChildNodes.FindNode('infCte').ChildNodes.FindNode('emit');
  Result := emit.ChildNodes.FindNode('CNPJ').Text;
//  Result := emit.ChildNodes.FindNode('xNome').Text +' - '+ emit.ChildNodes.FindNode('CNPJ').Text;
end;

function TFrmSeparadordeXML.BuscaTomador: string;
var
  toma3, toma4, toma: IXMLNode;
  a: integer;
begin
          {tag toma Preencher com: 0-Remetente;
                                   1-Expedidor;
                                   2-Recebedor;
                                   3-Destinatário
           Serão utilizadas as informações contidas no respectivo grupo, conforme indicado pelo conteúdo deste campo}

  a:= 0;
  toma3 := XMLDocument1.ChildNodes.FindNode('cteProc').ChildNodes.FindNode('CTe').
                                                       ChildNodes.FindNode('infCte').
                                                       ChildNodes.FindNode('ide').
                                                       ChildNodes.FindNode('toma3');
  if Assigned(toma3) then
  begin
    case StrToInt(toma3.ChildNodes[a].Text) of
      0://0-Remetente
        toma := XMLDocument1.ChildNodes.FindNode('cteProc').ChildNodes.FindNode('CTe').ChildNodes.FindNode('infCte').ChildNodes.FindNode('rem');
      1://1-Expedidor
        toma := XMLDocument1.ChildNodes.FindNode('cteProc').ChildNodes.FindNode('CTe').ChildNodes.FindNode('infCte').ChildNodes.FindNode('exped');
      2://2-Recebedor
        toma := XMLDocument1.ChildNodes.FindNode('cteProc').ChildNodes.FindNode('CTe').ChildNodes.FindNode('infCte').ChildNodes.FindNode('receb');
      3://3-Destinatário
        toma := XMLDocument1.ChildNodes.FindNode('cteProc').ChildNodes.FindNode('CTe').ChildNodes.FindNode('infCte').ChildNodes.FindNode('dest');
    end;
  end
  else
  begin
    toma4 := XMLDocument1.ChildNodes.FindNode('cteProc').ChildNodes.FindNode('CTe').ChildNodes.FindNode('infCte').ChildNodes.FindNode('ide').ChildNodes.FindNode('toma4');
    if Assigned(toma4) then
      toma := XMLDocument1.ChildNodes.FindNode('cteProc').ChildNodes.FindNode('CTe').ChildNodes.FindNode('infCte').ChildNodes.FindNode('ide').ChildNodes.FindNode('toma4');
  end;
  Result := toma.ChildNodes.FindNode('xNome').Text;
end;

procedure TFrmSeparadordeXML.Button1Click(Sender: TObject);
begin
  if EdtOrigemXML.Text = EdtDestinoXML.Text then
     ShowMessage('Caminhos de origem e destino não podem ser iguais')
  else
    Executar;
end;

procedure TFrmSeparadordeXML.CTEs(DiretorioDase, DiretorioDestino,
  NomeArquivo: string);
var
Emitente, Tomador: string;
  cteProc: IXMLNode;
begin
  cteProc := XMLDocument1.ChildNodes.FindNode('cteProc');
  if Assigned(cteProc) then
  begin
    Emitente := TrocaCaracterEspecial(BuscaEmitente,True);  // busca o emitente do CTE
    Tomador := TrocaCaracterEspecial(BuscaTomador,True);    // Identifica qual é o tomador
    MoveFile(PChar(DiretorioDase+'\'+NomeArquivo), PChar((VerificaDiretorioFinal(DiretorioDestino+'\'+Emitente+'\cte_autorizado\'+Tomador))+'\'+NomeArquivo));
  end;
end;

procedure TFrmSeparadordeXML.Eventos(DiretorioDase, DiretorioDestino, NomeArquivo: string );
var
  F2: TSearchRec;
  Emitente, TipoEvento: string;
  procEventoCTe, infEvento: IXMLNode;
  Ret2: Integer;
begin
  // Resolve os xmls de eventos (cancelamento e carta de correcao) separando carta de correção e cancelamento
  procEventoCTe := XMLDocument1.ChildNodes.FindNode('procEventoCTe');
  if Assigned(procEventoCTe) then
  begin
    infEvento := XMLDocument1.ChildNodes.FindNode('procEventoCTe').ChildNodes.FindNode('eventoCTe').ChildNodes.FindNode('infEvento');
    Emitente := infEvento.ChildNodes.FindNode('CNPJ').Text; // carrega o cnpj do tomador para usar como nome do diretório

    if infEvento.ChildNodes.FindNode('tpEvento').Text = '110110' then
    begin
      TipoEvento := 'carta de correção';
      // move o xml para o diretório do emitente
      MoveFile(PChar(DiretorioDase+'\'+NomeArquivo), PChar((VerificaDiretorioFinal(DiretorioDestino+'\'+Emitente+'\eventos\'+TipoEvento))+'\'+NomeArquivo));
    end
    else
    if infEvento.ChildNodes.FindNode('tpEvento').Text = '110111' then
    begin
      TipoEvento := 'cancelamento';
      // move o xml para o diretório do emitente
      MoveFile(PChar(DiretorioDase+'\'+NomeArquivo), PChar((VerificaDiretorioFinal(DiretorioDestino+'\'+Emitente+'\eventos\'+TipoEvento))+'\'+NomeArquivo));

      // procura o xml do cte cancelado e move para o diret[orio correto
      Ret2 := FindFirst(DiretorioDase+'\'+infEvento.ChildNodes.FindNode('chCTe').Text+'-pro-cte.xml', faAnyFile, F2);
      MoveFile(PChar(DiretorioDase+'\'+F2.Name),PChar((VerificaDiretorioFinal(DiretorioDestino+'\'+Emitente+'\CTe cancelado\'))+F2.Name));
      FindClose(F2);
    end;
  end;
end;

procedure TFrmSeparadordeXML.Executar;
var
  F: TSearchRec;
  Ret: Integer;
    DiretorioTMP, DiretorioXML: string;
begin
  DiretorioTMP := EdtOrigemXML.Text;
  DiretorioXML := EdtDestinoXML.Text;
  RecursiveDelete(DiretorioXML);

  if not SysUtils.DirectoryExists(EdtDestinoXML.Text)then
  begin
    if not CreateDir(DiretorioXML) then
    begin
      SysUtils.ForceDirectories(DiretorioXML);
    end;
  end;
  Ret := FindFirst(DiretorioTMP+'\*.*', faAnyFile, F);
  try
    while Ret = 0 do
    begin
      if TemAtributo(F.Attr, faDirectory) then
      begin
        Ret := FindNext(F);
        continue
      end
      else
      begin
        XMLDocument1.LoadFromFile(DiretorioTMP+'\'+F.Name);  // passa o diretório e o nome do arquivo para ser carregado no XMLDocument1 (carrega o xml no XMLDocument1)
        Eventos(DiretorioTMP, DiretorioXML, F.Name);         // Resolve os xmls de eventos (cancelamento e carta de correcao) separando carta de correção e cancelamento
        Inutilizacao(DiretorioTMP, DiretorioXML, F.Name);    // Resolve os xmls de Inutilização
        CTEs(DiretorioTMP, DiretorioXML, F.Name);            // Resolve os xmls de CTE
      end;
        Ret := FindNext(F);
    end;
   finally
     FindClose(F);
   end;
end;

procedure TFrmSeparadordeXML.Inutilizacao(DiretorioDase, DiretorioDestino,
  NomeArquivo: string);
var
procInutCTe, infEvento: IXMLNode;
Emitente: string;
begin
  procInutCTe := XMLDocument1.ChildNodes.FindNode('procInutCTe');
  if Assigned(procInutCTe) then
  begin
    infEvento := XMLDocument1.ChildNodes.FindNode('procInutCTe').ChildNodes.FindNode('inutCTe').ChildNodes.FindNode('infInut');
    Emitente := infEvento.ChildNodes.FindNode('CNPJ').Text; // carrega o cnpj do tomador para usar como nome do diretório
    // move o xml para o diretório final
    MoveFile(PChar(DiretorioDase+'\'+NomeArquivo), PChar((VerificaDiretorioFinal(DiretorioDestino+'\'+Emitente+'\inutilizacao'))+'\'+NomeArquivo));
  end;
end;

function TFrmSeparadordeXML.RecursiveDelete(FullPath: String): Boolean;
Var
  sr : TSearchRec;
  iRetorno : Integer;
begin
  Result := False;
  FullPath := IncludeTrailingPathDelimiter(FullPath);
  if not(SysUtils.DirectoryExists(FullPath)) then
    Exit;

  iRetorno := FindFirst(FullPath + '*.*', faAnyFile, sr);
  while iRetorno = 0 do
  begin
  if (sr.Name <> '.') and (sr.Name <> '..') then
    if sr.Attr = faDirectory then
      RecursiveDelete(FullPath + sr.Name)
    else
    begin
      if GetFileAttributes(PWideChar(FullPath + sr.Name)) > 0 then
      SetFileAttributes(PWideChar(FullPath + sr.Name), 0);
      DeleteFile(PWideChar(FullPath + sr.Name));
    end;
  iRetorno := FindNext(sr);
  end;
  FindClose(sr);
  Result := RemoveDir(FullPath);
end;

function TFrmSeparadordeXML.TemAtributo(Attr, Val: Integer): Boolean;
begin
  Result := Attr and Val = Val;
end;

function TFrmSeparadordeXML.TrocaCaracterEspecial(aTexto: string;
  aLimExt: boolean): string;
const
  //Lista de caracteres especiais
  xCarEsp: array[1..38] of String = ('á', 'à', 'ã', 'â', 'ä','Á', 'À', 'Ã', 'Â', 'Ä',
                                     'é', 'è','É', 'È','í', 'ì','Í', 'Ì',
                                     'ó', 'ò', 'ö','õ', 'ô','Ó', 'Ò', 'Ö', 'Õ', 'Ô',
                                     'ú', 'ù', 'ü','Ú','Ù', 'Ü','ç','Ç','ñ','Ñ');
  //Lista de caracteres para troca
  xCarTro: array[1..38] of String = ('a', 'a', 'a', 'a', 'a','A', 'A', 'A', 'A', 'A',
                                     'e', 'e','E', 'E','i', 'i','I', 'I',
                                     'o', 'o', 'o','o', 'o','O', 'O', 'O', 'O', 'O',
                                     'u', 'u', 'u','u','u', 'u','c','C','n', 'N');
  //Lista de Caracteres Extras
  xCarExt: array[1..49] of string = ('<','>','!','@','#','$','%','¨','&','*',
                                     '(',')','_','+','=','{','}','[',']','?',
                                     ';',':',',','|','*','"','~','^','´','`',
                                     '¨','æ','Æ','ø','£','Ø','ƒ','ª','º','¿',
                                     '®','½','¼','ß','µ','þ','ý','Ý','/');
var
  xTexto : string;
  i : Integer;
begin
   xTexto := aTexto;
   for i:=1 to 38 do
     xTexto := StringReplace(xTexto, xCarEsp[i], xCarTro[i], [rfreplaceall]);
   //De acordo com o parâmetro aLimExt, elimina caracteres extras.
   if (aLimExt) then
     for i:=1 to 49 do
       xTexto := StringReplace(xTexto, xCarExt[i], '', [rfreplaceall]);
   Result := xTexto;
end;

function TFrmSeparadordeXML.VerificaDiretorioFinal(Diret: String): string;
begin
  if not SysUtils.DirectoryExists(Diret)then
  begin
    if not CreateDir(Diret) then
    begin
      SysUtils.ForceDirectories(Diret);
    end;
  end;
  Result := Diret;
end;

end.
