unit Consulta_WS_Nfe_DistDFeInteresse;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Xml.XMLDoc, Xml.XMLIntf,
  Xml.xmldom;

type
  TFrm = class(TForm)
    lblserialnumber: TLabel;
    lblultnsu: TLabel;
    lbluf: TLabel;
    lblempagcnpj: TLabel;
    edtSerialNumber: TEdit;
    edtultnsu: TEdit;
    edtuf: TEdit;
    edtempagcnpj: TEdit;
    btnEnviar: TButton;
    mmoresponse: TMemo;
    XMLDocument1: TXMLDocument;
    btnLimpar: TButton;

    procedure btnEnviarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm: TFrm;

implementation

uses WebServiceNFe, {untServerBD,} SQLWriter, {untLib_DB,} {SysUtils,} {Windows,} {Logger,}
     DateUtils, Types;


{$R *.dfm}

procedure TFrm.btnEnviarClick(Sender: TObject);
var
 WebServiceNFe: TWebServiceNFe;
 UF,EMPAGCNPJ,ULTNSU, SERIALNUMBER : string;
begin
  mmoresponse.Text := '';
  UF := edtuf.Text;
  EMPAGCNPJ:= edtempagcnpj.Text;
  ULTNSU:= edtultnsu.Text;
  SERIALNUMBER:= edtSerialNumber.Text;
  if (UF = '') or (EMPAGCNPJ  = '') or (ULTNSU  = '') or (SERIALNUMBER  = '') then
  begin
    mmoresponse.Text  := 'TODOS OS CAMPOS DEVEM SER PREENCHIDOS';
    raise Exception.Create('TODOS OS CAMPOS DEVEM SER PREENCHIDOS');
  end
  else
  begin
//      XMLDocument1.LoadFromFile('D:\github\pessoal\Consulta_WS_Nfe_DistDFeInteresse\Exemplo_Response.xml');
    XMLDocument1.LoadFromXML(WebServiceNFe.Execute(UF,EMPAGCNPJ,ULTNSU,SERIALNUMBER));
    mmoresponse.Text:= XMLDocument1.XML.Text;
  end;
end;

procedure TFrm.btnLimparClick(Sender: TObject);
begin
  mmoresponse.Text := '';
  edtuf.Text := '';
  edtempagcnpj.Text := '';
  edtultnsu.Text := '';
  edtSerialNumber.Text := '';
end;

end.
