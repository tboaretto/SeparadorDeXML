unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, Vcl.StdCtrls, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, Vcl.ExtCtrls, REST.Types, System.JSON, REST.Json,
  Vcl.ComCtrls,System.JSON.Types, System.JSON.Writers  ;


type
  TForm1 = class(TForm)
    Roteiro: TPageControl;
    TabSheet1: TTabSheet;
    btnToken: TButton;
    MemoToken: TMemo;
    TabSheet2: TTabSheet;
    btnMot: TButton;
    MemoMotRequest: TMemo;
    memoMot: TMemo;
    Button1: TButton;
    EdtCountry1: TEdit;
    EdtNationalId: TEdit;
    EdtDriverLicenseNumber: TEdit;
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    EdtAreaCode: TEdit;
    EdtPhoneNumber: TEdit;
    EdtPreferential: TEdit;
    EdtTypeId: TEdit;
    EdtBirthDate: TEdit;
    EdtName: TEdit;
    EdtGender: TEdit;
    Memo7: TMemo;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    Button2: TButton;
    BtnPrestador: TButton;
    BtnRoteiro: TButton;
    EdtBranchIdentifier: TEdit;
    EdtOriginIBGECode: TEdit;
    EdtDestinyIBGECode: TEdit;
    EdtRoundTrip: TEdit;
    EdtNote: TEdit;
    EdtTraceIdentifier: TEdit;
    EdtShippingPaymentPlaceType: TEdit;
    EdtHighwayNames: TEdit;
    Memo6: TMemo;
    Memo8: TMemo;
    Memo10: TMemo;
    EdtCountry: TEdit;
    EdtLicensePlate: TEdit;
    EdtVehicleClassification: TEdit;
    EdtVehicleCategory: TEdit;
    EdtVehicleAxles: TEdit;
    EdtType: TEdit;
    EdtVehicleOwnerCountry: TEdit;
    EdtVehicleOwnerNationalId: TEdit;
    EdtRNTRC: TEdit;
    EdtNomeFantasia: TEdit;
    EdtVehicleOwnerType: TEdit;
    EdtVehiclePersonalInformationName: TEdit;
    Memo11: TMemo;
    Memo12: TMemo;
    Memo14: TMemo;
    TabSheet6: TTabSheet;
    BtnIniciarViagem: TButton;
    Memo9: TMemo;
    Memo13: TMemo;
    Memo15: TMemo;
    Button3: TButton;
    Memo16: TMemo;
    Memo17: TMemo;
    Memo18: TMemo;
    BtnParametros: TButton;
    Edtgrant_type: TEdit;
    Edtusername: TEdit;
    Edtpassword: TEdit;
    Edtpartner: TEdit;
    EdtStatusResponse: TEdit;
    BtnExemploMotorista: TButton;
    Label1: TLabel;
    EdtStreet: TEdit;
    EdtAdressNumber: TEdit;
    EdtComplement: TEdit;
    EdtNeighborhood: TEdit;
    EdtZipCode: TEdit;
    EdtStatusResponseMot: TEdit;
    EdtConsultaNome: TEdit;
    MemoMetodoConsultaMot: TMemo;
    MemoRetConsultaMotorista: TMemo;
    BtnExemploRoteiro: TButton;
    EdtHiredCountry: TEdit;
    EdtHiredType: TEdit;
    EdtHiredNationalId: TEdit;
    EdtEmail: TEdit;
    Label4: TLabel;
    EdtHiredAreaCode: TEdit;
    EdtHiredNumber: TEdit;
    EdtHiredPreferential: TEdit;
    EdtHiredTypeId: TEdit;
    Label5: TLabel;
    EdtHiredRNTRC: TEdit;
    EdtINSS: TEdit;
    Label6: TLabel;
    EdtRG: TEdit;
    Label7: TLabel;
    EdtInscricaoEstadual: TEdit;
    EdtInscricaoMunicipal: TEdit;
    EdtHiredNomeFantasia: TEdit;
    EdtOptanteSimplesNacional: TEdit;
    Label8: TLabel;
    EdtHiredStreet: TEdit;
    EdtHiredNumber2: TEdit;
    EdtHiredComplement: TEdit;
    EdtHiredNeighborhood: TEdit;
    EdtHiredZipCode: TEdit;
    Label9: TLabel;
    EdtCompanyName: TEdit;
    Label10: TLabel;
    EdtHiredName: TEdit;
    EdtHiredBirthDate: TEdit;
    EdtLegalDependents: TEdit;
    EdtHiredGender: TEdit;
    EdtFuelVoucherPercentage: TEdit;
    BtnExemploPrestador: TButton;
    procedure btnTokenClick(Sender: TObject);
    procedure btnMotClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BtnRoteiroClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BtnIniciarViagemClick(Sender: TObject);
    procedure BtnPrestadorClick(Sender: TObject);
    procedure BtnParametrosClick(Sender: TObject);
    procedure BtnExemploMotoristaClick(Sender: TObject);
    procedure BtnExemploRoteiroClick(Sender: TObject);
    procedure BtnExemploPrestadorClick(Sender: TObject);

  private

  public

  end;

var
  Form1: TForm1;
  Token1: string ;

implementation

  uses Driver;

{$R *.dfm}

procedure TForm1.btnTokenClick(Sender: TObject);
var
  jsonObject: TJsonObject;
  Token: TJSONValue;
  RESTClient1: TRESTClient;
  RESTRequest1: TRESTRequest;
  RESTResponse1: TRESTResponse;
