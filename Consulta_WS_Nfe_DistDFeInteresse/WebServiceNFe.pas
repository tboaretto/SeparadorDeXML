unit WebServiceNFe;

interface

uses untSLGBase, clsSLGXMLDocument;

type
  TWebServiceNFe = class(TObject)
  private
    FXMLDir: string;
    procedure ExtrairXML(XMLDocument: TSLGXMLDocument);
  public
    property XMLDir: string read FXMLDir write FXMLDir;
    function Execute(UF, CNPJ, NSU, SerialNumber: string; ExecuteOnce: Boolean = False): string;
  end;

implementation

uses SysUtils, DBClient, XMLIntf, EncdDecd, WebServiceNFeLib,
     SQLWriter, Classes;

{ TWebServiceNFe }

function TWebServiceNFe.Execute(UF, CNPJ, NSU, SerialNumber: string; ExecuteOnce: Boolean = False): string;
var
  NodeUltNSU, NodeMaxNSU: IXMLNode;
  WebServiceNFeLib: TWebServiceNFeLib;
  XMLDocument: TSLGXMLDocument;
  Response: string;
begin
//  try
    WebServiceNFeLib := TWebServiceNFeLib.Create;
//    try
      { Enquanto tiver documentos pra baixar, continua consumindo o WebService
        se o parâmetro ExecuteOnce for passado como True, executará apenas uma vez }
//      repeat
        { Consome o WebService }
        WebServiceNFeLib.NFeDistribuicaoDFe(UF, CNPJ, NSU, SerialNumber, Response);

        Result := Response;
end;

procedure TWebServiceNFe.ExtrairXML(XMLDocument: TSLGXMLDocument);
//var
//  AttributeSchemaValue, BaseDir: string;
//  FileNameZip, FileNameXML: TFileName;
//  BytesStream: TBytesStream;
//  SevenZip: TSevenZip;
//  NodeLote: IXMLNode;
//  i: Integer;
//  GUID: TGUID;
begin
  { Encontra a tag Pai que contém os documentos zipados }
{  if XMLDocument.LocateNode('loteDistDFeInt', NodeLote) then
  begin
    BaseDir := ExtractFilePath(ParamStr(0));
    FXMLDir := BaseDir + 'tmp\consulta nfe\';
    ForceDirectories(FXMLDir);
    SevenZip := TSevenZip.Create(BaseDir + '7z.exe');
    try
      { Percorre todos os nodes Filhos transformando-os em arquivos .7z;
        logo após, descompacta os arquivos, os renomeia para .xml e deleta os arquivos zip originais }
{      for i := 0 to NodeLote.ChildNodes.Count -1 do
      begin
        { Verifica se o schema da NFe é um "Evento" ou "resNFe", se for, não o salva }
{        AttributeSchemaValue := NodeLote.ChildNodes[i].Attributes['schema'];
        if (Pos('Evento', AttributeSchemaValue) > 0) or (Pos('resNFe', AttributeSchemaValue) > 0) then
          Continue;

        BytesStream := TBytesStream.Create(DecodeBase64(AnsiString(NodeLote.ChildNodes[i].NodeValue)));
        GUID := TGUID.NewGuid;
        try
          FileNameZip := FXMLDir + GUIDToString(GUID) + '.7z';
          BytesStream.SaveToFile(FileNameZip);
          SevenZip.UnzipFile(FileNameZip);
          DeleteFile(FileNameZip);
          FileNameXML := FXMLDir + GUIDToString(GUID);
          RenameFile(FileNameXML, FileNameXML + '.xml');
        finally
          BytesStream.Free;
        end;
      end;
    finally
      SevenZip.Free;
    end;
  end;      }
end;

{procedure TWebServiceNFe.UpdateA1Certificates(EmpagCodigo, CodigoEmpresa, NSU: string);
var
  CDS: TClientDataSet;
  SQLFields, SQLFilters: TSQLParam;
begin
  CDS := DB.InstanciarDataSet;
  SQLFields := TSQLParam.Create;
  SQLFilters := TSQLParam.Create;

  try
    SQLFields.Add('ULTNSU', NSU);
    SQLFilters.Add('EMPAGCODIGO', EmpagCodigo);
    SQLFilters.Add('CODIGOEMPRESA', CodigoEmpresa);

    CDS.CommandText := SQLWriter.updateSQL('a1certificates', SQLFields, SQLFilters, False);
    CDS.Execute;
  finally
    DB.DestruirDataSet(CDS);
    SQLFields.Free;
    SQLFilters.Free;
  end;
end;}

end.
