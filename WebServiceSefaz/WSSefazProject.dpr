program WSSefazProject;

uses
  Vcl.Forms,
  Principal in 'MDFe\Principal.pas' {Form1},
  MDFeConsulta in 'MDFe\WDSL\MDFeConsulta.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