begin
  try
    RESTClient1 := TRESTClient.Create(nil);
    RESTRequest1 := TRESTRequest.Create(nil);
    RESTResponse1 := TRESTResponse.Create(nil);


    RESTClient1.Accept := 'application/json;q=0.9,text/plain;q=0.9,text/html';
    RESTClient1.ContentType := 'application/x-www-form-urlencoded';
    RESTClient1.AcceptCharset := 'UTF-8';
    RESTClient1.FallbackCharsetEncoding := 'UTF-8';

    RESTRequest1.Accept :=  'application/json;q=0.9,text/plain;q=0.9,text/html';
    RESTRequest1.AcceptCharset := 'UTF-8';
    RESTRequest1.Client :=  RESTClient1;
    RESTRequest1.Timeout := 3000;

    RESTRequest1.Response := RESTResponse1;
    RESTResponse1.ContentType := 'application/json';

    RESTRequest1.Method := TRESTRequestMethod.rmPOST;
    RESTClient1.BaseURL := 'https://qa.repom.com.br';
    RESTRequest1.Resource := '/Repom.Frete.Webapi/token';

    if (Edtgrant_type.Text = 'grant_type') or (Edtgrant_type.Text = '') or
       (Edtusername.Text = 'username')     or (Edtusername.Text = '') or
       (Edtpassword.Text = 'password')     or (Edtpassword.Text = '') or
       (Edtpartner.Text = 'partner')       or (Edtpartner.Text = '') then
    raise Exception.Create('Erro: Todos os parametros devem ser preenchidos');

    RESTRequest1.Params.AddItem('grant_type',Edtgrant_type.Text, pkGETorPOST) ;
    RESTRequest1.Params.AddItem('username',  Edtusername.Text, pkGETorPOST) ;
    RESTRequest1.Params.AddItem('password',  Edtpassword.Text, pkGETorPOST) ;
    RESTRequest1.Params.AddItem('partner',   Edtpartner.Text, pkGETorPOST) ;

    RESTRequest1.Execute;

    EdtStatusResponse.Text :=  IntToStr(RESTRequest1.Response.StatusCode) + ' - ' + RESTRequest1.Response.StatusText;
    jsonObject := TJSONObject.ParseJSONValue(RESTResponse1.Content) as TJSONObject; // convertendo texto para JsonValue
    Token := jsonObject.Get('access_token').JsonValue;
    MemoToken.text :=  Token.Value;
    Token1 := MemoToken.text;
  finally
    RESTClient1.Free;
    RESTRequest1.Free;
    RESTResponse1.Free;
  end;
end;


procedure TForm1.Button1Click(Sender: TObject);
var
  StringWriter:  TStringWriter;
  Writer: TJsonTextWriter;
  RESTClient3: TRESTClient;
  RESTRequest3: TRESTRequest;
  RESTResponse3: TRESTResponse;

begin

{
   Country.Text := 'Country: Brazil';
   EdtNationalId.Text := 'NationalId: 28205959870';
   EdtDriverLicenseNumber.Text := 'DriverLicenseNumber: 00921419070';
   EdtStreet.Text := 'Street: Rua teste';
   EdtAdressNumber.Text := 'Number: 123';
   EdtComplement.Text := 'Complement: casa';
   EdtNeighborhood.Text := 'Neighborhood: Jardim dos Ipes';
   EdtZipCode.Text := 'ZipCode: 17340000';
   EdtAreaCode.Text := 'AreaCode: 14';
   EdtPhoneNumber.Text := 'Number: 99635555';
   EdtPreferential.Text := 'Preferential: true';
   EdtTypeId.Text := 'TypeId: Fixed';
   EdtBirthDate.Text := 'BirthDate: 1980-08-07';
   EdtName.Text := 'Name: Tiago Luiz Boaretto';
   EdtGender.Text := 'Gender: Male';
}
 StringWriter := TStringWriter.Create();
 Writer := TJsonTextWriter.Create(StringWriter);
 try
   Writer.Formatting := TJsonFormatting.Indented;
   Writer.WriteStartObject;
   Writer.WritePropertyName('Country');   Writer.WriteValue(EdtCountry1.Text);
   Writer.WritePropertyName('NationalId');   Writer.WriteValue(EdtNationalId.Text);
   Writer.WritePropertyName('DriverLicenseNumber');   Writer.WriteValue(EdtDriverLicenseNumber.Text);

   Writer.WritePropertyName('Address');
   Writer.WriteStartObject;
     Writer.WritePropertyName('Street'); Writer.WriteValue(EdtStreet.Text);
     Writer.WritePropertyName('Number'); Writer.WriteValue(EdtAdressNumber.Text);
     Writer.WritePropertyName('Complement'); Writer.WriteValue(EdtComplement.Text);
     Writer.WritePropertyName('Neighborhood'); Writer.WriteValue(EdtNeighborhood.Text);
     Writer.WritePropertyName('ZipCode'); Writer.WriteValue(EdtZipCode.Text);
   Writer.WriteEndObject;

   Writer.WritePropertyName('Phones');
   Writer.WriteStartArray;
     Writer.WriteStartObject;
       Writer.WritePropertyName('AreaCode'); Writer.WriteValue(EdtAreaCode.Text);
       Writer.WritePropertyName('Number'); Writer.WriteValue(EdtPhoneNumber.Text);
       Writer.WritePropertyName('Preferential'); Writer.WriteValue(true);
       Writer.WritePropertyName('TypeId'); Writer.WriteValue(EdtTypeId.Text);
     Writer.WriteEndObject;
   Writer.WriteEndArray;

   Writer.WritePropertyName('DriverPersonalInformation');
     Writer.WriteStartObject;
       Writer.WritePropertyName('BirthDate'); Writer.WriteValue(EdtBirthDate.Text);
       Writer.WritePropertyName('Name'); Writer.WriteValue(EdtName.Text);
       Writer.WritePropertyName('Gender'); Writer.WriteValue(EdtGender.Text);
     Writer.WriteEndObject;
  Writer.WriteEndObject;

    RESTClient3 := TRESTClient.Create(nil);
    RESTClient3.Accept := 'application/json;q=0.9,text/plain;q=0.9,text/html';

    RESTClient3.ContentType := 'application/json';
    RESTClient3.AcceptCharset := 'UTF-8';
    RESTClient3.FallbackCharsetEncoding := 'UTF-8';

    RESTRequest3 := TRESTRequest.Create(nil);
    RESTRequest3.Accept :=  'application/json;q=0.9,text/plain;q=0.9,text/html';
    RESTRequest3.AcceptCharset := 'UTF-8';
    RESTRequest3.Client :=  RESTClient3;
    RESTRequest3.Timeout := 3000;

    RESTResponse3 := TRESTResponse.Create(nil);
    RESTRequest3.Response := RESTResponse3;
    RESTResponse3.ContentType := 'application/json';
    RESTRequest3.Method := TRESTRequestMethod.rmPOST;
    RESTClient3.BaseURL := 'https://qa.repom.com.br';

    RESTRequest3.Params.Clear;
    RESTRequest3.Resource := '/Repom.Frete.Webapi/Driver';

