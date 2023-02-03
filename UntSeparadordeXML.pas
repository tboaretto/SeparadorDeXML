unit UntSeparadordeXML;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc,
  Vcl.StdCtrls, Vcl.ExtCtrls,VCL.FileCtrl, System.ZLib ,SevenZip, REST.Client, REST.Authenticator.Basic, REST.Types,
  IPPeerClient, Data.Bind.Components, Data.Bind.ObjectScope,
  System.JSON, System.NetEncoding, System.Zip, System.DateUtils, System.Threading, IWSystem,
  Vcl.ComCtrls, StrUtils, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase,
  IdSMTP, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  IdMessage;

type
  TProcedureExcept = reference to procedure (const AException: string);
  TFrmSeparadordeXML = class(TForm)
    XMLDocument1: TXMLDocument;
    pnl1: TPanel;
    Button1: TButton;
    EdtOrigemXML: TLabeledEdit;
    EdtDestinoXML: TLabeledEdit;
    BtnOrigemXML: TButton;
    BtnDestinoXML: TButton;
    DateIni: TDateTimePicker;
    DateFinal: TDateTimePicker;
    Button2: TButton;
    RESTClientTecnoSpeed: TRESTClient;
    RESTRequestTecnoSpeed: TRESTRequest;
    RESTResponseTecnoSpeed: TRESTResponse;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure BtnOrigemXMLClick(Sender: TObject);
    procedure BtnDestinoXMLClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    LThread: TThread;
    User, Password, UserEmail, PasswordEmail, DataInicial, DataFinal, ParametroGrupo,
    ParametroCnpj, ParametroEmail: String;
    function ClearDirectory(aDirectory : String): Boolean;
    function TemAtributo(Attr, Val: Integer): Boolean;
    function RecursiveDelete(FullPath: String): Boolean;
    function BuscaTomador: string;
    function BuscaEmitente: string;
    function CriarProtocolo: string;
    function ConsultarProtocolo(Protocolo: String): Boolean;
    function VerificaDiretorioFinal(Diret: String): string;
    function TrocaCaracterEspecial(aTexto : string; aLimExt : boolean) : string;

    procedure Executar(Diretorio, DiretorioFinal: string);
    procedure CarregaConfiguracao;
    procedure Eventos(DiretorioDase, DiretorioDestino, NomeArquivo: string);
    procedure Inutilizacao(DiretorioDase, DiretorioDestino, NomeArquivo: string);
    procedure CTEs(DiretorioDase, DiretorioDestino, NomeArquivo: string);
    procedure CarregarRest;
    procedure ManipulaArquivoProtocolo;
    procedure BaixarXML(protocolo: string);
    procedure DescompactaArquivo(Arquivo, Destino: String);
    procedure CompactaArquivo(Arquivo, Destino: String);
    procedure VerificaLoteBaixar;
    procedure DisparaEmail(Arquivo: string);

    procedure ThreadExecution;

    { Private declarations }
    const ARQUIVOUSUARIOS = 'PRJSeparadorDeXML.cfg';
    const ARQUIVOCONFIG = 'PRJSeparadorDeXML.ini';
  public
    { Public declarations }
  end;


var
  FrmSeparadordeXML: TFrmSeparadordeXML;

implementation

uses
  UntEmail;

{$R *.dfm}

procedure TFrmSeparadordeXML.BaixarXML(protocolo: string);
var
  Diretorio, DiretorioFinal, ArquivoPath, LoteXML: string;
  Arquivo: TBytes;
  Stream: TMemoryStream;
