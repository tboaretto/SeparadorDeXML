unit UntAutenticarMobile;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  REST.Client, REST.Types, IPPeerClient,


  Data.Bind.Components, Data.Bind.ObjectScope, Vcl.ExtCtrls, Vcl.ComCtrls;
//  System.JSON, REST.Json,
//  Vcl.ComCtrls,System.JSON.Types, System.JSON.Writers


type
  TForm1 = class(TForm)
    PgcMobile: TPageControl;
    TsAutenticar: TTabSheet;
    btnAutenticar: TButton;
    EdtStatusResponse: TEdit;
    mm1: TMemo;
    BtnCarregar: TButton;
    EdtLoad: TEdit;
    procedure btnAutenticarClick(Sender: TObject);
    procedure BtnCarregarClick(Sender: TObject);
  private
    procedure CarregarRest;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  RESTClientMobile: TRESTClient;
  RESTRequestMobile: TRESTRequest;
  RESTResponseMobile: TRESTResponse;


implementation

{$R *.dfm}

{ TForm1 }

procedure TForm1.btnAutenticarClick(Sender: TObject);
begin
  try
    CarregarRest;
    RESTRequestMobile.Method := TRESTRequestMethod.rmPOST;
    RESTRequestMobile.Resource := '/api/v1/import_edocs';


    RESTRequestMobile.Params.AddHeader('Authorization', 'Bearer ' + '3acbb786-1204-4e38-8dbc-2784efe337a3');
    RESTRequestMobile.Params.AddHeader('subdomain', 'logtech');
    RESTRequestMobile.Params.AddHeader('Content-Type', 'application/json');


    RESTRequestMobile.Params.Add;
    RESTRequestMobile.Params[1].ContentType := ctAPPLICATION_JSON;
    RESTRequestMobile.Params[1].Kind := pkREQUESTBODY;
    RESTRequestMobile.Params[1].Value := mm1.Text;
//    RESTRequestMobile.Accept := 'text/xml';
//    RESTRequestMobile.Accept := 'application/json';
    RESTRequestMobile.Execute;


    EdtStatusResponse.Text :=  IntToStr(RESTRequestMobile.Response.StatusCode) + ' - ' + RESTRequestMobile.Response.StatusText;
//    MemoToken.text :=  RESTResponseMobile.Content;
//    MemoToken.text :=  RESTResponseMobile.Content +  RESTRequestMobile.Resource


  finally
  end;
end;

procedure TForm1.BtnCarregarClick(Sender: TObject);
begin
   mm1.Lines.LoadFromFile(EdtLoad.Text);
end;

procedure TForm1.CarregarRest;
begin
  try
    RESTClientMobile := TRESTClient.Create(nil);
    RESTRequestMobile := TRESTRequest.Create(nil);
    RESTResponseMobile := TRESTResponse.Create(nil);

    RESTClientMobile.ResetToDefaults;
    RESTRequestMobile.ResetToDefaults;
    RESTResponseMobile.ResetToDefaults;

    RESTClientMobile.Accept := 'application/json;q=0.9,text/plain;q=0.9,text/html';
    RESTClientMobile.ContentType := 'application/json';

//    RESTClientMobile.ContentType := 'application/x-www-form-urlencoded';


//    Content-Type:

    RESTClientMobile.AcceptCharset := 'UTF-8';
    RESTClientMobile.FallbackCharsetEncoding := 'UTF-8';
    RESTClientMobile.BaseURL := 'edocs.neofleet.app';

    RESTRequestMobile.Accept :=  'application/json;q=0.9,text/plain;q=0.9,text/html';
    RESTRequestMobile.AcceptCharset := 'UTF-8';
    RESTRequestMobile.Client :=  RESTClientMobile;
    RESTRequestMobile.Timeout := 3000;


    RESTResponseMobile := TRESTResponse.Create(nil);
    RESTRequestMobile.Response := RESTResponseMobile;
    RESTResponseMobile.ContentType := 'application/json';
//    RESTResponseMobile.ContentType := 'application/x-www-form-urlencoded';
  finally

  end;

end;

end.
