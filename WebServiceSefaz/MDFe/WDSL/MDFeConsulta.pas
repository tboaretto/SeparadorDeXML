// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : https://mdfe.svrs.rs.gov.br/ws/MDFeConsulta/MDFeConsulta.asmx?wsdl
//  >Import : https://mdfe.svrs.rs.gov.br/ws/MDFeConsulta/MDFeConsulta.asmx?wsdl>0
// Encoding : utf-8
// Version  : 1.0
// (03/05/2022 11:52:27 - - $Rev: 76228 $)
// ************************************************************************ //

unit MDFeConsulta;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:schema          - "http://www.w3.org/2001/XMLSchema"[Lit][Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]

  mdfeCabecMsg2        = class;                 { "http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeConsulta"[Hdr][GblCplx] }
  mdfeCabecMsg         = class;                 { "http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeConsulta"[Hdr][GblElm] }

  mdfeConsultaMDFResult = TXMLData;      { "http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeConsulta"[Lit][GblElmMxd] }


  // ************************************************************************ //
  // XML       : mdfeCabecMsg, global, <complexType>
  // Namespace : http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeConsulta
  // Info      : Header
  // ************************************************************************ //
  mdfeCabecMsg2 = class(TSOAPHeader)
  private
    FcUF: string;
    FcUF_Specified: boolean;
    FversaoDados: string;
    FversaoDados_Specified: boolean;
    procedure SetcUF(Index: Integer; const Astring: string);
    function  cUF_Specified(Index: Integer): boolean;
    procedure SetversaoDados(Index: Integer; const Astring: string);
    function  versaoDados_Specified(Index: Integer): boolean;
  published
    property cUF:         string  Index (IS_OPTN) read FcUF write SetcUF stored cUF_Specified;
    property versaoDados: string  Index (IS_OPTN) read FversaoDados write SetversaoDados stored versaoDados_Specified;
  end;



  // ************************************************************************ //
  // XML       : mdfeCabecMsg, global, <element>
  // Namespace : http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeConsulta
  // Info      : Header
  // ************************************************************************ //
  mdfeCabecMsg = class(mdfeCabecMsg2)
  private
  published
  end;

  mdfeDadosMsg    = TXMLData;       { "http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeConsulta"[Lit][GblElmMxd] }

  // ************************************************************************ //
  // Namespace : http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeConsulta
  // soapAction: http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeConsulta/mdfeConsultaMDF
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : MDFeConsultaSoap12
  // service   : MDFeConsulta
  // port      : MDFeConsultaSoap12
  // URL       : https://mdfe.svrs.rs.gov.br/ws/MDFeConsulta/MDFeConsulta.asmx
  // ************************************************************************ //
  MDFeConsultaSoap12 = interface(IInvokable)
  ['{75EB968C-970B-8370-9A08-968559FF7760}']

    // Cannot unwrap: 
    //     - Input element wrapper name does not match operation's name
    //     - The output part is not a complex type
    // Headers: mdfeCabecMsg:pInOut
    function  mdfeConsultaMDF(const mdfeDadosMsg: mdfeDadosMsg): mdfeConsultaMDFResult; stdcall;
  end;

function GetMDFeConsultaSoap12(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): MDFeConsultaSoap12;


implementation
  uses System.SysUtils;

function GetMDFeConsultaSoap12(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): MDFeConsultaSoap12;
const
  defWSDL = 'https://mdfe.svrs.rs.gov.br/ws/MDFeConsulta/MDFeConsulta.asmx?wsdl';
  defURL  = 'https://mdfe.svrs.rs.gov.br/ws/MDFeConsulta/MDFeConsulta.asmx';
  defSvc  = 'MDFeConsulta';
  defPrt  = 'MDFeConsultaSoap12';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as MDFeConsultaSoap12);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


procedure mdfeCabecMsg2.SetcUF(Index: Integer; const Astring: string);
begin
  FcUF := Astring;
  FcUF_Specified := True;
end;

function mdfeCabecMsg2.cUF_Specified(Index: Integer): boolean;
begin
  Result := FcUF_Specified;
end;

procedure mdfeCabecMsg2.SetversaoDados(Index: Integer; const Astring: string);
begin
  FversaoDados := Astring;
  FversaoDados_Specified := True;
end;

function mdfeCabecMsg2.versaoDados_Specified(Index: Integer): boolean;
begin
  Result := FversaoDados_Specified;
end;

initialization
  { MDFeConsultaSoap12 }
  InvRegistry.RegisterInterface(TypeInfo(MDFeConsultaSoap12), 'http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeConsulta', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(MDFeConsultaSoap12), 'http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeConsulta/mdfeConsultaMDF');
  InvRegistry.RegisterInvokeOptions(TypeInfo(MDFeConsultaSoap12), ioDocument);
  InvRegistry.RegisterInvokeOptions(TypeInfo(MDFeConsultaSoap12), ioLiteral);
  InvRegistry.RegisterInvokeOptions(TypeInfo(MDFeConsultaSoap12), ioSOAP12);
  InvRegistry.RegisterHeaderClass(TypeInfo(MDFeConsultaSoap12), mdfeCabecMsg, 'mdfeCabecMsg', 'http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeConsulta');
  RemClassRegistry.RegisterXSInfo(TypeInfo(mdfeConsultaMDFResult), 'http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeConsulta', 'mdfeConsultaMDFResult');
  RemClassRegistry.RegisterXSClass(mdfeCabecMsg2, 'http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeConsulta', 'mdfeCabecMsg2', 'mdfeCabecMsg');
  RemClassRegistry.RegisterXSClass(mdfeCabecMsg, 'http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeConsulta', 'mdfeCabecMsg');
  RemClassRegistry.RegisterXSInfo(TypeInfo(mdfeDadosMsg), 'http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeConsulta', 'mdfeDadosMsg');

end.