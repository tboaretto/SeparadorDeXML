unit UntEmail;

interface

  uses
    IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase,
    IdSMTP, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
    IdMessage, System.SysUtils, IdAttachmentFile;

type
  TEmail = class
  private
    LSMPTP: TIdSMTP;
    LMessage: TIdMessage;
    LSocketSSL: TIdSSLIOHandlerSocketOpenSSL;

    FHost: string;
    FPort: Integer;
    FUsername: string;
    FPassword: string;
    FEmailAddress: string;
    FName: string;
    FEmailDestiny: string;
    FSubject: string;
    FMessage: string;
    FRequireTLS: boolean;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure EnviarEmail(arquivo: string);


    property Host: string read FHost write FHost;
    property Port: Integer read FPort write FPort;
    property Username: string read FUsername write FUsername;
    property Password: string read FPassword write FPassword;
    property EmailAddress: string read FEmailAddress write FEmailAddress;
    property Name: string read FName write FName;
    property EmailDestiny: string read FEmailDestiny write FEmailDestiny;
    property Subject: string read FSubject write FSubject;
    property Message: string read FMessage write FMessage;
    property RequireTLS: boolean read FRequireTLS write FRequireTLS;
  end;

implementation

{ TEmail }


procedure TEmail.AfterConstruction;
begin
  inherited;
  LSMPTP := TIdSMTP.Create(nil);
  LMessage := TIdMessage.Create(nil);
  LSocketSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
end;

procedure TEmail.BeforeDestruction;
begin
  LSMPTP.Free;
  LMessage.Free;
  LSocketSSL.Free;
  inherited;
end;

procedure TEmail.EnviarEmail(arquivo: string);
begin
  //Segurança
  with LSocketSSL do
  begin
    with SSLOptions do
    begin
      Mode := sslmClient;
      Method := sslvTLSv1_2;
    end;
  end;

  //SMTP
  with LSMPTP do
  begin
    IOHandler := LSocketSSL;
    Host := FHost;
    Port := FPort;
    AuthType := satDefault;
    UserName := FUsername;
    Password := FPassword;
    if FRequireTLS = True then
      UseTLS := utUseRequireTLS
    else
      UseTLS := utUseImplicitTLS;
  end;

  //Message
  with LMessage do
  begin
    From.Address := EmailAddress;
    from.Name := FName;
    Recipients.Add;
    Recipients.Items[0].Address := FEmailDestiny;
    Subject := FSubject;
    Body.Add(FMessage);
  end;

  if arquivo <> EmptyStr then
    TIdAttachmentFile.Create(LMessage.MessageParts, arquivo);

  try
    try
      LSMPTP.Connect;
      LSMPTP.Send(LMessage);
    except
      raise Exception.Create('Falha ao enviar E-mail!!');
    end;
  finally
    LSMPTP.Disconnect;
  end;
end;

end.
