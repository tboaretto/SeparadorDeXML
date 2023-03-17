unit UntSeparadordeXML;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc,
  Vcl.StdCtrls, Vcl.ExtCtrls,VCL.FileCtrl, System.ZLib ,SevenZip, REST.Client, REST.Authenticator.Basic, REST.Types,
  IPPeerClient, Data.Bind.Components, Data.Bind.ObjectScope,
  System.JSON, System.NetEncoding, System.Zip, System.DateUtils, System.Threading, IWSystem,
  Vcl.ComCtrls, StrUtils, Vcl.Imaging.GIFImg, UntLog, System.IniFiles,
  System.ImageList, Vcl.ImgList, Vcl.Grids;

type
  TFrmSeparadordeXML = class(TForm)
    XMLDocument1: TXMLDocument;
    pnl1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    btnExecutar: TButton;
    EdtOrigemXML: TLabeledEdit;
    EdtDestinoXML: TLabeledEdit;
    BtnOrigemXML: TButton;
    BtnDestinoXML: TButton;
    DateIni: TDateTimePicker;
    DateFinal: TDateTimePicker;
    ListView1: TListView;
    btnBaixar: TButton;
    CheckVerify: TCheckBox;
    CheckEmail: TCheckBox;
    procedure btnExecutarClick(Sender: TObject);
    procedure BtnOrigemXMLClick(Sender: TObject);
    procedure BtnDestinoXMLClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnBaixarClick(Sender: TObject);
  private
    { Private declarations }
    var
    RESTClientConsulta: TRESTClient;
    RESTRequestConsulta: TRESTRequest;
    RESTResponseConsulta: TRESTResponse;
    RESTClientBaixa: TRESTClient;
    RESTRequestBaixa: TRESTRequest;
    RESTResponseBaixa: TRESTResponse;
    FTimer: Cardinal;
    FEvent: THandle;
    TotalUser: Integer;
    VerifyThread, RequireTLS: Boolean;
    LThread, LThreadTimer: TThread;
    User, Password, DisparaEmail, UserEmail, PasswordEmail, DataUltimaBaixa, DataInicial, DataFinal, ParametroGrupo,
    ParametroNome, ParametroCnpj, ParametroEmail, HostEmail, PortEmail, NameEmail, SubjectEmail, MessageEmail: String;
    function ClearDirectory(aDirectory : String): Boolean;
    function TemAtributo(Attr, Val: Integer): Boolean;
    function RecursiveDelete(FullPath: String): Boolean;
    function BuscaTomador: string;
    function BuscaEmitente: string;
    function BuscaSerie(Chave: string): string;
    function CriarProtocolo(Grupo, Cnpj: String): string;
    function ConsultarProtocolo(Protocolo: String): Boolean;
    function VerificaDiretorioFinal(Diret: String): string;
    function BaixarXML(protocolo: string): Boolean;
    function TrocaCaracterEspecial(aTexto : string; aLimExt : boolean) : string;
    function GetConfiguracao(Secao, Parametro, ValorPadrao: String): string;
    function VerificaLoteMensal: Boolean;

    procedure Executar(Diretorio, DiretorioFinal: string);
    procedure CarregarConfiguracao;
    procedure Eventos(DiretorioDase, DiretorioDestino, NomeArquivo: string);
    procedure Inutilizacao(DiretorioDase, DiretorioDestino, NomeArquivo: string);
    procedure CTEs(DiretorioDase, DiretorioDestino, NomeArquivo: string);
    procedure CarregarRest;
    procedure CarregarRest2;
    procedure DescompactaArquivo(Arquivo, Destino: String);
    procedure CompactaArquivo(Arquivo, Destino: String);
    procedure EnviaArquivo(Arquivo: String);
    procedure SetConfiguracao(Secao, Parametro, ValorPadrao: String);
    procedure CarregaGrid;
    procedure ManipulaGridProtocolo(Total: Boolean);
    procedure VerificaLoteGrid;
    procedure AtualizaArquivo(Cnpj, Protocolo, DataUltimaConsulta: String);

    procedure ThreadEnd(Sender: TObject);
    procedure ThreadExecution;
    procedure ThreadExecutionTimer;

    const ARQUIVOUSUARIOS = 'PRJSeparadorDeXML.cfg';
    const ARQUIVOCONFIG = 'PRJSeparadorDeXML.ini';
  public
    { Public declarations }
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;


