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
    MemoToken: TMemo;
    procedure btnAutenticarClick(Sender: TObject);
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


//    RESTRequestMobile.Params.AddItem('subdomain','uplog', pkGETorPOST);

//    RESTRequestMobile.Params.AddHeader('Authorization', 'Bearer ' + '670da548-03fc-45d3-ad24-24b6dc021aad');
    RESTRequestMobile.Params.AddHeader('Authorization', 'Bearer ' + '670da548-03fc-45d3-ad24-24b6dc021aad');

//    RESTRequestMobile.Params.ParameterByName('Authorization').Options := [poDoNotEncode];


    RESTRequestMobile.Params.Add;
    RESTRequestMobile.Params[1].ContentType := ctAPPLICATION_JSON;
    RESTRequestMobile.Params[1].Kind := pkREQUESTBODY;

    RESTRequestMobile.Execute;


    EdtStatusResponse.Text :=  IntToStr(RESTRequestMobile.Response.StatusCode) + ' - ' + RESTRequestMobile.Response.StatusText;
    MemoToken.text :=  RESTResponseMobile.Content;
//    MemoToken.text :=  RESTResponseMobile.Content +  RESTRequestMobile.Resource


  finally
  end;
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
  finally

  end;

end;

end.
