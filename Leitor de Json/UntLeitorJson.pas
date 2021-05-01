unit UntLeitorJson;

interface

uses
  System.Types, System.UITypes, System.Classes, System.Variants, System.JSON,
  System.JSON.Readers,System.JSON.Types, FMX.Types, FMX.Controls, FMX.Forms,
  FMX.Graphics, FMX.Dialogs,  FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.ScrollBox, FMX.Memo, FMX.Edit, REST.Json;


type
  TFrmLeitorJson = class(TForm)
    BtnCriarJsonRepom: TButton;
    Panel1: TPanel;
    MemoJson: TMemo;
    BtnJsonReader: TButton;
    EdtObjeto: TEdit;
    EdtResult: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure BtnCriarJsonRepomClick(Sender: TObject);
    procedure BtnJsonReaderClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLeitorJson: TFrmLeitorJson;

implementation

uses
  System.SysUtils;

{$R *.fmx}

procedure TFrmLeitorJson.BtnCriarJsonRepomClick(Sender: TObject);
var
    JsonObjResponse, JsonObjResult, JsonObjResults, JsonStatuscode, JsonErrorCode : TJSONObject;
    JsonArrayResults, JsonArrayErrors: TJSONArray;
begin
  try

    JsonObjResponse := TJSONObject.Create;
      JsonObjResult := TJSONObject.Create;
     JsonStatuscode := TJSONObject.Create;
        JsonStatuscode.AddPair('StatusCode', TJSONNumber.Create(200));

        JsonObjResults := TJSONObject.Create;
        JsonObjResult.AddPair('OperationKey', 'c95097d8-78cc-493d-b429-5ef029e07f8c');

          JsonArrayResults := TJSONArray.Create;
            JsonObjResults := TJSONObject.Create;
            JsonObjResults.AddPair('Identifier', '1');
            JsonObjResults.AddPair('Status', 'Error');

            JsonArrayErrors := TJSONArray.Create;
              JsonErrorCode :=  TJSONObject.Create;
              JsonErrorCode.AddPair('ErrorCode', '35'); JsonErrorCode.AddPair('Message', 'Roteiro não informado');
              JsonErrorCode.AddPair('ErrorCode', '35'); JsonErrorCode.AddPair('Message', 'Roteiro 0 Percurso 0 não encontrado');
              JsonErrorCode.AddPair('ErrorCode', '35'); JsonErrorCode.AddPair('Message', 'Obrigatório informar Cartão');
              JsonErrorCode.AddPair('ErrorCode', '35'); JsonErrorCode.AddPair('Message', 'Destinatário é obrigatório para emissão de CIOT: Não foram informados Documento Fiscal e Nome');
              JsonErrorCode.AddPair('ErrorCode', '35'); JsonErrorCode.AddPair('Message', '\"2-SEST\" não informado. Verifique o parâmetro \"SEST\".');
            JsonArrayErrors.AddElement(JsonErrorCode);
            JsonObjResults.AddPair('Errors',JsonArrayErrors);
        JsonArrayResults.AddElement(JsonObjResults);


        JsonObjResult.AddPair('Results',JsonArrayResults);
      JsonObjResponse.AddPair('Response',JsonStatuscode);
      JsonObjResponse.AddPair('Result',JsonObjResult);

    MemoJson.Text := TJSON.Format(JsonObjResponse);
  finally
    JsonObjResponse.DisposeOf;
  end;



end;

procedure TFrmLeitorJson.BtnJsonReaderClick(Sender: TObject);
var
  StringReader : TStringReader;
  JsonReader: TJSONTextReader;
begin
  try
    StringReader := TStringReader.Create(trim(MemoJson.Text ));
    try
      JsonReader := TJsonTextReader.Create(StringReader);
      while JsonReader.Read do
      begin
        if JsonReader.TokenType = tjsontoken.PropertyName then
        begin
          if JsonReader.Value.ToString = EdtObjeto.Text then
          begin
            JsonReader.Read;
//            EdtResult.Text:= '';
            EdtResult.Text:= JsonReader.Value.ToString;
          end;
        end;
      end;
    finally
      JsonReader.Free;
    end;
  finally
    StringReader.Free;
  end;

end;




end.
