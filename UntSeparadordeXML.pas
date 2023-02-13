unit UntSeparadordeXML;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc,
  Vcl.StdCtrls, Vcl.ExtCtrls,VCL.FileCtrl, System.ZLib ,SevenZip, REST.Client, REST.Authenticator.Basic, REST.Types,
  IPPeerClient, Data.Bind.Components, Data.Bind.ObjectScope,
  System.JSON, System.NetEncoding, System.Zip, System.DateUtils, System.Threading, IWSystem,
  Vcl.ComCtrls, StrUtils, Vcl.Imaging.GIFImg, UntLog, System.IniFiles;

type
  TFrmSeparadordeXML = class(TForm)
    XMLDocument1: TXMLDocument;
    pnl1: TPanel;
    Button1: TButton;
    EdtOrigemXML: TLabeledEdit;
    EdtDestinoXML: TLabeledEdit;
    BtnOrigemXML: TButton;
    BtnDestinoXML: TButton;
    Button2: TButton;
    RESTClientTecnoSpeed: TRESTClient;
    RESTRequestTecnoSpeed: TRESTRequest;
    RESTResponseTecnoSpeed: TRESTResponse;
    DateIni: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    DateFinal: TDateTimePicker;
    Label3: TLabel;
    lblContador: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure BtnOrigemXMLClick(Sender: TObject);
    procedure BtnDestinoXMLClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    TotalUser: Integer;
    VerifyThreadTimer: Boolean;
    VerifyThread: Boolean;
    LThread, LThreadTimer: TThread;
    User, Password, UserEmail, PasswordEmail, DataUltimaBaixa, DataInicial, DataFinal, ParametroGrupo,
    ParametroCnpj, ParametroEmail: String;
    function ClearDirectory(aDirectory : String): Boolean;
    function TemAtributo(Attr, Val: Integer): Boolean;
    function RecursiveDelete(FullPath: String): Boolean;
    function BuscaTomador: string;
    function BuscaEmitente: string;
    function CriarProtocolo: string;
    function ConsultarProtocolo(Protocolo: String): Boolean;
    function VerificaDiretorioFinal(Diret: String): string;
    function BaixarXML(protocolo: string): Boolean;
    function TrocaCaracterEspecial(aTexto : string; aLimExt : boolean) : string;
    function GetConfiguracao(Secao, Parametro, ValorPadrao: String): string;

    procedure Executar(Diretorio, DiretorioFinal: string);
    procedure CarregaConfiguracao;
    procedure Eventos(DiretorioDase, DiretorioDestino, NomeArquivo: string);
    procedure Inutilizacao(DiretorioDase, DiretorioDestino, NomeArquivo: string);
    procedure CTEs(DiretorioDase, DiretorioDestino, NomeArquivo: string);
    procedure CarregarRest;
    procedure ManipulaArquivoProtocolo;
    procedure DescompactaArquivo(Arquivo, Destino: String);
    procedure CompactaArquivo(Arquivo, Destino: String);
    procedure VerificaLoteBaixar;
    procedure DisparaEmail(Arquivo: String);
    procedure SetConfiguracao(Secao, Parametro, ValorPadrao: String);
    procedure LimpaArquivo(Arquivo: String);


    procedure ThreadEndTimer(Sender: TObject);
    procedure ThreadEnd(Sender: TObject);
    procedure ThreadExecution;
    procedure ThreadExecutionTimer;


    const ARQUIVOUSUARIOS = 'PRJSeparadorDeXML.cfg';
    const ARQUIVOCONFIG = 'PRJSeparadorDeXML.ini';
    const BAIXALOTE = 'BaixaLote.cfg';
  public
    { Public declarations }
  end;


var
  FrmSeparadordeXML: TFrmSeparadordeXML;

implementation

uses
  UntEmail;

{$R *.dfm}

function TFrmSeparadordeXML.BaixarXML(protocolo: string): Boolean;
var
  Diretorio, DiretorioFinal, ArquivoPath, LoteXML: string;
  Arquivo: TBytes;
  Stream: TMemoryStream;