//    MemoAuth.Text :=  RESTRequest3.Params.AddHeader('Authorization', 'Bearer ' + MemoToken.text).ToString;
    RESTRequest3.Params.AddHeader('Authorization', 'Bearer ' + MemoToken.text);
    RESTRequest3.Params.ParameterByName('Authorization').Options := [poDoNotEncode];


    RESTRequest3.Params.Add;
    RESTRequest3.Params[1].ContentType := ctAPPLICATION_JSON;
    RESTRequest3.Params[1].Kind := pkREQUESTBODY;
    RESTRequest3.Params[1].Value := StringWriter.ToString;

    Memo7.Text:= RESTRequest3.Params[1].ToString;

    RESTRequest3.Resource := RESTRequest3.Resource + '?x-api-version=V2.2';

    MemoMotRequest.Text := RESTRequest3.Resource;

    RESTRequest3.Execute;

    EdtStatusResponseMot.Text := IntToStr(RESTRequest3.Response.StatusCode) + ' - '+  RESTRequest3.Response.StatusText;
    memoMot.text :=  RESTResponse3.Content;

 finally

//    Memo5.Text :=   StringWriter.ToString;
 end;




end;

procedure TForm1.Button2Click(Sender: TObject);
var
  StringWriter3:  TStringWriter;
  Writer3: TJsonTextWriter;
  RESTClient5: TRESTClient;
  RESTRequest5: TRESTRequest;
  RESTResponse5: TRESTResponse;

begin
  EdtCountry.text := 'Country: Brazil';
  EdtLicensePlate.text := 'LicensePlate: string';
  EdtVehicleClassification.text := 'VehicleClassification: Implement';
  EdtVehicleCategory.text := 'VehicleCategory: CommercialLightweight';
  EdtVehicleAxles.text := 'VehicleAxles: Axle01';
  EdtType.text := 'Type: CityDelivery';
  EdtVehicleOwnerCountry.text := 'VehicleOwnerCountry: Brazil';
  EdtVehicleOwnerNationalId.text := 'VehicleOwnerNationalId: string';
  EdtRNTRC.text := 'RNTRC: string';
  EdtNomeFantasia.text := 'NomeFantasia: string';
  EdtVehicleOwnerType.text := 'VehicleOwnerType: Person';
  EdtVehiclePersonalInformationName.text := 'VehiclePersonalInformationName: string';

 StringWriter3 := TStringWriter.Create();
 Writer3 := TJsonTextWriter.Create(StringWriter3);
 try
   Writer3.Formatting := TJsonFormatting.Indented;
   Writer3.WriteStartObject;
     Writer3.WritePropertyName('Country');   Writer3.WriteValue('Brazil');
     Writer3.WritePropertyName('LicensePlate');   Writer3.WriteValue('XXX1111');
     Writer3.WritePropertyName('VehicleClassification');   Writer3.WriteValue('Implement');
     Writer3.WritePropertyName('VehicleCategory');   Writer3.WriteValue('CommercialLightweight');
     Writer3.WritePropertyName('VehicleAxles');   Writer3.WriteValue('Axle01');
     Writer3.WritePropertyName('Type');   Writer3.WriteValue('CityDelivery');

     Writer3.WritePropertyName('VehicleOwner');
     Writer3.WriteStartObject;
       Writer3.WritePropertyName('Country'); Writer3.WriteValue('Brazil');
       Writer3.WritePropertyName('NationalId'); Writer3.WriteValue('28205959870');

       Writer3.WritePropertyName('BrazilianSettings');
       Writer3.WriteStartObject;
         Writer3.WritePropertyName('RNTRC'); Writer3.WriteValue('123456789');
         Writer3.WritePropertyName('VehiclePessoaJuridica');
         Writer3.WriteStartObject;
           Writer3.WritePropertyName('NomeFantasia'); Writer3.WriteValue('Sialog XX');
         Writer3.WriteEndObject;
       Writer3.WriteEndObject;

       Writer3.WritePropertyName('Type'); Writer3.WriteValue('Person');
       Writer3.WritePropertyName('VehiclePersonalInformation');
       Writer3.WriteStartObject;
         Writer3.WritePropertyName('Name'); Writer3.WriteValue('Tiago XX');
       Writer3.WriteEndObject;

     Writer3.WriteEndObject;
   Writer3.WriteEndObject;

  RESTClient5 := TRESTClient.Create(nil);
  RESTClient5.Accept := 'application/json;q=0.9,text/plain;q=0.9,text/html';

  RESTClient5.ContentType := 'application/json';
  RESTClient5.AcceptCharset := 'UTF-8';
  RESTClient5.FallbackCharsetEncoding := 'UTF-8';

  RESTRequest5 := TRESTRequest.Create(nil);
  RESTRequest5.Accept :=  'application/json;q=0.9,text/plain;q=0.9,text/html';
  RESTRequest5.AcceptCharset := 'UTF-8';
  RESTRequest5.Client :=  RESTClient5;
  RESTRequest5.Timeout := 3000;

  RESTResponse5 := TRESTResponse.Create(nil);
  RESTRequest5.Response := RESTResponse5;
  RESTResponse5.ContentType := 'application/json';
  RESTRequest5.Method := TRESTRequestMethod.rmPOST;
  RESTClient5.BaseURL := 'https://qa.repom.com.br';

  RESTRequest5.Params.Clear;
  RESTRequest5.Resource := '/Repom.Frete.Webapi/Vehicle';

