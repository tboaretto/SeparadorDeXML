unit SOAPClient;

interface

uses
  Classes, SysUtils, SOAPHTTPClient, SOAPHTTPTrans, CertHelper, WinINet, Capicom, Windows, WebNode;

const
  INTERNET_OPTION_CLIENT_CERT_CONTEXT = 84;

type
  TSoapTraceEvent = procedure(TraceData: string) of object;

  TSOAPClient = class
  private
    FCertificate: ICertificate2;
    FRIO: THTTPRIO;
    FRequest: TStringStream;
    FResponse: TStringStream;
    FOnTrace: TSoapTraceEvent;

    procedure HookCertificate(const HTTPReqResp: THTTPReqResp; Data: Pointer);
    procedure SetCertificate(Request: Pointer);
    procedure DoTrace(Trace: string);
  public
    constructor Create(AOwner: TComponent; URL, Service, Port: string); reintroduce;
    destructor Destroy; override;

    procedure Execute;

    property Request: TStringStream read FRequest;
    property Response: TStringStream read FResponse;
    property A3Certificate: ICertificate2 read FCertificate write FCertificate;
    property OnTrace: TSoapTraceEvent read FOnTrace write FOnTrace;
  end;

implementation

{ TSOAPClient }

procedure TSOAPClient.HookCertificate(const HTTPReqResp: THTTPReqResp; Data: Pointer);
begin
  SetCertificate(Data);
end;

procedure TSOAPClient.SetCertificate(Request: Pointer);
var
  CertContext: ICertContext;
  PCertContext: PCCERT_CONTEXT;
begin
  if Assigned(FCertificate) then
  begin
    CertContext := FCertificate as ICertContext;
    CertContext.Get_CertContext(Integer(PCertContext));

    if not InternetSetOption(Request, INTERNET_OPTION_CLIENT_CERT_CONTEXT, PCertContext, SizeOf(CERT_CONTEXT)) then
      RaiseLastOSError;
  end;
end;

constructor TSOAPClient.Create(AOwner: TComponent; URL, Service, Port: string);
begin
  inherited Create;

  FRequest := TStringStream.Create;
  FResponse := TStringStream.Create;

  FRIO := THTTPRIO.Create(AOwner);
  FRIO.URL := URL;
  FRIO.Service := Service;
  FRIO.Port := Port;
  FRIO.WebNode.Options := [wnoSOAP12];

  FRIO.HTTPWebNode.OnBeforePost := HookCertificate;
end;

destructor TSOAPClient.Destroy;
begin
  inherited;
  FRIO.Free;
  FRequest.Free;
  FResponse.Free;
end;


procedure TSOAPClient.DoTrace(Trace: string);
begin
  if Assigned(FOnTrace) then
    FOnTrace(Trace);
end;

procedure TSOAPClient.Execute;
begin
  FRequest.Seek(0, soFromBeginning);
  FResponse.Clear;
  DoTrace(Request.DataString);
  FRIO.HTTPWebNode.Execute(FRequest, FResponse);
  DoTrace(Response.DataString);
end;

end.
