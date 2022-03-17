program Proj_Consulta_WS_Nfe_DistDFeInteresse;

uses
  Vcl.Forms,
  Consulta_WS_Nfe_DistDFeInteresse in 'Consulta_WS_Nfe_DistDFeInteresse.pas' {Frm},
  WebServiceNFe in 'WebServiceNFe.pas',
  clsSLGXMLDocument in 'clsSLGXMLDocument.pas',
  WebServiceNFeLib in 'WebServiceNFeLib.pas',
  AssociativeArray in 'AssociativeArray.pas',
  Capicom in 'Capicom.pas',
  SQLWriter in 'SQLWriter.pas',
  SOAPClient in 'SOAPClient.pas',
  JSONHelper in 'JSONHelper.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrm, Frm);
  Application.Run;
end.