//  Memo13.Text :=  RESTRequest5.Params.AddHeader('Authorization', 'Bearer ' + MemoToken.text).ToString;
  RESTRequest5.Params.AddHeader('Authorization', 'Bearer ' + MemoToken.text);
  RESTRequest5.Params.ParameterByName('Authorization').Options := [poDoNotEncode];


    RESTRequest5.Params.Add;
    RESTRequest5.Params[1].ContentType := ctAPPLICATION_JSON;
    RESTRequest5.Params[1].Kind := pkREQUESTBODY;
    RESTRequest5.Params[1].Value := StringWriter3.ToString;

    Memo12.Text:= RESTRequest5.Params[1].ToString;

    RESTRequest5.Resource := RESTRequest5.Resource + '?x-api-version=V2.2';

    MemoMotRequest.Text := RESTRequest5.Resource;

    RESTRequest5.Execute;

    Memo11.Text := RESTRequest5.Response.StatusText;
    Memo14.text :=  RESTResponse5.Content;



 finally

 end;




end;

procedure TForm1.BtnParametrosClick(Sender: TObject);
begin
  Edtgrant_type.Text := 'password'      ;   //'grant_type',, pkGETorPOST).ToString ;
  Edtusername.Text   := ''              ;   //'username '  ,, pkGETorPOST).ToString ;
  Edtpassword.Text   := ''              ;   //'password '  ,, pkGETorPOST).ToString ;
  Edtpartner.Text    := ''              ;   //'partner '   ,, pkGETorPOST).ToString ;
  // OBS: Os dados de acesso estão em um txt com o Tiago
  // D:\GoogleDrive\Tboaretto_Sialog_com_br\Pessoal\Dados_Integracao_Repom.txt

end;

procedure TForm1.BtnPrestadorClick(Sender: TObject);
var
  StringWriter5:  TStringWriter;
  Writer5: TJsonTextWriter;
  RESTClient7: TRESTClient;
  RESTRequest7: TRESTRequest;
  RESTResponse7: TRESTResponse;
begin

 StringWriter5 := TStringWriter.Create();
 Writer5 := TJsonTextWriter.Create(StringWriter5);
 try
   Writer5.Formatting := TJsonFormatting.Indented;
   Writer5.WriteStartObject;
     Writer5.WritePropertyName('Country');   Writer5.WriteValue(EdtHiredCountry.text);
     Writer5.WritePropertyName('HiredType');   Writer5.WriteValue(EdtHiredType.text);
     Writer5.WritePropertyName('NationalId');   Writer5.WriteValue(EdtHiredNationalId.text);
//     Writer5.WritePropertyName('Email');   Writer5.WriteValue(EdtEmail.text);


     Writer5.WritePropertyName('Phones');
     Writer5.WriteStartArray;
       Writer5.WriteStartObject;
         Writer5.WritePropertyName('AreaCode'); Writer5.WriteValue(EdtHiredAreaCode.text);
         Writer5.WritePropertyName('Number'); Writer5.WriteValue(EdtHiredNumber.text);
         Writer5.WritePropertyName('Preferential'); Writer5.WriteValue(true);
         Writer5.WritePropertyName('TypeId'); Writer5.WriteValue(EdtHiredTypeId.text);
       Writer5.WriteEndObject;
     Writer5.WriteEndArray;

     Writer5.WritePropertyName('BrazilianSettings');
       Writer5.WriteStartObject;
         Writer5.WritePropertyName('RNTRC'); Writer5.WriteValue(EdtHiredRNTRC.text);
         Writer5.WritePropertyName('HiredPessoaFisica');
         Writer5.WriteStartObject;
           Writer5.WritePropertyName('INSS'); Writer5.WriteValue(EdtINSS.text);
           Writer5.WritePropertyName('RG'); Writer5.WriteValue(EdtRG.text);
         Writer5.WriteEndObject;

         Writer5.WritePropertyName('HiredPessoaJuridica');
         Writer5.WriteStartObject;
           Writer5.WritePropertyName('InscricaoEstadual'); Writer5.WriteValue(EdtInscricaoEstadual.text);
           Writer5.WritePropertyName('InscricaoMunicipal'); Writer5.WriteValue(EdtInscricaoMunicipal.text);
           Writer5.WritePropertyName('NomeFantasia'); Writer5.WriteValue(EdtHiredNomeFantasia.text);
           Writer5.WritePropertyName('OptanteSimplesNacional'); Writer5.WriteValue(True);
         Writer5.WriteEndObject;
       Writer5.WriteEndObject;

//     Writer5.WritePropertyName('Address');
//       Writer5.WriteStartObject;
//         Writer5.WritePropertyName('Street'); Writer5.WriteValue(EdtHiredStreet.text);
//         Writer5.WritePropertyName('Number'); Writer5.WriteValue(EdtHiredNumber2.text);
//         Writer5.WritePropertyName('Complement'); Writer5.WriteValue(EdtHiredComplement.text);
//         Writer5.WritePropertyName('Neighborhood'); Writer5.WriteValue(EdtHiredNeighborhood.text);
//         Writer5.WritePropertyName('ZipCode'); Writer5.WriteValue(EdtHiredZipCode.text);
//       Writer5.WriteEndObject;

