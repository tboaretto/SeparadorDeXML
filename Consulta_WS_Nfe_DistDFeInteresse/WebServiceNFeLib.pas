unit WebServiceNFeLib;

interface

uses
  SysUtils, Capicom, AssociativeArray, DBXJSON, System.JSON;

type
  TServiceConfig = record
    URL: string;
    Service: string;
    Envelope: string;
  end;

  TWebServiceProvider = class
  const
    NFE_CONFIG_FILE = 'NFeConfig.json';
    SERVICE_NFE_DISTRIBUICAODFE = 'nfeDistDFeInteresse';
  private
    FConfig: TJSONObject;

    function GetLoaded: Boolean;
  public
    procedure BeforeDestruction; override;

    function GetServiceConfig(UF, Service: string): TServiceConfig;
    function SelectCertificate(SerialNumber: string): ICertificate2;

    function LoadConfig(ConfigFile: TFilename): Boolean;
    property ConfigLoaded: Boolean read GetLoaded;
  end;

  TWebService = class
  const
    IBGE_UF_SIGLA: array[1..27] of string = ('RO', 'AC', 'AM', 'RR', 'PA', 'AP', 'TO', 'MA', 'PI', 'CE', 'RN', 'PB', 'PE', 'AL', 'SE', 'BA', 'MG', 'ES', 'RJ', 'SP', 'PR', 'SC', 'RS', 'MS', 'MT', 'GO', 'DF');
    IBGE_UF_CODIGO: array[1..27] of Byte = (11, 12, 13, 14, 15, 16, 17, 21, 22, 23, 24, 25, 26, 27, 28, 29, 31, 32, 33, 35, 41, 42, 43, 50, 51, 52, 53);
  private
    function PrepareSoapEnvelope(Envelope: string; Params: TAssocArray): string;
  protected
    function SOAPRequest(UF, Service, CertificateSerialNumber: string; Params: TAssocArray; out Response: string): Boolean;
    function ConvertUF(UF: Integer): string; overload;
    function ConvertUF(UF: string): Integer; overload;
  end;

  TWebServiceNFeLib = class(TWebService)
  public
    function NFeDistribuicaoDFe(UF, CNPJ, NSU, SerialNumber: string; out Response: string): Integer;
  end;

implementation

uses
  Classes, Generics.Collections, SOAPClient, EncdDecd, JSONHelper, ActiveX;

{ TWebServiceProvider }

function TWebServiceProvider.GetLoaded: Boolean;
begin
  Result := Assigned(FConfig);
end;

procedure TWebServiceProvider.BeforeDestruction;
begin
  FConfig.Free;
end;

function TWebServiceProvider.GetServiceConfig(UF, Service: string): TServiceConfig;
begin
  if not ConfigLoaded then
    LoadConfig(NFE_CONFIG_FILE);

  Result.Envelope := StringOf(DecodeBase64(AnsiString(FConfig.GetObj('envelopes').GetValue(Service))));
  Result.URL := FConfig.GetObj('services').GetValue(Service);
  Result.Service := Service;
end;

function TWebServiceProvider.LoadConfig(ConfigFile: TFilename): Boolean;
var
  Stream: TStringStream;
begin
  Stream := TStringStream.Create;
  try
    Stream.LoadFromFile(ConfigFile);
    FConfig := TJSONObject(TJSONObject.ParseJSONValue(Stream.DataString));
    Result := Assigned(FConfig);
  finally
    Stream.Free;
  end;
end;

function TWebServiceProvider.SelectCertificate(SerialNumber: string): ICertificate2;
var
  CertList: ICertificates2;
  CertificateTmp: ICertificate2;
  i: integer;
  Store: TStore;
begin
  Result := nil;
  CoInitialize(nil);
  Store := TStore.Create(nil);
  try
    Store.Open(CAPICOM_CURRENT_USER_STORE, 'My', CAPICOM_STORE_OPEN_MAXIMUM_ALLOWED);
    CertList := Store.Certificates as ICertificates2;

    for i := 1 to CertList.Count do
    begin
      CertificateTmp := IInterface(CertList.Item[i]) as ICertificate2;
      if CertificateTmp.SerialNumber = UpperCase(SerialNumber) then
        Exit(CertificateTmp);
    end;
  finally
    Store.Close;
    Store.Free;
    CoUninitialize;
  end;
end;

{ TWebService }

function TWebService.ConvertUF(UF: string): Integer;
var
  Index: Integer;
begin
  Result := 0;
  for Index := 1 to 27 do
    if IBGE_UF_SIGLA[Index] = UF then
    begin
      Result := IBGE_UF_CODIGO[Index];
      Break;
    end;
end;

function TWebService.ConvertUF(UF: Integer): string;
var
  Index: Integer;
begin
  Result := '';
  for Index := 1 to 27 do
    if IBGE_UF_CODIGO[Index] = UF then
    begin
      Result := IBGE_UF_SIGLA[Index];
      Break;
    end;
end;

function TWebService.PrepareSoapEnvelope(Envelope: string; Params: TAssocArray): string;
var
  Item: TPair<string,Variant>;
begin
  Result := Envelope;
  if Assigned(Params) then
    for Item in Params do
      Result := StringReplace(Result, '{' + Item.Key + '}', Item.Value, [rfReplaceAll]);
end;

function TWebService.SOAPRequest(UF, Service, CertificateSerialNumber: string; Params: TAssocArray; out Response: string): Boolean;
var
  SOAP: TSOAPClient;
  Config: TServiceConfig;
  WebServiceProvider: TWebServiceProvider;
begin
  WebServiceProvider := TWebServiceProvider.Create;
  Config := WebServiceProvider.GetServiceConfig(UF, Service);
  SOAP := TSOAPClient.Create(nil, Config.URL, Config.Service, Config.Service + 'Soap12');
  try
    SOAP.A3Certificate := WebServiceProvider.SelectCertificate(CertificateSerialNumber);
    if SOAP.A3Certificate = nil then
    begin
      Response := 'Certificado não encontrado!';
      Exit(False);
    end;

    SOAP.Request.WriteString(PrepareSoapEnvelope(Config.Envelope, Params));
    SOAP.Execute;
    Response := SOAP.Response.DataString;
    Result := True;
  finally
    SOAP.Free;
    WebServiceProvider.Free;
  end;
end;

{ TWebServiceNFeLib }

function TWebServiceNFeLib.NFeDistribuicaoDFe(UF, CNPJ, NSU, SerialNumber: string; out Response: string): Integer;
var
  Params: TAssocArray;
  WebServiceProvider: TWebServiceProvider;
begin
  Result := 0;

  Params := TAssocArray.Create;
  WebServiceProvider := TWebServiceProvider.Create;
  try
    Params.Add('UF', ConvertUF(UF));
    Params.Add('CNPJ', CNPJ);
    Params.Add('NSU', NSU);
    if not SOAPRequest(UF, WebServiceProvider.SERVICE_NFE_DISTRIBUICAODFE, SerialNumber, Params, Response) then
      Result := 1;
  finally
    Params.Free;
    WebServiceProvider.Free;
  end;
end;

end.
