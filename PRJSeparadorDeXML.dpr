program PRJSeparadorDeXML;

uses
  Vcl.Forms,
  UntSeparadordeXML in 'UntSeparadordeXML.pas' {FrmSeparadordeXML},
  SevenZip in 'Classes\SevenZip.pas',
  UntEmail in 'Classes\UntEmail.pas';

{$R *.res}
  {$WARN SYMBOL_PLATFORM OFF}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmSeparadordeXML, FrmSeparadordeXML);
  Application.Run;
end.