var
  FrmSeparadordeXML: TFrmSeparadordeXML;

implementation

uses
  UntEmail;

{$R *.dfm}

procedure TFrmSeparadordeXML.AfterConstruction;
begin
  inherited;
  RESTClientConsulta   := TRESTClient.Create(nil);;
  RESTRequestConsulta  := TRESTRequest.Create(nil);
  RESTResponseConsulta := TRESTResponse.Create(nil);

  RESTClientBaixa      := TRESTClient.Create(nil);
  RESTRequestBaixa     := TRESTRequest.Create(nil);
  RESTResponseBaixa    := TRESTResponse.Create(nil);
end;

procedure TFrmSeparadordeXML.AtualizaArquivo(Cnpj, Protocolo, DataUltimaConsulta: String);
var
  I: Integer;
  Lista: TStringList;
  DataArq: string;
begin
  Lista := TStringList.Create;
  try
    Lista.LoadFromFile(gsAppPath + ARQUIVOUSUARIOS);
    for I := 0 to Pred(Lista.Count) do
    begin
      if Pos(Cnpj, Lista[I]) > 0 then
      begin
        DataArq := Lista.Strings[I].Split(['='])[5];
        Lista.Strings[I] := StringReplace(Lista.Strings[I], DataArq, DataUltimaConsulta, [rfIgnoreCase]);
        Lista.SaveToFile(gsAppPath + ARQUIVOUSUARIOS);
      end;
    end;
  finally
    Lista.Free;
  end;
