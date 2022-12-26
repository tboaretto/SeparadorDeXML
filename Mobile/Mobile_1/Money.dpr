program Money;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitLogin in 'UnitLogin.pas' {FrmLogin},
  u99Permissions in 'Units\u99Permissions.pas',
  UntPrincipal in 'UntPrincipal.pas' {FrmPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
