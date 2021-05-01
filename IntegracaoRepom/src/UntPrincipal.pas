unit UntPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.TabControl, Datasnap.DBClient, System.Generics.Collections,
  REST.Client, REST.Types, FMX.ScrollBox, FMX.Memo, IPPeerClient;

type
  TForm2 = class(TForm)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    BtnToken: TButton;
    BtnParToken: TButton;
    Edit1: TEdit;
    MemoToken: TMemo;
    EdtOperationalKey: TEdit;
    Label1: TLabel;
    EdtToken: TEdit;
    LblToken: TLabel;
    BtnConsulta: TButton;
    MemoConsulta: TMemo;
    procedure BtnTokenClick(Sender: TObject);
    procedure BtnConsultaClick(Sender: TObject);
  private
  procedure CarregarRest;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  Token1: string ;
  RESTClientRepom: TRESTClient;
  RESTRequestRepom: TRESTRequest;
  RESTResponseRepom: TRESTResponse;


implementation

uses
  System.JSON;

{$R *.fmx}

procedure TForm2.BtnConsultaClick(Sender: TObject);
var
  StringWriterMot:  TStringWriter;
  CDSContatoMotorista, CDSMotorista: TClientDataSet;
begin

  CarregarRest;
  RESTRequestRepom.Method := TRESTRequestMethod.rmGET;

  RESTRequestRepom.Params.Clear;
  RESTRequestRepom.Resource := '/Repom.Frete.Webapi/Shipping/StatusProcessing/ByOperationKey/';

  RESTRequestRepom.Params.AddHeader('Authorization', 'Bearer ' + EdtToken.Text);
  RESTRequestRepom.Params.ParameterByName('Authorization').Options := [poDoNotEncode];

  RESTRequestRepom.Params.Add;
  RESTRequestRepom.Params[1].ContentType := ctAPPLICATION_JSON;
  RESTRequestRepom.Params[1].Kind := pkREQUESTBODY;
  RESTRequestRepom.Resource := RESTRequestRepom.Resource + EdtOperationalKey.Text + '?x-api-version=V2.2';

  RESTRequestRepom.Execute;
  MemoConsulta.Lines.Add  (RESTResponseRepom.Content);

end;

procedure TForm2.BtnTokenClick(Sender: TObject);
var
  jsonObject: TJsonObject;
  TokenRetorno, JSonValue: TJsonValue;
begin
  CarregarRest;
  RESTRequestRepom.Method := TRESTRequestMethod.rmPOST;
  RESTRequestRepom.Resource := '/Repom.Frete.Webapi/token';

  RESTRequestRepom.Params.AddItem('grant_type','password', pkGETorPOST);
  RESTRequestRepom.Params.AddItem('username','2593', pkGETorPOST);
  RESTRequestRepom.Params.AddItem('password','Repom10Repom10', pkGETorPOST);
  RESTRequestRepom.Params.AddItem('partner','30854029000100', pkGETorPOST);
  RESTRequestRepom.Execute;
  if RESTRequestRepom.Response.StatusCode <> 200 then
     raise Exception.Create('Falha de comunicação com a API '+ RESTResponseRepom.Content);
  jsonObject := TJSONObject.ParseJSONValue(RESTResponseRepom.Content) as TJSONObject; // convertendo texto para JsonValue
  JSonValue := TJSONObject.ParseJSONValue(RESTResponseRepom.Content);

//  RESTResponseRepom.Content := GetJSONFormat.Indented;
//  JSonValue := GetJSONFormat.Indented;

  RESTResponseRepom.Content;
  TokenRetorno := jsonObject.Get('access_token').JsonValue;
  EdtToken.Text := TokenRetorno.Value;
  MemoToken.Lines.Add  (RESTResponseRepom.Content);

end;

procedure TForm2.CarregarRest;
begin
  try
    RESTClientRepom := TRESTClient.Create(nil);
    RESTRequestRepom := TRESTRequest.Create(nil);
    RESTResponseRepom := TRESTResponse.Create(nil);

    RESTClientRepom.ResetToDefaults;
    RESTRequestRepom.ResetToDefaults;
    RESTResponseRepom.ResetToDefaults;

    RESTClientRepom.Accept := 'application/json;q=0.9,text/plain;q=0.9,text/html';
    RESTClientRepom.ContentType := 'application/json';

    RESTClientRepom.AcceptCharset := 'UTF-8';
    RESTClientRepom.FallbackCharsetEncoding := 'UTF-8';
    RESTClientRepom.BaseURL := 'qa.repom.com.br';

    RESTRequestRepom.Accept :=  'application/json;q=0.9,text/plain;q=0.9,text/html';
    RESTRequestRepom.AcceptCharset := 'UTF-8';

    RESTRequestRepom.Client :=  RESTClientRepom;
    RESTRequestRepom.Timeout := 3000;

    RESTResponseRepom := TRESTResponse.Create(nil);
    RESTRequestRepom.Response := RESTResponseRepom;
    RESTResponseRepom.ContentType := 'application/json';
  finally

  end;
end;

end.