begin
  Result := False;
  Stream := TMemoryStream.Create;
  try
    try
      CarregarRest;
      RESTClientTecnoSpeed.ContentType := 'application/json';
      RESTClientTecnoSpeed.BaseURL := 'https://managersaas.tecnospeed.com.br:8081';

      RESTRequestTecnoSpeed.Resource := '/api/v2/cte/exporta/'+protocolo+'/xml?grupo='+ParametroGrupo+'&cnpj='+ParametroCnpj;
      RESTRequestTecnoSpeed.Method := TRESTRequestMethod.rmGET;

      RESTRequestTecnoSpeed.Execute;
      if RESTRequestTecnoSpeed.Response.StatusCode = 200 then
      begin
        if Pos('EXCEPTION', RESTResponseTecnoSpeed.Content) <> 0 then
        begin
          Log.CriarLogMensagem(RESTResponseTecnoSpeed.Content + ': CNPJ - ' + ParametroCnpj);
          Exit;
        end;
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
        Result := True;
      end
      else
        Log.CriarLogMensagem('Falha no download do XML CNPJ - '+ParametroCnpj);
    except
      on E: Exception do
      begin
        Log.CriarLogException(E);
        raise;
      end;
    end;
  finally
    Stream.Free;
  end;
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
  if not FileExists(gsAppPath + ARQUIVOUSUARIOS) then
    raise Exception.Create('Arquivo de configuração não encontrado');

  Dias := DaysBetween(DateIni.Date,
  DateFinal.Date);

  if Dias >= 31 then
  begin
    Application.MessageBox('Data Inicial e Data Final não podem ultrapassar limite de 31 dias de diferença.', 'Atenção',MB_ICONWARNING+MB_OK);
    Exit;
  end;

  DataInicial := FormatDateTime('YYYY-mm-dd', DateIni.Date);
  DataFinal := FormatDateTime('YYYY-mm-dd', DateFinal.Date);
  ThreadExecution;
end;

procedure TFrmSeparadordeXML.CarregaConfiguracao;
begin
  User := GetConfiguracao('TECNOSPEED', 'User', '');
  Password := GetConfiguracao('TECNOSPEED', 'Password', '');
  UserEmail := GetConfiguracao('EMAIL', 'UserEmail', '');
  PasswordEmail := GetConfiguracao('EMAIL', 'PasswordEmail', '');
  DataUltimaBaixa := GetConfiguracao('ULTIMA BAIXA', 'DataBaixaLote', '');
  if DataUltimaBaixa = EmptyStr then
    DataUltimaBaixa := DateToStr(Today - 1);
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
  FUrlXML, FMensagem: string;
  response, xmlObj: TJSONObject;
begin
  try
    Result := False;
    CarregarRest;
    RESTClientTecnoSpeed.ContentType := 'application/json';
    RESTClientTecnoSpeed.BaseURL := 'https://managersaas.tecnospeed.com.br:8081';

    RESTRequestTecnoSpeed.Resource := '/api/v2/cte/exporta/'+protocolo+'?grupo='+ParametroGrupo+'&cnpj='+ParametroCnpj;
    RESTRequestTecnoSpeed.Method := TRESTRequestMethod.rmGET;

    RESTRequestTecnoSpeed.Execute;
    if RESTRequestTecnoSpeed.Response.StatusCode = 200 then
    begin
      if Pos('EXCEPTION', RESTResponseTecnoSpeed.Content) <> 0 then
      begin
          Log.CriarLogMensagem(RESTResponseTecnoSpeed.Content + ': CNPJ - ' + ParametroCnpj);
          Exit;
      end;
      response := RESTResponseTecnoSpeed.JSONValue as TJSONObject;
      FMensagem := response.GetValue('mensagem').Value;
      if FMensagem = 'Operação concluída, nenhum registro encontrado para o filtro utilizado.' then
      begin
        Log.CriarLogMensagem('Nenhum Registro encontrado do CNPJ '+ParametroCnpj);
        Result := True;
        Exit;
      end;
      xmlObj := response.GetValue('xmls') as TJSONObject;
      FUrlXML := xmlObj.GetValue('situacao').Value;
      if FUrlXML = 'CONCLUIDO' then
      begin
        if BaixarXML(protocolo) then
        begin
          Result := True;
        end;
      end;
    end
    else
         Log.CriarLogMensagem('Falha na requisição da consulta para o CNPJ ' + ParametroCnpj + ' - ' + IntToStr(RESTRequestTecnoSpeed.Response.StatusCode) +' - ' + RESTRequestTecnoSpeed.Response.StatusText);
  except
    on E: Exception do
    begin
      Log.CriarLogException(E);
      raise;
    end;
  end;
