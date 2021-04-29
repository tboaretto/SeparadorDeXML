unit AuxiliarIntegracaoMobile;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, Vcl.StdCtrls, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, Vcl.ExtCtrls, REST.Types, System.JSON, REST.Json,
  Vcl.ComCtrls,System.JSON.Types, System.JSON.Writers, System.Classes ;


type
  TForm1 = class(TForm)
    TabSheet1: TTabSheet;
    btnAutenticar: TButton;
    MemoToken: TMemo;
    EdtStatusResponse: TEdit;
    pgc1: TPageControl;
    procedure btnAutenticarClick(Sender: TObject);

  private
    procedure CarregarRest;

  public


  end;


var
  Form1: TForm1;
  Token1: string ;
  RESTClientMobile: TRESTClient;
  RESTRequestMobile: TRESTRequest;
  RESTResponseMobile: TRESTResponse;

implementation

//uses
//  ClassHired;



{$R *.dfm}

procedure TForm1.btnAutenticarClick(Sender: TObject);
begin
  try
    CarregarRest;
    RESTRequestMobile.Method := TRESTRequestMethod.rmPOST;
//    RESTRequestMobile.Resource := '/api/v1/import_edocs';

    RESTRequestMobile.Execute;

    EdtStatusResponse.Text :=  IntToStr(RESTRequestMobile.Response.StatusCode) + ' - ' + RESTRequestMobile.Response.StatusText;
    MemoToken.text :=  RESTResponseMobile.Content;
  finally
  end;
end;

procedure TForm1.CarregarRest;
begin

  RESTClientMobile := TRESTClient.Create(nil);
  RESTRequestMobile := TRESTRequest.Create(nil);
  RESTResponseMobile := TRESTResponse.Create(nil);

  RESTClientMobile.ResetToDefaults;
  RESTRequestMobile.ResetToDefaults;
  RESTResponseMobile.ResetToDefaults;

  RESTClientMobile.Accept := 'application/json;q=0.9,text/plain;q=0.9,text/html';
  RESTClientMobile.ContentType := 'application/json';
  RESTClientMobile.AcceptCharset := 'UTF-8';
  RESTClientMobile.FallbackCharsetEncoding := 'UTF-8';
  RESTClientMobile.BaseURL := 'https://app.swaggerhub.com/apis-docs/Daniel-Jr/MSEdocs/1.0.0#/';

  RESTRequestMobile.Accept :=  'application/json;q=0.9,text/plain;q=0.9,text/html';
  RESTRequestMobile.AcceptCharset := 'UTF-8';
  RESTRequestMobile.Client :=  RESTClientMobile;
  RESTRequestMobile.Timeout := 3000;

  RESTResponseMobile := TRESTResponse.Create(nil);
  RESTRequestMobile.Response := RESTResponseMobile;
  RESTResponseMobile.ContentType := 'application/json';
end;


end.
