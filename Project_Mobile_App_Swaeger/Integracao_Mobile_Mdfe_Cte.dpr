program Integracao_Mobile_Mdfe_Cte;

uses
  Vcl.Forms,
  AuxiliarIntegracaoMobile in 'AuxiliarIntegracaoMobile.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
