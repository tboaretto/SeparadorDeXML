program Teste_Memory_Leak;

uses
  FastMM4,
  Vcl.Forms,
  Windows,
  SyncObjs,
  SysUtils,
  untMain in 'untMain.pas' {Form2};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
