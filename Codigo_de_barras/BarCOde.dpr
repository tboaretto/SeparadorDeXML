program BarCOde;

uses
  Vcl.Forms,
  Convert_Bar_Code in 'Convert_Bar_Code.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