//     Writer5.WritePropertyName('CompanyInformation');
//       Writer5.WriteStartObject;
//         Writer5.WritePropertyName('CompanyName'); Writer5.WriteValue(EdtCompanyName.text);
//       Writer5.WriteEndObject;

//     Writer5.WritePropertyName('HiredPersonalInformation');
//       Writer5.WriteStartObject;
//         Writer5.WritePropertyName('Name'); Writer5.WriteValue(EdtHiredName.text);
//         Writer5.WritePropertyName('BirthDate'); Writer5.WriteValue(EdtHiredBirthDate.text);
//         Writer5.WritePropertyName('LegalDependents'); Writer5.WriteValue(EdtLegalDependents.text);
//         Writer5.WritePropertyName('Gender'); Writer5.WriteValue(EdtHiredGender.text);
//       Writer5.WriteEndObject;
//     Writer5.WritePropertyName('FuelVoucherPercentage'); Writer5.WriteValue(EdtFuelVoucherPercentage.text);
   Writer5.WriteEndObject;

  RESTClient7 := TRESTClient.Create(nil);
  RESTClient7.Accept := 'application/json;q=0.9,text/plain;q=0.9,text/html';

  RESTClient7.ContentType := 'application/json';
  RESTClient7.AcceptCharset := 'UTF-8';
  RESTClient7.FallbackCharsetEncoding := 'UTF-8';

  RESTRequest7 := TRESTRequest.Create(nil);
  RESTRequest7.Accept :=  'application/json;q=0.9,text/plain;q=0.9,text/html';
  RESTRequest7.AcceptCharset := 'UTF-8';
  RESTRequest7.Client :=  RESTClient7;
  RESTRequest7.Timeout := 3000;

  RESTResponse7 := TRESTResponse.Create(nil);
  RESTRequest7.Response := RESTResponse7;
  RESTResponse7.ContentType := 'application/json';
  RESTRequest7.Method := TRESTRequestMethod.rmPOST;
  RESTClient7.BaseURL := 'https://qa.repom.com.br';

  RESTRequest7.Params.Clear;
  RESTRequest7.Resource := '/Repom.Frete.Webapi/Hired';

//  Memo9.Text :=  RESTRequest4.Params.AddHeader('Authorization', 'Bearer ' + MemoToken.text).ToString;
  RESTRequest7.Params.AddHeader('Authorization', 'Bearer ' + MemoToken.text);
  RESTRequest7.Params.ParameterByName('Authorization').Options := [poDoNotEncode];


    RESTRequest7.Params.Add;
    RESTRequest7.Params[1].ContentType := ctAPPLICATION_JSON;
    RESTRequest7.Params[1].Kind := pkREQUESTBODY;
    RESTRequest7.Params[1].Value := StringWriter5.ToString;

    Memo18.Text:= RESTRequest7.Params[1].ToString;

    RESTRequest7.Resource := RESTRequest7.Resource + '?x-api-version=V2.2';

    MemoMotRequest.Text := RESTRequest7.Resource;

    RESTRequest7.Execute;

    Memo16.Text :=  IntToStr(RESTRequest7.Response.StatusCode) + ' - ' +  RESTRequest7.Response.StatusText;
    Memo17.text :=  RESTResponse7.Content;



 finally
//    RESTClient7.Free;
//    RESTRequest7.Free;
//    RESTResponse7.Free;
 end;

end;

procedure TForm1.BtnRoteiroClick(Sender: TObject);
var
  RESTClient4: TRESTClient;
  RESTRequest4: TRESTRequest;
  RESTResponse4: TRESTResponse;
  StringWriter2:  TStringWriter;
  Writer2: TJsonTextWriter;
begin
 StringWriter2 := TStringWriter.Create();
 Writer2 := TJsonTextWriter.Create(StringWriter2);
 try
   Writer2.Formatting := TJsonFormatting.Indented;
   Writer2.WriteStartObject;
     Writer2.WritePropertyName('BranchIdentifier');   Writer2.WriteValue(edtBranchIdentifier.Text);
     Writer2.WritePropertyName('OriginIBGECode');   Writer2.WriteValue(EdtOriginIBGECode.Text);
     Writer2.WritePropertyName('DestinyIBGECode');   Writer2.WriteValue(EdtDestinyIBGECode.Text);
     Writer2.WritePropertyName('RoundTrip');   Writer2.WriteValue(true);
     Writer2.WritePropertyName('Note');   Writer2.WriteValue(EdtNote.Text);
     Writer2.WritePropertyName('TraceIdentifier');   Writer2.WriteValue(EdtTraceIdentifier.Text);
     Writer2.WritePropertyName('ShippingPaymentPlaceType');   Writer2.WriteValue(EdtShippingPaymentPlaceType.Text);

     Writer2.WritePropertyName('PreferredWays');
     Writer2.WriteStartArray;
       Writer2.WriteStartObject;
         Writer2.WritePropertyName('HighwayNames'); Writer2.WriteValue(EdtHighwayNames.Text);
       Writer2.WriteEndObject;
     Writer2.WriteEndArray;
   Writer2.WriteEndObject;

  RESTClient4 := TRESTClient.Create(nil);
  RESTClient4.Accept := 'application/json;q=0.9,text/plain;q=0.9,text/html';

  RESTClient4.ContentType := 'application/json';
  RESTClient4.AcceptCharset := 'UTF-8';
  RESTClient4.FallbackCharsetEncoding := 'UTF-8';

  RESTRequest4 := TRESTRequest.Create(nil);
  RESTRequest4.Accept :=  'application/json;q=0.9,text/plain;q=0.9,text/html';
  RESTRequest4.AcceptCharset := 'UTF-8';
  RESTRequest4.Client :=  RESTClient4;
  RESTRequest4.Timeout := 3000;

  RESTResponse4 := TRESTResponse.Create(nil);
  RESTRequest4.Response := RESTResponse4;
  RESTResponse4.ContentType := 'application/json';
  RESTRequest4.Method := TRESTRequestMethod.rmPOST;
  RESTClient4.BaseURL := 'https://qa.repom.com.br';

  RESTRequest4.Params.Clear;
  RESTRequest4.Resource := '/Repom.Frete.Webapi/RouteRequest';