begin
  CarregarRest;
  RESTClientTecnoSpeed.ContentType := 'application/json';
  RESTClientTecnoSpeed.BaseURL := 'https://managersaas.tecnospeed.com.br:8081';

  RESTRequestTecnoSpeed.Resource := '/api/v2/cte/exporta/'+protocolo+'/xml?grupo='+ParametroGrupo+'&cnpj='+ParametroCnpj;
  RESTRequestTecnoSpeed.Method := TRESTRequestMethod.rmGET;

  RESTRequestTecnoSpeed.Execute;

  Stream := TMemoryStream.Create;
  Diretorio := gsAppPath + 'tmp\XMLTecnospeed\' + ParametroCnpj;
  ArquivoPath := Diretorio + '\' + ParametroCnpj + '.zip';
  Arquivo := RESTResponseTecnoSpeed.RawBytes;
  Stream.Clear;
  Stream.Write(Arquivo, Length(Arquivo));

  if not SysUtils.DirectoryExists(gsAppPath + 'tmp\XMLTecnospeed\' + ParametroCnpj) then
      SysUtils.ForceDirectories(gsAppPath+ 'tmp\XMLTecnospeed\' + ParametroCnpj)
  else
    ClearDirectory(Diretorio);
  //Salvar arquivo byte
  Stream.SaveToFile(ArquivoPath);

  DescompactaArquivo(ArquivoPath, Diretorio);

  DiretorioFinal := gsAppPath + 'tmp\XML\' + ParametroCnpj;
  LoteXML := gsAppPath + 'tmp\XML\' + ParametroCnpj + '.zip';
  //Executa a separação de XML por pasta
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    Executar(Diretorio, DiretorioFinal);
  end);
  CompactaArquivo(LoteXML, DiretorioFinal);
  RecursiveDelete(DiretorioFinal);
  DisparaEmail(LoteXML);
end;

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
    Executar(EdtOrigemXML.Text, EdtDestinoXML.Text);
end;

procedure TFrmSeparadordeXML.Button2Click(Sender: TObject);
var
  Dias: Integer;
begin
  if not FileExists(ARQUIVOUSUARIOS) then
    raise Exception.Create('Arquivo de configuração não encontrado');

  Dias := DaysBetween(DateIni.Date,
  DateFinal.Date);

  if Dias >= 31 then
    raise Exception.Create('Data Inicial e Data Final não podem ultrapassar limite de 31 dias de diferença.');

  DataInicial := FormatDateTime('YYYY-mm-dd', DateIni.Date);
  DataFinal := FormatDateTime('YYYY-mm-dd', DateFinal.Date);
  ThreadExecution;
end;

procedure TFrmSeparadordeXML.CarregaConfiguracao;
var
  I: Integer;
  Lista: TStringList;
  ParametroNome, ParametroValor: string;
begin
  Lista := TStringList.Create;
  try
    Lista.LoadFromFile(gsAppPath + ARQUIVOCONFIG);
    for I := 0 to Pred(Lista.Count) do
    begin
      if Lista[I].IndexOf('=') > 0 then
      begin
        ParametroNome := Lista[I].Split(['='])[0];
        ParametroValor :=  Lista[I].Split(['='])[1];
        case AnsiIndexStr(ParametroNome, ['User', 'Password', 'UserEmail', 'PasswordEmail']) of
          0:User := ParametroValor;
          1:Password := ParametroValor;
          2:UserEmail := ParametroValor;
          3:PasswordEmail := ParametroValor;
        end;
      end;
    end;
  finally
    Lista.Free;
  end;
end;

procedure TFrmSeparadordeXML.CarregarRest;
begin
  //Resetando REST para default
  RESTClientTecnoSpeed.ResetToDefaults;
  RESTRequestTecnoSpeed.ResetToDefaults;
  RESTResponseTecnoSpeed.ResetToDefaults;

  //ObterAutenticacaoBasica - Função que passa Usuario e senha para carregar a autenticação das requisições.
  if (User <> EmptyStr) or (Password <> EmptyStr) then
    RESTClientTecnoSpeed.Authenticator := THTTPBasicAuthenticator.Create(User, Password)
  else
    raise Exception.Create('Usuário/Senha não configurado!!');

  //Seta qual o Client e Response vai ser utilizado no request.
  RESTRequestTecnoSpeed.Client := RESTClientTecnoSpeed;
  RESTRequestTecnoSpeed.Response := RESTResponseTecnoSpeed;
end;

function TFrmSeparadordeXML.ClearDirectory(aDirectory: String): Boolean;
var
  SR: TSearchRec;
  I: integer;
begin
  I := FindFirst(aDirectory + '*.*', faAnyFile, SR);
  while I = 0 do
  begin
    if (SR.Attr and faDirectory) <> faDirectory then
    begin
      if not DeleteFile(PChar(aDirectory + SR.Name)) then
      begin
        Result := False;
        Exit;
      end;
    end;

    I := FindNext(SR);
  end;

  Result := True;
end;

procedure TFrmSeparadordeXML.CompactaArquivo(Arquivo, Destino: String);
var
  zipFile: TZipFile;
begin
  zipFile := TZipFile.Create;
  try
    //Compacta diretorio
    zipFile.ZipDirectoryContents(Arquivo, Destino);
  finally
    zipFile.Free;
  end;
end;

function TFrmSeparadordeXML.ConsultarProtocolo(Protocolo: String): Boolean;
var
  FUrlXML: string;
  response, xmlObj: TJSONObject;
begin
  CarregarRest;
  RESTClientTecnoSpeed.ContentType := 'application/json';
  RESTClientTecnoSpeed.BaseURL := 'https://managersaas.tecnospeed.com.br:8081';

  RESTRequestTecnoSpeed.Resource := '/api/v2/cte/exporta/'+protocolo+'?grupo='+ParametroGrupo+'&cnpj='+ParametroCnpj;
  RESTRequestTecnoSpeed.Method := TRESTRequestMethod.rmGET;

  RESTRequestTecnoSpeed.Execute;
  response := RESTResponseTecnoSpeed.JSONValue as TJSONObject;
  xmlObj := response.GetValue('xmls') as TJSONObject;
  FUrlXML := xmlObj.GetValue('situacao').Value;
  if FUrlXML = 'CONCLUIDO' then
  begin
    BaixarXML(protocolo);
    Result := True;
  end
  else
    Result := False;
end;

function TFrmSeparadordeXML.CriarProtocolo: String;
var
   objeto, response: TJSONObject;
begin
  objeto := TJSONObject.Create;
  objeto.AddPair('dataInicial', DataInicial);
  objeto.AddPair('dataFinal', DataFinal);
  objeto.AddPair('pdf', TJSONBool.Create(False));

  CarregarRest;
  RESTClientTecnoSpeed.ContentType := 'application/json';
  RESTClientTecnoSpeed.BaseURL := 'https://managersaas.tecnospeed.com.br:8081';

  RESTRequestTecnoSpeed.Resource := '/api/v2/cte/exporta?grupo='+ParametroGrupo+'&cnpj='+ParametroCnpj;
  RESTRequestTecnoSpeed.Method := TRESTRequestMethod.rmPOST;

  RESTRequestTecnoSpeed.AddBody(objeto.ToString, ContentTypeFromString('application/json'));

  RESTRequestTecnoSpeed.Execute;
  response := RESTResponseTecnoSpeed.JSONValue as TJSONObject;
  Result := response.GetValue('protocolo').Value;
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

procedure TFrmSeparadordeXML.DescompactaArquivo(Arquivo, Destino: String);
var
  zipfile: TZipFile;
begin
  zipfile := TZipFile.Create;
  try
    //Arquivo que será descompactado
    zipfile.Open(Arquivo, zmRead);
    //Extrai os arquivos
    zipfile.ExtractAll(Destino);
    zipfile.Close;
    //Exclui arquivo descompactado
    DeleteFile(Arquivo);
  finally
    zipfile.Free;
  end;
end;

procedure TFrmSeparadordeXML.DisparaEmail(Arquivo: string);
var
  Email: TEmail;
begin
  Email := TEmail.Create;
  try
    Email.Host := 'smtp.gmail.com';
    Email.Port := 587;
    Email.Username := UserEmail;
    Email.Password := PasswordEmail;
    Email.EmailAddress := UserEmail;
    Email.Name := 'Sialog';
    Email.EmailDestiny := ParametroEmail;
    Email.Subject := 'Envio Lote XML-CTE';
    Email.Message := 'O arquivo referente ao Conhecimento de Transporte eletrônico foram anexados a este email.';
    Email.EnviarEmail(Arquivo);
  finally
    Email.Free;
  end;
end;

procedure TFrmSeparadordeXML.Eventos(DiretorioDase, DiretorioDestino, NomeArquivo: string );
var
  F2: TSearchRec;
  Emitente, TipoEvento, Tomador: string;
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
      Ret2 := FindFirst(DiretorioDase+'\'+infEvento.ChildNodes.FindNode('chCTe').Text+'-cte.xml', faAnyFile, F2);
      if Ret2 = 0 then
        MoveFile(PChar(DiretorioDase+'\'+F2.Name),PChar((VerificaDiretorioFinal(DiretorioDestino+'\'+Emitente+'\CTe cancelado\'))+F2.Name));

      FindClose(F2);
    end;
  end;
end;

procedure TFrmSeparadordeXML.Executar(Diretorio, DiretorioFinal: string);
var
  F: TSearchRec;
  Ret: Integer;
  DiretorioTMP, DiretorioXML: string;
begin
  DiretorioTMP := Diretorio;
  DiretorioXML := DiretorioFinal;

  RecursiveDelete(DiretorioXML);
  if not SysUtils.DirectoryExists(DiretorioXML)then
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
        if FileExists(DiretorioTMP+'\'+F.Name) then
        begin
          XMLDocument1.LoadFromFile(DiretorioTMP+'\'+F.Name);// passa o diretório e o nome do arquivo para ser carregado no XMLDocument1 (carrega o xml no XMLDocument1)
          Eventos(DiretorioTMP, DiretorioXML, F.Name);         // Resolve os xmls de eventos (cancelamento e carta de correcao) separando carta de correção e cancelamento
          Inutilizacao(DiretorioTMP, DiretorioXML, F.Name);    // Resolve os xmls de Inutilização
          CTEs(DiretorioTMP, DiretorioXML, F.Name);            // Resolve os xmls de CTE
        end;
      end;
        Ret := FindNext(F);
    end;
   finally
     FindClose(F);
   end;
end;

procedure TFrmSeparadordeXML.FormCreate(Sender: TObject);
var
  PrimeiroDia, PrimeiroDiaAlt, UltimoDiaAlt: TDate;
begin
  CarregaConfiguracao;
  PrimeiroDia := StartOfTheMonth(Date);
  if Today = PrimeiroDia then
  begin
    UltimoDiaAlt := PrimeiroDia - 1;
    PrimeiroDiaAlt := StartOfTheMonth(UltimoDiaAlt);
    DataInicial := FormatDateTime('YYYY-mm-dd', PrimeiroDiaAlt);
    DataFinal := FormatDateTime('YYYY-mm-dd', UltimoDiaAlt);

    if not FileExists(gsAppPath + ARQUIVOUSUARIOS) then
      raise Exception.Create('Arquivo de configuração não encontrado');

    ThreadExecution;
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

procedure TFrmSeparadordeXML.ManipulaArquivoProtocolo;
var
  I: Integer;
  ListaParametros: TStringList;
  ParametrosFrase, Protocolo: string;
begin
  ListaParametros := TStringList.Create;
  try
    ListaParametros.LoadFromFile(gsAppPath + ARQUIVOUSUARIOS);
    for I := 0 to Pred(ListaParametros.Count) do
    begin
      if ListaParametros[I].IndexOf('=') > 0 then
      begin
        ParametrosFrase := ListaParametros[I].Split(['*'])[0];
        ParametroGrupo := ParametrosFrase.Split(['='])[0];
        ParametroCnpj :=  ParametrosFrase.Split(['='])[1];
        Protocolo := CriarProtocolo;
        ListaParametros.Strings[I] := ParametrosFrase + '*' + Protocolo + '*True';
        ListaParametros.SaveToFile(gsAppPath + ARQUIVOUSUARIOS);
      end;
    end;
  finally
    ListaParametros.Free;
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

procedure TFrmSeparadordeXML.ThreadExecution;
begin
  LThread := TThread.CreateAnonymousThread(
    procedure
    begin
      try
        ManipulaArquivoProtocolo;
        VerificaLoteBaixar;
      except on E:Exception do
        begin
          raise Exception.Create(E.Message);
        end;
      end;
    end
  );
  LThread.FreeOnTerminate := True;
  LThread.Start;
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

procedure TFrmSeparadordeXML.VerificaLoteBaixar;
var
  I: Integer;
  ListaParametros, NovaListaParametros: TStringList;
  Status, ParametrosFrase, ProtocoloCliente, dadosResolvidos, teste: string;
begin
  ListaParametros := TStringList.Create;
  NovaListaParametros := TStringList.Create;
  try
    ListaParametros.LoadFromFile(gsAppPath + ARQUIVOUSUARIOS);
    for I := 0 to Pred(ListaParametros.Count) do
    begin
      if ListaParametros[I].IndexOf('=') > 0 then
      begin
        Status := ListaParametros[I].Split(['*'])[2];
        dadosResolvidos := ListaParametros[I].Split(['*'])[0];
        teste := ListaParametros[I].Split(['*'])[1];
        if Status = 'True' then
          NovaListaParametros.Add(ListaParametros[I]);
      end;
    end;

    while Pred(NovaListaParametros.Count) >= 0 do
    begin
      for I := 0 to Pred(NovaListaParametros.Count) do
      begin
        if NovaListaParametros[I].IndexOf('=') > 0 then
        begin
          ParametrosFrase := NovaListaParametros[I].Split(['*'])[0];
          ProtocoloCliente := NovaListaParametros[I].Split(['*'])[1];
          ParametroGrupo := ParametrosFrase.Split(['='])[0];
          ParametroCnpj :=  ParametrosFrase.Split(['='])[1];
          ParametroEmail :=  ParametrosFrase.Split(['='])[2];
          if ConsultarProtocolo(ProtocoloCliente) then
          begin
            NovaListaParametros.Delete(I);
            Break;
          end;
        end;
      end;
    end;
  finally
    ListaParametros.Free;
    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      ShowMessage('Arquivos Gerados com Sucesso!!');
    end);
  end;
end;

end.
