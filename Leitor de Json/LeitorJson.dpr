program LeitorJson;

uses
  System.StartUpCopy,
  FMX.Forms,
  UntLeitorJson in 'UntLeitorJson.pas' {FrmLeitorJson};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.CreateForm(TFrmLeitorJson, FrmLeitorJson);
  Application.Run;
end.