//  Memo9.Text :=  RESTRequest4.Params.AddHeader('Authorization', 'Bearer ' + MemoToken.text).ToString;
  RESTRequest4.Params.AddHeader('Authorization', 'Bearer ' + MemoToken.text);
  RESTRequest4.Params.ParameterByName('Authorization').Options := [poDoNotEncode];


    RESTRequest4.Params.Add;
    RESTRequest4.Params[1].ContentType := ctAPPLICATION_JSON;
    RESTRequest4.Params[1].Kind := pkREQUESTBODY;
    RESTRequest4.Params[1].Value := StringWriter2.ToString;

    Memo10.Text:= RESTRequest4.Params[1].ToString;

    RESTRequest4.Resource := RESTRequest4.Resource + '?x-api-version=V2.2';

    MemoMotRequest.Text := RESTRequest4.Resource;

    RESTRequest4.Execute;

    Memo6.Text :=  IntToStr(RESTRequest4.Response.StatusCode) + ' - ' + RESTRequest4.Response.StatusText;
    Memo8.text :=  RESTResponse4.Content;

 finally
   RESTClient4.Free;
   RESTRequest4.Free;
   RESTResponse4.Free;
 end;

end;

procedure TForm1.BtnExemploMotoristaClick(Sender: TObject);
begin
   EdtCountry1.Text := 'Brazil'; //Country:
   EdtNationalId.Text := '28205959870'; //NationalId:
   EdtDriverLicenseNumber.Text := '00921419070'; //DriverLicenseNumber:
   EdtStreet.Text := 'Rua teste'; //Street:
   EdtAdressNumber.Text := '123'; //Number:
   EdtComplement.Text := 'casa'; // Complement:
   EdtNeighborhood.Text := 'Jardim dos Ipes'; //Neighborhood:
   EdtZipCode.Text := '17340000'; //ZipCode:
   EdtAreaCode.Text := '14'; // AreaCode:
   EdtPhoneNumber.Text := '99635555'; //Number:
   EdtPreferential.Text := 'true'; //Preferential:
   EdtTypeId.Text := 'Fixed'; //TypeId:
   EdtBirthDate.Text := '1980-08-07'; //BirthDate:
   EdtName.Text := 'Tiago Luiz Boaretto'; //Name:
   EdtGender.Text := 'Male'; //Gender:
end;

procedure TForm1.BtnExemploPrestadorClick(Sender: TObject);
begin

  EdtHiredCountry.text := 'Brazil';                    //'Country'
  EdtHiredType.text := 'Person';                       //'HiredType'
  EdtHiredNationalId.text := '28205959870';            //'NationalId'
  EdtEmail.text := 'tboaretto@sialog.com.br';          //'Email'
                                                      //'Phones'
  EdtHiredAreaCode.text := '14';                       //'AreaCode'
  EdtHiredNumber.text := '99635888';                   //'Number'
  EdtHiredPreferential.text := 'true';                 //'Preferential'
  EdtHiredTypeId.text := 'Cell';                      //'TypeId'
                                                      //'BrazilianSettings'
  EdtHiredRNTRC.text := '123456789';                   //'RNTRC'
                                                      //'HiredPessoaFisica'
  EdtINSS.text := '123456879';                         //'INSS'
  EdtRG.text := '288071567';                           //'RG'
                                                      //'HiredPessoaJuridica'
  EdtInscricaoEstadual.text := '12345665445';          //'InscricaoEstadual'
  EdtInscricaoMunicipal.text := '1234565465';          //'InscricaoMunicipal'
  EdtHiredNomeFantasia.text := 'Sialog Hired';         //'NomeFantasia'
  EdtOptanteSimplesNacional.text := 'True';              //'OptanteSimplesNacional'
                                                      //'Address'
  EdtHiredStreet.text := 'Av Industrial';              //'Street'
  EdtHiredNumber2.text := '360';                      //'Number'
  EdtHiredComplement.text := 'xxx';                    //'Complement'
  EdtHiredNeighborhood.text := 'Distrito Industrial';  //'Neighborhood'
  EdtHiredZipCode.text := '17340000';                 //'ZipCode'
                                                      //'CompanyInformation'
  EdtCompanyName.text := 'Sialog XXXXXX';              //'CompanyName'
                                                      //'HiredPersonalInformation'
  EdtHiredName.text := 'Tiago';                        //'Name'
  EdtHiredBirthDate.text := '1980-07-08';              //'BirthDate'
  EdtLegalDependents.text := '1';                      //'LegalDependents'
  EdtHiredGender.text := 'Male';                       //'Gender'
  EdtFuelVoucherPercentage.text := '10';               //'FuelVoucherPercentage'
end;

procedure TForm1.BtnExemploRoteiroClick(Sender: TObject);
begin
  edtBranchIdentifier.Text := '1'; //BranchIdentifier:
  EdtOriginIBGECode.Text :=  '1100106'; //OriginIBGECode:
  EdtDestinyIBGECode.Text := '1300201'; //DestinyIBGECode:
  EdtRoundTrip.Text := 'true'; //RoundTrip:
  EdtNote.Text := 'alguma nota'; //Note:
  EdtTraceIdentifier.Text := 'BR 171'; //TraceIdentifier:
  EdtShippingPaymentPlaceType.Text := 'Branch'; //ShippingPaymentPlaceType:
  EdtHighwayNames.Text := 'Rodovia xxx645'; //HighwayNames:
