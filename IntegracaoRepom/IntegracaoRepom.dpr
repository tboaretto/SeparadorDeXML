program IntegracaoRepom;

uses
  System.StartUpCopy,
  FMX.Forms,
  UntPrincipal in 'src\UntPrincipal.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