end;

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
      CarregarRest2;
      RESTClientBaixa.ContentType := 'application/json';
      RESTClientBaixa.BaseURL := 'https://managersaas.tecnospeed.com.br:8081';

      RESTRequestBaixa.Resource := '/api/v2/cte/exporta/'+protocolo+'/xml?grupo='+ParametroGrupo+'&cnpj='+ParametroCnpj;
      RESTRequestBaixa.Method := TRESTRequestMethod.rmGET;

      RESTRequestBaixa.Execute;
      if RESTRequestBaixa.Response.StatusCode = 200 then
      begin
        if Pos('EXCEPTION', RESTResponseBaixa.Content) <> 0 then
        begin
          Log.CriarLogMensagem(RESTResponseBaixa.Content + ': CNPJ - ' + ParametroCnpj);
          Exit;
        end;
        Diretorio := gsAppPath + 'tmp\XMLTecnospeed\' + ParametroNome;
        ArquivoPath := Diretorio + '\' + ParametroNome + '.zip';
        Arquivo := RESTResponseBaixa.RawBytes;
        Stream.Clear;
        Stream.Write(Arquivo, Length(Arquivo));

        if not SysUtils.DirectoryExists(gsAppPath + 'tmp\XMLTecnospeed\' + ParametroNome) then
            SysUtils.ForceDirectories(gsAppPath+ 'tmp\XMLTecnospeed\' + ParametroNome)
        else
          ClearDirectory(Diretorio);
        //Salvar arquivo byte
        Stream.SaveToFile(ArquivoPath);

        DescompactaArquivo(ArquivoPath, Diretorio);

        if (EdtDestinoXML.Text <> '') and (SysUtils.DirectoryExists(EdtDestinoXML.Text)) then
          DiretorioFinal := EdtDestinoXML.Text + '\' + ParametroNome
        else
          DiretorioFinal := gsAppPath + 'tmp\XML\' + ParametroNome;

        LoteXML := DiretorioFinal + '.zip';
        //Executa a separação de XML por pasta
        TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          Executar(Diretorio, DiretorioFinal);
        end);
        CompactaArquivo(LoteXML, DiretorioFinal);
        RecursiveDelete(DiretorioFinal);

        if DisparaEmail = 'SIM' then
          EnviaArquivo(LoteXML);

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

procedure TFrmSeparadordeXML.BeforeDestruction;
begin
  RESTClientConsulta.Free;
  RESTRequestConsulta.Free;
  RESTResponseConsulta.Free;

  RESTClientBaixa.Free;
  RESTRequestBaixa.Free;
  RESTResponseBaixa.Free;
  inherited;
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

function TFrmSeparadordeXML.BuscaSerie(Chave: string): string;
begin
  Result := Copy(Chave, 23, 3);
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

procedure TFrmSeparadordeXML.btnExecutarClick(Sender: TObject);
begin
  if EdtOrigemXML.Text = EdtDestinoXML.Text then
     ShowMessage('Caminhos de origem e destino não podem ser iguais')
  else
    Executar(EdtOrigemXML.Text, EdtDestinoXML.Text);
end;

procedure TFrmSeparadordeXML.btnBaixarClick(Sender: TObject);
var
  Dias: Integer;
begin
  Dias := DaysBetween(DateIni.Date, DateFinal.Date);
  if Dias >= 31 then
  begin
    Application.MessageBox('Data Inicial e Data Final não podem ultrapassar limite de 31 dias de diferença.', 'Atenção',MB_ICONWARNING+MB_OK);
    Exit;
  end;

  DataInicial := FormatDateTime('YYYY-mm-dd', DateIni.Date);
  DataFinal := FormatDateTime('YYYY-mm-dd', DateFinal.Date);
  ThreadExecution;
end;

procedure TFrmSeparadordeXML.CarregarConfiguracao;
begin
  User          := GetConfiguracao('TECNOSPEED', 'User', '');
  Password      := GetConfiguracao('TECNOSPEED', 'Password', '');
  UserEmail     := GetConfiguracao('EMAIL', 'UserEmail', '');
  PasswordEmail := GetConfiguracao('EMAIL', 'PasswordEmail', '');
  HostEmail     := GetConfiguracao('EMAIL', 'Host', '');
  PortEmail     := GetConfiguracao('EMAIL', 'Port', '');
  RequireTLS    := StrToBool(GetConfiguracao('EMAIL', 'RequireTLS', ''));
  NameEmail     := GetConfiguracao('EMAIL', 'Name', '');
  SubjectEmail  := GetConfiguracao('EMAIL', 'Subject', '');
  MessageEmail  := GetConfiguracao('EMAIL', 'Message', '');
end;

procedure TFrmSeparadordeXML.CarregaGrid;
var
  Items: TStringList;
  I: Integer;
begin
  Items := TStringList.Create;
  try
    Items.LoadFromFile(gsAppPath + ARQUIVOUSUARIOS);
    for I := 0 to Pred(Items.Count) do
    begin
      if Items[I].IndexOf('=') > 0 then
      begin
        with ListView1.Items.Add do
        begin
          Caption := Items[I].Split(['='])[0];
          SubItems.Add(Items[I].Split(['='])[1]);
          SubItems.Add(Items[I].Split(['='])[2]);
          SubItems.Add(Items[I].Split(['='])[3]);
          SubItems.Add(Items[I].Split(['='])[4]);
          SubItems.Add(Items[I].Split(['='])[5]);
          SubItems.Add(Items[I].Split(['='])[6]);
        end;
      end;
    end;
  finally
    Items.Free;
  end;
end;

procedure TFrmSeparadordeXML.CarregarRest;
begin
  //Resetando REST para default
  RESTClientConsulta.ResetToDefaults;
  RESTRequestConsulta.ResetToDefaults;
  RESTResponseConsulta.ResetToDefaults;

  //ObterAutenticacaoBasica - Função que passa Usuario e senha para carregar a autenticação das requisições.
  if (User <> EmptyStr) or (Password <> EmptyStr) then
    RESTClientConsulta.Authenticator := THTTPBasicAuthenticator.Create(User, Password)
  else
    raise Exception.Create('Usuário/Senha não configurado!!');

  //Seta qual o Client e Response vai ser utilizado no request.
  RESTRequestConsulta.Client := RESTClientConsulta;
  RESTRequestConsulta.Response := RESTResponseConsulta;
end;

procedure TFrmSeparadordeXML.CarregarRest2;
begin
   //Resetando REST2 para default
  RESTClientBaixa.ResetToDefaults;
  RESTRequestBaixa.ResetToDefaults;
  RESTResponseBaixa.ResetToDefaults;

  //ObterAutenticacaoBasica - Função que passa Usuario e senha para carregar a autenticação das requisições.
  if (User <> EmptyStr) or (Password <> EmptyStr) then
    RESTClientBaixa.Authenticator := THTTPBasicAuthenticator.Create(User, Password)
  else
    raise Exception.Create('Usuário/Senha não configurado!!');

  //Seta qual o Client e Response vai ser utilizado no request.
  RESTRequestBaixa.Client := RESTClientBaixa;
  RESTRequestBaixa.Response := RESTResponseBaixa;
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
    CarregarRest2;
    RESTClientBaixa.ContentType := 'application/json';
    RESTClientBaixa.BaseURL := 'https://managersaas.tecnospeed.com.br:8081';

    RESTRequestBaixa.Resource := '/api/v2/cte/exporta/'+protocolo+'?grupo='+ParametroGrupo+'&cnpj='+ParametroCnpj;
    RESTRequestBaixa.Method := TRESTRequestMethod.rmGET;

    RESTRequestBaixa.Execute;
    if RESTRequestBaixa.Response.StatusCode = 200 then
    begin
      if Pos('EXCEPTION', RESTResponseBaixa.Content) <> 0 then
      begin
          Log.CriarLogMensagem(RESTResponseBaixa.Content + ': CNPJ - ' + ParametroCnpj);
          Exit;
      end;
      response := RESTResponseBaixa.JSONValue as TJSONObject;
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
         Log.CriarLogMensagem('Falha na requisição da consulta para o CNPJ ' + ParametroCnpj + ' - ' + IntToStr(RESTRequestBaixa.Response.StatusCode) +' - ' + RESTRequestBaixa.Response.StatusText);
  except
    on E: Exception do
    begin
      Log.CriarLogException(E);
      raise;
    end;
  end;
end;

function TFrmSeparadordeXML.CriarProtocolo(Grupo, Cnpj: String): String;
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
      RESTClientConsulta.ContentType := 'application/json';
      RESTClientConsulta.BaseURL := 'https://managersaas.tecnospeed.com.br:8081';

      RESTRequestConsulta.Resource := '/api/v2/cte/exporta?grupo='+Grupo+'&cnpj='+Cnpj;
      RESTRequestConsulta.Method := TRESTRequestMethod.rmPOST;

      RESTRequestConsulta.AddBody(objeto.ToString, ContentTypeFromString('application/json'));

      RESTRequestConsulta.Execute;
      if RESTRequestConsulta.Response.StatusCode = 200 then
      begin
        if Pos('EXCEPTION', RESTResponseConsulta.Content) <> 0 then
        begin
          Log.CriarLogMensagem(RESTResponseConsulta.Content + ': CNPJ - ' + Cnpj);
          Exit;
        end;

        response := RESTResponseConsulta.JSONValue as TJSONObject;
        Result := response.GetValue('protocolo').Value;
      end
      else
        Log.CriarLogMensagem('Falha na criação do protocolo: CNPJ - '+Cnpj);
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
Emitente, Tomador, Serie: string;
  cteProc: IXMLNode;
begin
  cteProc := XMLDocument1.ChildNodes.FindNode('cteProc');
  if Assigned(cteProc) then
  begin
    Emitente := TrocaCaracterEspecial(BuscaEmitente,True);  // busca o emitente do CTE
    Tomador := TrocaCaracterEspecial(BuscaTomador,True);    // Identifica qual é o tomador
    Serie := TrocaCaracterEspecial(BuscaSerie(cteProc.ChildNodes.FindNode('protCTe').ChildNodes.FindNode('infProt').ChildNodes.FindNode('chCTe').Text), True); // busca a série do CTE
    MoveFile(PChar(DiretorioDase+'\'+NomeArquivo), PChar((VerificaDiretorioFinal(DiretorioDestino+'\'+Emitente+'\CT-E AUTORIZADO\SÉRIE '+Serie+'\'+Tomador))+'\'+NomeArquivo));
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

procedure TFrmSeparadordeXML.EnviaArquivo(Arquivo: String);
var
  Email: TEmail;
begin
  Email := TEmail.Create;
  try
    Email.Host := HostEmail;
    Email.Port := StrToInt(PortEmail);
    Email.Username := UserEmail;
    Email.Password := PasswordEmail;
    Email.EmailAddress := UserEmail;
    Email.RequireTLS := RequireTLS;
    Email.Name := NameEmail;
    Email.EmailDestiny := ParametroEmail;
    Email.Subject := SubjectEmail;
    Email.Message := MessageEmail;
    Email.EnviarEmail(Arquivo);
  finally
    Email.Free;
  end;
end;

procedure TFrmSeparadordeXML.Eventos(DiretorioDase, DiretorioDestino, NomeArquivo: string );
var
  F2: TSearchRec;
  Emitente, TipoEvento, Serie: string;
  procEventoCTe, infEvento: IXMLNode;
  Ret2: Integer;
begin
  // Resolve os xmls de eventos (cancelamento e carta de correcao) separando carta de correção e cancelamento
  procEventoCTe := XMLDocument1.ChildNodes.FindNode('procEventoCTe');
  if Assigned(procEventoCTe) then
  begin
    infEvento := XMLDocument1.ChildNodes.FindNode('procEventoCTe').ChildNodes.FindNode('eventoCTe').ChildNodes.FindNode('infEvento');
    Emitente := infEvento.ChildNodes.FindNode('CNPJ').Text; // carrega o cnpj do tomador para usar como nome do diretório
    Serie := TrocaCaracterEspecial(BuscaSerie(infEvento.ChildNodes.FindNode('chCTe').Text), True); // busca a série do CTE

    if infEvento.ChildNodes.FindNode('tpEvento').Text = '110110' then
    begin
      TipoEvento := 'CARTA DE CORREÇÃO';
      // move o xml para o diretório do emitente
      MoveFile(PChar(DiretorioDase+'\'+NomeArquivo), PChar((VerificaDiretorioFinal(DiretorioDestino+'\'+Emitente+'\EVENTOS\SÉRIE '+Serie+'\'+TipoEvento))+'\'+NomeArquivo));
    end
    else
    if infEvento.ChildNodes.FindNode('tpEvento').Text = '110111' then
    begin
      TipoEvento := 'CANCELAMENTO';
      // move o xml para o diretório do emitente
      MoveFile(PChar(DiretorioDase+'\'+NomeArquivo), PChar((VerificaDiretorioFinal(DiretorioDestino+'\'+Emitente+'\EVENTOS\SÉRIE '+Serie+'\'+TipoEvento))+'\'+NomeArquivo));

      // procura o xml do cte cancelado e move para o diretorio correto
      Ret2 := FindFirst(DiretorioDase+'\'+infEvento.ChildNodes.FindNode('chCTe').Text+'-cte.xml', faAnyFile, F2);
      if Ret2 = 0 then
        MoveFile(PChar(DiretorioDase+'\'+F2.Name),PChar((VerificaDiretorioFinal(DiretorioDestino+'\'+Emitente+'\CT-E CANCELADO\SÉRIE '+Serie+'\'))+F2.Name));

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
          Eventos(DiretorioTMP, DiretorioXML, F.Name);       // Resolve os xmls de eventos (cancelamento e carta de correcao) separando carta de correção e cancelamento
          CTEs(DiretorioTMP, DiretorioXML, F.Name);          // Resolve os xmls de CTE
        end;
      end;
        Ret := FindNext(F);
    end;
   finally
     FindClose(F);
   end;

  // Resolve os xmls de Inutilização
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
            Inutilizacao(DiretorioInu, DiretorioXML, F.Name);
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
  if VerifyThread then
  begin
    resp := Application.messagebox('Tarefa em execução, deseja finalizar a aplicação ?','Confirma',mb_iconquestion+MB_YESNO);
     case resp of
        idyes:
        begin
          LThread.Terminate;
          LThread.WaitFor;
        end;
        idno:
        begin
          Abort;
        end;
     end;
  end;
  SetEvent(FEvent);
  CloseHandle(FEvent);
  LThreadTimer.Terminate;
  LThreadTimer.WaitFor;
  Application.Terminate;
end;

procedure TFrmSeparadordeXML.FormCreate(Sender: TObject);
begin
  CarregaGrid;
  CarregarConfiguracao;
  DateIni.Date := Now;
  DateFinal.Date := Now;
  VerifyThread := False;
  ThreadExecutionTimer;
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
    MoveFile(PChar(DiretorioDase+'\'+NomeArquivo), PChar((VerificaDiretorioFinal(DiretorioDestino+'\'+Emitente+'\INUTILIZAÇÃO'))+'\'+NomeArquivo));
  end;
end;

procedure TFrmSeparadordeXML.ManipulaGridProtocolo(Total: Boolean);
var
  I: Integer;
  Grupo, Cnpj, Protocolo, EnviaEmail: string;
  TotalRegistros: Boolean;
begin
  if Total then
    TotalRegistros := True
  else
    TotalRegistros := CheckVerify.Checked;

  if CheckEmail.Checked then
    EnviaEmail := 'SIM'
  else
    EnviaEmail := 'NÃO';

  if (ListView1.ItemIndex >= 0) or (TotalRegistros) then
  begin
      for I := 0 to Pred(ListView1.Items.Count) do
      begin
        if (ListView1.Items[I].Selected) or (TotalRegistros) then
        begin
          if ListView1.Items.Item[I].SubItems.Strings[4] <> 'CONSULTANDO' then
          begin
            Grupo := ListView1.Items.Item[I].Caption;
            Cnpj  := ListView1.Items.Item[I].SubItems.Strings[1];
            Protocolo := CriarProtocolo(Grupo, Cnpj);
            if Protocolo <> '' then
            begin
              TThread.Synchronize(TThread.CurrentThread,
              procedure
              begin
                with ListView1.Items[I] do
                begin
                  SubItems[3] := EnviaEmail;
                  SubItems[4] := 'CONSULTANDO';
                  SubItems[5] := Protocolo;
                end;
                TotalUser := TotalUser  + 1;
              end);
            end;
          end;
        end;
      end;
  end
  else
    raise Exception.Create('Selecione um item para o processo.');
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

procedure TFrmSeparadordeXML.ThreadEnd(Sender: TObject);
begin
  if Assigned(TThread(Sender).FatalException) then
    Application.messagebox(PChar(Exception(TThread(Sender).FatalException).Message),'Erro',MB_ICONERROR+MB_OK);
end;

procedure TFrmSeparadordeXML.ThreadExecution;
var
  PrevCur: TCursor;
begin
  if VerifyThread then
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
        ManipulaGridProtocolo(False);
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
begin
  FTimer := 10000;
  FEvent := CreateEvent( nil, false, false, nil );
  LThreadTimer := TThread.CreateAnonymousThread(
    procedure
    begin
      try
        while not LThreadTimer.CheckTerminated do
          try
            try
              if VerificaLoteMensal then
              begin
                ManipulaGridProtocolo(True);
                SetConfiguracao('ULTIMA BAIXA', 'DataBaixaLote', DateToStr(Today));
              end;

              VerificaLoteGrid;
            except
              on E: Exception do
              begin
                Log.CriarLogException(E);
              end;
            end;
          finally
              WaitForSingleObject(FEvent, FTimer);
          end;
      finally
        LThreadTimer.Terminate;
      end;
    end
  );
  LThreadTimer.FreeOnTerminate := False;
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

procedure TFrmSeparadordeXML.VerificaLoteGrid;
var
  I: Integer;
  ProtocoloCliente, DataMod: string;
begin
  for I := 0 to Pred(ListView1.Items.Count) do
  begin
    if LThreadTimer.CheckTerminated then
        Break;
    if ListView1.Items[I].SubItems[4] = 'CONSULTANDO' then
    begin
      ParametroGrupo := ListView1.Items[I].Caption;
      ParametroNome := ListView1.Items[I].SubItems[0];
      ParametroCnpj :=  ListView1.Items[I].SubItems[1];
      ParametroEmail :=  ListView1.Items[I].SubItems[2];
      DisparaEmail :=  ListView1.Items[I].SubItems[3];
      ProtocoloCliente := ListView1.Items[I].SubItems[5];
      if ConsultarProtocolo(ProtocoloCliente) then
      begin
        DataMod := DateTimeToStr(Now);
        AtualizaArquivo(ParametroCnpj, ProtocoloCliente, DataMod);
        TotalUser := TotalUser - 1;
        TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          ListView1.Items[I].SubItems[3] := 'SIM';
          ListView1.Items[I].SubItems[4] := DataMod;
        end);
      end;
    end;
  end;
end;

function TFrmSeparadordeXML.VerificaLoteMensal: Boolean;
var
  PrimeiroDia, PrimeiroDiaAlt, UltimoDiaAlt: TDate;
begin
  Result := False;
  PrimeiroDia := StartOfTheMonth(Date);
  if Today = PrimeiroDia then
  begin
    DataUltimaBaixa := GetConfiguracao('ULTIMA BAIXA', 'DataBaixaLote', '');
    if DataUltimaBaixa = EmptyStr then
      DataUltimaBaixa := DateToStr(Today - 1);

    if Today <> StrToDate(DataUltimaBaixa) then
    begin
      UltimoDiaAlt := PrimeiroDia - 1;
      PrimeiroDiaAlt := StartOfTheMonth(UltimoDiaAlt);
      DataInicial := FormatDateTime('YYYY-mm-dd', PrimeiroDiaAlt);
      DataFinal := FormatDateTime('YYYY-mm-dd', UltimoDiaAlt);
      Result := True;
    end;
  end;
end;

end.