end;

procedure TForm1.BtnIniciarViagemClick(Sender: TObject);
var
  StringWriter4:  TStringWriter;
  Writer4: TJsonTextWriter;
  RESTClient6: TRESTClient;
  RESTRequest6: TRESTRequest;
  RESTResponse6: TRESTResponse;
begin

 StringWriter4 := TStringWriter.Create();
 Writer4 := TJsonTextWriter.Create(StringWriter4);
 try
   Writer4.Formatting := TJsonFormatting.Indented;
   Writer4.WriteStartArray;
   Writer4.WriteStartObject;
     Writer4.WritePropertyName('Identifier');   Writer4.WriteValue('1');
     Writer4.WritePropertyName('Country');   Writer4.WriteValue('Brazil');
     Writer4.WritePropertyName('HiredCountry');   Writer4.WriteValue('Brazil');
     Writer4.WritePropertyName('HiredNationalId');   Writer4.WriteValue('28205959870');
     Writer4.WritePropertyName('OperationIdentifier');   Writer4.WriteValue('1');
//     Writer4.WritePropertyName('CardNumber');   Writer4.WriteValue(0);
//     Writer4.WritePropertyName('VPRCardNumber');   Writer4.WriteValue(0);
//     Writer4.WritePropertyName('BrazilianRouteTraceCode');   Writer4.WriteValue(0);
     Writer4.WritePropertyName('BrazilianRouteRouteCode');   Writer4.WriteValue(0);
     Writer4.WritePropertyName('IssueDate');   Writer4.WriteValue('2020-08-26T14:37:26.912Z');
     Writer4.WritePropertyName('TotalFreightValue');   Writer4.WriteValue(1);
     Writer4.WritePropertyName('TotalLoadWeight');   Writer4.WriteValue(1);
     Writer4.WritePropertyName('TotalLoadValue');   Writer4.WriteValue(1);
     Writer4.WritePropertyName('AdvanceMoneyValue');   Writer4.WriteValue(0);

 //    Writer4.WritePropertyName('VPR');
 //      Writer4.WriteStartObject;
 //        Writer4.WritePropertyName('Issue'); Writer4.WriteValue(true);
 //        Writer4.WritePropertyName('VPROneWay'); Writer4.WriteValue(0);
 //        Writer4.WritePropertyName('VPRSuspendedAxleNumber'); Writer4.WriteValue(0);
 //        Writer4.WritePropertyName('VPRReturnSuspendedAxleNumber'); Writer4.WriteValue(0);
 //      Writer4.WriteEndObject;

     Writer4.WritePropertyName('ShippingPayment');
       Writer4.WriteStartObject;
         Writer4.WritePropertyName('ExpectedDeliveryDate'); Writer4.WriteValue('2020-08-26T14:37:26.912Z');
         Writer4.WritePropertyName('ExpectedDeliveryLocationType'); Writer4.WriteValue('Branch');
       Writer4.WriteEndObject;

     Writer4.WritePropertyName('Drivers');
     Writer4.WriteStartArray;
       Writer4.WriteStartObject;
         Writer4.WritePropertyName('Country'); Writer4.WriteValue('Brazil');
         Writer4.WritePropertyName('NationalId'); Writer4.WriteValue('28205959870');
         Writer4.WritePropertyName('Main'); Writer4.WriteValue(true);
       Writer4.WriteEndObject;
     Writer4.WriteEndArray;

//     Writer4.WritePropertyName('Documents');
//     Writer4.WriteStartArray;
//       Writer4.WriteStartObject;
//         Writer4.WritePropertyName('BranchCode'); Writer4.WriteValue('1');
//         Writer4.WritePropertyName('DocumentType'); Writer4.WriteValue('CTE');
//         Writer4.WritePropertyName('Series'); Writer4.WriteValue('1');
//         Writer4.WritePropertyName('Number'); Writer4.WriteValue('654');
//         Writer4.WritePropertyName('EletronicKey'); Writer4.WriteValue('35200855188619000163570010001701311003032763');
//       Writer4.WriteEndObject;
//     Writer4.WriteEndArray;


     Writer4.WritePropertyName('Vehicles');
     Writer4.WriteStartArray;
       Writer4.WriteStartObject;
         Writer4.WritePropertyName('Country'); Writer4.WriteValue('Brazil');
         Writer4.WritePropertyName('LicensePlate'); Writer4.WriteValue('XXX1111');
       Writer4.WriteEndObject;
     Writer4.WriteEndArray;

{     Writer4.WritePropertyName('AccountingAdjustments');
     Writer4.WriteStartArray;
       Writer4.WriteStartObject;
         Writer4.WritePropertyName('Identifier'); Writer4.WriteValue('1');
         Writer4.WritePropertyName('Value'); Writer4.WriteValue(0.00);
       Writer4.WriteEndObject;
     Writer4.WriteEndArray;
     }

     Writer4.WritePropertyName('BranchCode'); Writer4.WriteValue('1');
     Writer4.WritePropertyName('LoadBrazilianNCM'); Writer4.WriteValue('9706');
     Writer4.WritePropertyName('LoadBrazilianANTTCodeType'); Writer4.WriteValue(1);