end;

function TFrmSeparadordeXML.CriarProtocolo: String;
var
   objeto, response: TJSONObject;
begin
  objeto := TJSONObject.Create;
  try
    try
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
      if RESTRequestTecnoSpeed.Response.StatusCode = 200 then
      begin
        if Pos('EXCEPTION', RESTResponseTecnoSpeed.Content) <> 0 then
        begin
          Log.CriarLogMensagem(RESTResponseTecnoSpeed.Content + ': CNPJ - ' + ParametroCnpj);
          Exit;
        end;

        response := RESTResponseTecnoSpeed.JSONValue as TJSONObject;
        Result := response.GetValue('protocolo').Value;
      end
      else
        Log.CriarLogMensagem('Falha na criação do protocolo: CNPJ - '+ParametroCnpj);
    except
      on E: Exception do
      begin
        Log.CriarLogException(E);
      end;
    end;
  finally
    objeto.Free;
  end;
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
    MoveFile(PChar(DiretorioDase+'\'+NomeArquivo), PChar((VerificaDiretorioFinal(DiretorioDestino+'\'+Emitente+'\CTe Autorizado\'+Tomador))+'\'+NomeArquivo));
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

procedure TFrmSeparadordeXML.DisparaEmail(Arquivo: String);
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
      TipoEvento := 'Carta de Correção';
      // move o xml para o diretório do emitente
      MoveFile(PChar(DiretorioDase+'\'+NomeArquivo), PChar((VerificaDiretorioFinal(DiretorioDestino+'\'+Emitente+'\Eventos\'+TipoEvento))+'\'+NomeArquivo));
    end
    else
    if infEvento.ChildNodes.FindNode('tpEvento').Text = '110111' then
    begin
      TipoEvento := 'Cancelamento';
      // move o xml para o diretório do emitente
      MoveFile(PChar(DiretorioDase+'\'+NomeArquivo), PChar((VerificaDiretorioFinal(DiretorioDestino+'\'+Emitente+'\Eventos\'+TipoEvento))+'\'+NomeArquivo));

      // procura o xml do cte cancelado e move para o diret[orio correto
      Ret2 := FindFirst(DiretorioDase+'\'+infEvento.ChildNodes.FindNode('chCTe').Text+'-cte.xml', faAnyFile, F2);
      if Ret2 = 0 then
        MoveFile(PChar(DiretorioDase+'\'+F2.Name),PChar((VerificaDiretorioFinal(DiretorioDestino+'\'+Emitente+'\CTe Cancelado\'))+F2.Name));

      FindClose(F2);
    end;
  end;
end;

procedure TFrmSeparadordeXML.Executar(Diretorio, DiretorioFinal: string);
var
  F: TSearchRec;
  Ret: Integer;
  DiretorioTMP, DiretorioXML, DiretorioInu: string;
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
  Ret := FindFirst(DiretorioTMP+'\*.xml', faAnyFile, F);
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
          //Inutilizacao(DiretorioTMP, DiretorioXML, F.Name);     Resolve os xmls de Inutilização
          CTEs(DiretorioTMP, DiretorioXML, F.Name);            // Resolve os xmls de CTE
        end;
      end;
        Ret := FindNext(F);
    end;
   finally
     FindClose(F);
   end;

  DiretorioInu := DiretorioTMP + '\Inutilizadas';
  if SysUtils.DirectoryExists(DiretorioInu) then
  begin
    Ret := FindFirst(DiretorioInu+'\*.xml', faAnyFile, F);
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
            XMLDocument1.LoadFromFile(DiretorioInu+'\'+F.Name);
            Inutilizacao(DiretorioInu, DiretorioXML, F.Name);  // Resolve os xmls de Inutilização
        end;
          Ret := FindNext(F);
      end;
     finally
       FindClose(F);
     end;
  end;
end;

procedure TFrmSeparadordeXML.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  resp: Integer;
begin
  if VerifyThread or VerifyThreadTimer then
  begin
    resp := Application.messagebox('Tarefa em execução, deseja finalizar a aplicação ?','Confirma',mb_iconquestion+MB_YESNO);
     case resp of
        idyes:
        begin
          LThread.Terminate;
          LThread.WaitFor;
          LThreadTimer.Terminate;
          LThreadTimer.WaitFor;
          Application.Terminate;
        end;
        idno:
        begin
          Abort;
        end;
     end;
  end;
  LimpaArquivo(gsAppPath + BAIXALOTE);
  Application.Terminate;
end;

procedure TFrmSeparadordeXML.FormCreate(Sender: TObject);
var
  PrimeiroDia, PrimeiroDiaAlt, UltimoDiaAlt: TDate;
begin
  DateIni.Date := Now;
  DateFinal.Date := Now;
  VerifyThread := False;
  CarregaConfiguracao;
  PrimeiroDia := StartOfTheMonth(Date);
  if (Today = PrimeiroDia) and (Today <> StrToDate(DataUltimaBaixa)) then
  begin
    UltimoDiaAlt := PrimeiroDia - 1;
    PrimeiroDiaAlt := StartOfTheMonth(UltimoDiaAlt);
    DataInicial := FormatDateTime('YYYY-mm-dd', PrimeiroDiaAlt);
    DataFinal := FormatDateTime('YYYY-mm-dd', UltimoDiaAlt);

    if not FileExists(gsAppPath + ARQUIVOUSUARIOS) then
      raise Exception.Create('Arquivo de configuração não encontrado');

    ThreadExecution;
    SetConfiguracao('ULTIMA BAIXA', 'DataBaixaLote', DateToStr(Today));
  end;
end;

function TFrmSeparadordeXML.GetConfiguracao(Secao, Parametro,
  ValorPadrao: String): string;
var
  LArquivoConfig: TIniFile;
begin
  LArquivoConfig := TIniFile.Create(gsAppPath + ARQUIVOCONFIG);
  try
    Result := LArquivoConfig.ReadString(Secao, Parametro, ValorPadrao);
  finally
    LArquivoConfig.Free;
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
    MoveFile(PChar(DiretorioDase+'\'+NomeArquivo), PChar((VerificaDiretorioFinal(DiretorioDestino+'\'+Emitente+'\Inutilização'))+'\'+NomeArquivo));
  end;
end;

procedure TFrmSeparadordeXML.LimpaArquivo(Arquivo: String);
var
  txt: TextFile;
begin
  AssignFile(txt, Arquivo);
  try
    Rewrite(txt);
  finally
    CloseFile(txt);
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
        if Protocolo <> EmptyStr then
        begin
          ListaParametros.Strings[I] := ParametrosFrase + '*' + Protocolo + '*True';
          ListaParametros.SaveToFile(gsAppPath + ARQUIVOUSUARIOS);
          Protocolo := '';
        end;
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

procedure TFrmSeparadordeXML.SetConfiguracao(Secao, Parametro,
  ValorPadrao: String);
var
  LArquivoConfig: TIniFile;
begin
  LArquivoConfig := TIniFile.Create(gsAppPath + ARQUIVOCONFIG);
  try
    LArquivoConfig.WriteString(Secao, Parametro, ValorPadrao);
  finally
    LArquivoConfig.Free;
  end;
end;

function TFrmSeparadordeXML.TemAtributo(Attr, Val: Integer): Boolean;
begin
  Result := Attr and Val = Val;
end;

procedure TFrmSeparadordeXML.ThreadEndTimer(Sender: TObject);
begin
  if Assigned(TThread(Sender).FatalException) then
    Application.messagebox(PChar(Exception(TThread(Sender).FatalException).Message),'Erro',MB_ICONERROR+MB_OK)
  else
  begin
    if TotalUser = 0 then
      Application.MessageBox('Processo Finalizado!!', 'Informação',MB_ICONINFORMATION+MB_OK);
  end;
end;

procedure TFrmSeparadordeXML.ThreadEnd(Sender: TObject);
begin
  if Assigned(TThread(Sender).FatalException) then
    Application.messagebox(PChar(Exception(TThread(Sender).FatalException).Message),'Erro',MB_ICONERROR+MB_OK)
  else
  begin
    if TotalUser = 0 then
      Application.MessageBox('Processo Finalizado!!', 'Informação',MB_ICONINFORMATION+MB_OK)
    else
      ThreadExecutionTimer;
  end;
end;

procedure TFrmSeparadordeXML.ThreadExecution;
var
  PrevCur: TCursor;
begin
  if VerifyThread or VerifyThreadTimer then
  begin
    Application.MessageBox('Já existe uma tarefa em processamento, por favor aguarde.', 'Informação',MB_ICONINFORMATION+MB_OK);
    Exit;
  end;

  PrevCur := Screen.Cursor;
  LThread := TThread.CreateAnonymousThread(
    procedure
    begin
      try
        TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          Screen.Cursor := crHourGlass;
        end);

        VerifyThread := True;
        ManipulaArquivoProtocolo;
        VerificaLoteBaixar;
      finally
        LThread.Terminate;
        VerifyThread := False;
        Screen.Cursor := PrevCur;
      end;
    end
  );
  LThread.FreeOnTerminate := False;
  LThread.OnTerminate := ThreadEnd;
  LThread.Start;
end;

procedure TFrmSeparadordeXML.ThreadExecutionTimer;
var
  FTimer: Cardinal;
  FEvent: THandle;
  PrevCurTimer: TCursor;
begin
  if VerifyThread or VerifyThreadTimer then
    Exit;

  FTimer := 10000;
  FEvent := CreateEvent( nil, false, false, nil );
  PrevCurTimer := Screen.Cursor;
  LThreadTimer := TThread.CreateAnonymousThread(
    procedure
    begin
      try
        while (not LThreadTimer.CheckTerminated) and (TotalUser > 0) do
          try
            TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              Screen.Cursor := crHourGlass;
            end);
            VerifyThreadTimer := True;
            VerificaLoteBaixar;
          finally
            TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              Screen.Cursor := PrevCurTimer;
            end);

            if (not LThreadTimer.CheckTerminated) and (TotalUser > 0) then
              WaitForSingleObject(FEvent, FTimer);
          end;
      finally
        LThreadTimer.Terminate;
        VerifyThreadTimer := False;
      end;
    end
  );
  LThreadTimer.FreeOnTerminate := False;
  LThreadTimer.OnTerminate := ThreadEndTimer;
  LThreadTimer.Start;
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
  I, ContArray: Integer;
  Items: array of Integer;
  ListaParametros, NovaListaParametros: TStringList;
  Status, ParametrosFrase, ProtocoloCliente, dadosResolvidos, cnpjVerify: string;
begin
  ContArray := 0;
  ListaParametros := TStringList.Create;
  NovaListaParametros := TStringList.Create;
  try
    ListaParametros.LoadFromFile(gsAppPath + ARQUIVOUSUARIOS);
    NovaListaParametros.LoadFromFile(gsAppPath + BAIXALOTE);
    for I := 0 to Pred(ListaParametros.Count) do
    begin
      if ListaParametros[I].IndexOf('=') > 0 then
      begin
        cnpjVerify := ListaParametros[I].Split(['='])[1];
        Status := ListaParametros[I].Split(['*'])[2];
        dadosResolvidos := ListaParametros[I].Split(['*'])[0];
        if Status = 'True' then
        begin
          if Pos(cnpjVerify, NovaListaParametros.Text) = 0 then
            NovaListaParametros.Add(ListaParametros[I]);

          ListaParametros.Strings[I] := dadosResolvidos + '*Protocolo*False';
          ListaParametros.SaveToFile(gsAppPath + ARQUIVOUSUARIOS);
        end;
      end;
    end;

    for I := 0 to Pred(NovaListaParametros.Count) do
    begin
      if LThread.CheckTerminated or LThreadTimer.CheckTerminated then
          Break;
      if NovaListaParametros[I].IndexOf('=') > 0 then
      begin
        ParametrosFrase := NovaListaParametros[I].Split(['*'])[0];
        ProtocoloCliente := NovaListaParametros[I].Split(['*'])[1];
        ParametroGrupo := ParametrosFrase.Split(['='])[0];
        ParametroCnpj :=  ParametrosFrase.Split(['='])[1];
        ParametroEmail :=  ParametrosFrase.Split(['='])[2];
        if ConsultarProtocolo(ProtocoloCliente) then
        begin
          ContArray := ContArray + 1;
          SetLength(Items, Length(Items) + 1);
          Items[ContArray] := I;
        end;
      end;
    end;

    for I := 0 to Pred(Length(Items)) do
    begin
      NovaListaParametros.Delete(Items[I]);
    end;
  finally
    TotalUser := NovaListaParametros.Count;
    NovaListaParametros.SaveToFile(gsAppPath + BAIXALOTE);
    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      lblContador.Caption := IntToStr(TotalUser);
    end);
    ListaParametros.Free;
    NovaListaParametros.Free;
  end;
end;

end.
