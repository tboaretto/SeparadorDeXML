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
    LbTxtToken: TLabeledEdit;
    TbTxtSubDomain: TLabeledEdit;
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
var
 aplication, json, v1: string;
begin
  try
    CarregarRest;

    RESTRequestMobile.Method := TRESTRequestMethod.rmPOST;
    RESTRequestMobile.Resource := '/api/v1/import_edocs';

//    RESTRequestMobile.Params.AddHeader('Authorization', 'Bearer ' + LbTxtToken.Text);
//    RESTRequestMobile.Params.ParameterByName('Authorization').Options := [poDoNotEncode];

//    RESTRequestMobile.Params.AddHeader('subdomain',TbTxtSubDomain.Text );


    RESTRequestMobile.Params.Add;
    RESTRequestMobile.Params[0].ContentType := ctAPPLICATION_JSON;
    RESTRequestMobile.Params[0].Kind := pkHTTPHEADER;
    RESTRequestMobile.Params[0].name := 'Authorization';
    RESTRequestMobile.Params[0].Options := [poDoNotEncode];
    RESTRequestMobile.Params[0].value := 'Bearer ' + LbTxtToken.Text;


    RESTRequestMobile.Params.Add;
    //    RESTRequestMobile.Params.AddHeader('subdomain',TbTxtSubDomain.Text );
    RESTRequestMobile.Params[1].ContentType := ctAPPLICATION_JSON;
    RESTRequestMobile.Params[1].Kind := pkHTTPHEADER;
    RESTRequestMobile.Params[1].name := 'subdomain';
//    RESTRequestMobile.Params[1].Options := [poDoNotEncode];
    RESTRequestMobile.Params[1].value := TbTxtSubDomain.Text;

    RESTRequestMobile.Params.Add;
    RESTRequestMobile.Params[2].ContentType := ctAPPLICATION_JSON;
    RESTRequestMobile.Params[2].Kind := pkHTTPHEADER;
    RESTRequestMobile.Params[2].name := 'Content-Type';
    RESTRequestMobile.Params[2].value := 'application/json';

    RESTRequestMobile.Params.Add;
    RESTRequestMobile.Params[3].ContentType := ctAPPLICATION_JSON;
    RESTRequestMobile.Params[3].Kind := pkREQUESTBODY;
    RESTRequestMobile.Params[3].Value := mm1.Text;


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

    RESTClientMobile.AcceptCharset := 'UTF-8';
//    RESTClientMobile.FallbackCharsetEncoding := 'UTF-8';
//    RESTClientMobile.Accept := 'application/json;q=0.9,text/plain;q=0.9,text/html';
//    RESTClientMobile.ContentType := 'application/x-www-form-urlencoded';
//    RESTClientMobile.ContentType := 'application/json';

//    RESTClientMobile.AcceptCharset := 'UTF-8';
//    RESTClientMobile.FallbackCharsetEncoding := 'UTF-8';
    RESTClientMobile.BaseURL := 'edocs.neofleet.app';

//    RESTRequestMobile.Accept :=  'application/json;q=0.9,text/plain;q=0.9,text/html';
//    RESTRequestMobile.ContentType := 'application/x-www-form-urlencoded';
//    RESTRequestMobile.AcceptCharset := 'UTF-8';
    RESTRequestMobile.Client :=  RESTClientMobile;
    RESTRequestMobile.Timeout := 3000;

    RESTResponseMobile := TRESTResponse.Create(nil);
    RESTRequestMobile.Response := RESTResponseMobile;
//    RESTResponseMobile.ContentType := 'application/x-www-form-urlencoded';
//    RESTResponseMobile.ContentType := 'application/json';

  finally

  end;

end;

end.