//     Writer4.WritePropertyName('ShippingReceiver');
//       Writer4.WriteStartObject;
//         Writer4.WritePropertyName('Country'); Writer4.WriteValue('Brazil');
//         Writer4.WritePropertyName('NationalId'); Writer4.WriteValue('28205959870');
//         Writer4.WritePropertyName('Name'); Writer4.WriteValue('Tiago');
//         Writer4.WritePropertyName('ReceiverType'); Writer4.WriteValue('pERSON');
//       Writer4.WriteEndObject;

     Writer4.WritePropertyName('BrazilianIBGECodeSource'); Writer4.WriteValue('1234567');
     Writer4.WritePropertyName('BrazilianIBGECodeDestination'); Writer4.WriteValue('1234578');
     Writer4.WritePropertyName('BrazilianCEPSource'); Writer4.WriteValue('17340000');
     Writer4.WritePropertyName('BrazilianCEPDestination'); Writer4.WriteValue('17350000');
     Writer4.WritePropertyName('TravelledDistance'); Writer4.WriteValue(10);

//     Writer4.WritePropertyName('Taxes');
//     Writer4.WriteStartArray;
//       Writer4.WriteStartObject;
//         Writer4.WritePropertyName('Type'); Writer4.WriteValue('IRRF');
//         Writer4.WritePropertyName('Value'); Writer4.WriteValue(0.00);
//       Writer4.WriteEndObject;
//     Writer4.WriteEndArray;

   Writer4.WriteEndObject;
   Writer4.WriteEndArray;

  RESTClient6 := TRESTClient.Create(nil);
  RESTClient6.Accept := 'application/json;q=0.9,text/plain;q=0.9,text/html';

  RESTClient6.ContentType := 'application/json';
  RESTClient6.AcceptCharset := 'UTF-8';
  RESTClient6.FallbackCharsetEncoding := 'UTF-8';

  RESTRequest6 := TRESTRequest.Create(nil);
  RESTRequest6.Accept :=  'application/json;q=0.9,text/plain;q=0.9,text/html';
  RESTRequest6.AcceptCharset := 'UTF-8';
  RESTRequest6.Client :=  RESTClient6;
  RESTRequest6.Timeout := 3000;

  RESTResponse6 := TRESTResponse.Create(nil);
  RESTRequest6.Response := RESTResponse6;
  RESTResponse6.ContentType := 'application/json';
  RESTRequest6.Method := TRESTRequestMethod.rmPOST;
  RESTClient6.BaseURL := 'https://qa.repom.com.br';

  RESTRequest6.Params.Clear;
  RESTRequest6.Resource := '/Repom.Frete.Webapi/Shipping';

//  Memo13.Text :=  RESTRequest5.Params.AddHeader('Authorization', 'Bearer ' + MemoToken.text).ToString;
  RESTRequest6.Params.AddHeader('Authorization', 'Bearer ' + MemoToken.text);
  RESTRequest6.Params.ParameterByName('Authorization').Options := [poDoNotEncode];


    RESTRequest6.Params.Add;
    RESTRequest6.Params[1].ContentType := ctAPPLICATION_JSON;
    RESTRequest6.Params[1].Kind := pkREQUESTBODY;
    RESTRequest6.Params[1].Value := StringWriter4.ToString;

    Memo9.Text:= RESTRequest6.Params[1].ToString;

    RESTRequest6.Resource := RESTRequest6.Resource + '?x-api-version=V2.2';

    MemoMotRequest.Text := RESTRequest6.Resource;

    RESTRequest6.Execute;

    Memo13.Text := RESTRequest6.Response.StatusText;
    Memo15.text :=  RESTResponse6.Content;



 finally

 end;

end;

procedure TForm1.btnMotClick(Sender: TObject);
var
  RESTClient2: TRESTClient;
  RESTRequest2: TRESTRequest;
  RESTResponse2: TRESTResponse;
begin
  try
    MemoMetodoConsultaMot.Lines.Clear;
    MemoRetConsultaMotorista.Lines.Clear;

    RESTClient2 := TRESTClient.Create(nil);
    RESTClient2.Accept := 'application/json;q=0.9,text/plain;q=0.9,text/html';

    RESTClient2.ContentType := 'application/json';
    RESTClient2.AcceptCharset := 'UTF-8';
    RESTClient2.FallbackCharsetEncoding := 'UTF-8';

    RESTRequest2 := TRESTRequest.Create(nil);
    RESTRequest2.Accept :=  'application/json;q=0.9,text/plain;q=0.9,text/html';
    RESTRequest2.AcceptCharset := 'UTF-8';
    RESTRequest2.Client :=  RESTClient2;
    RESTRequest2.Timeout := 3000;

    RESTResponse2 := TRESTResponse.Create(nil);
    RESTRequest2.Response := RESTResponse2;
    RESTResponse2.ContentType := 'application/json';
    RESTRequest2.Method := TRESTRequestMethod.rmGET;
    RESTClient2.BaseURL := 'https://qa.repom.com.br';

    RESTRequest2.Params.Clear;
    RESTRequest2.Resource := '/Repom.Frete.Webapi/Driver/Byname';

//    MemoAuth.Text :=  RESTRequest2.Params.AddHeader('Authorization', 'Bearer ' + MemoToken.text).ToString;
    RESTRequest2.Params.AddHeader('Authorization', 'Bearer ' + MemoToken.text);
    RESTRequest2.Params.ParameterByName('Authorization').Options := [poDoNotEncode];

//    RESTRequest2.Resource := RESTRequest2.Resource + '/Tiago Luiz Boaretto?x-api-version=V2.2';

    RESTRequest2.Resource := RESTRequest2.Resource + '/'+EdtConsultaNome.Text+'?x-api-version=V2.2';
//    RESTRequest2.Resource := RESTRequest2.Resource + '/Luiz Boaretto?x-api-version=V2.2';
    MemoMetodoConsultaMot.Text := RESTRequest2.Resource;
    RESTRequest2.Execute;

//    MemoStatMot.Text := RESTRequest2.Response.StatusText;
    MemoRetConsultaMotorista.text :=  RESTResponse2.Content;
  finally
    RESTClient2.Free;
    RESTRequest2.Free;
    RESTResponse2.Free;
  end;


end;

end.
