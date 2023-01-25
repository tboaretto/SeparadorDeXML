unit SsimulaClikMouse;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    btnIniciar: TButton;
    PgBar: TProgressBar;
    EdtTempoMLS: TLabeledEdit;
    lbledtQTDCliks: TLabeledEdit;
    btnParar: TButton;
    procedure btnIniciarClick(Sender: TObject);
    procedure btnPararClick(Sender: TObject);

   private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Total: Integer;
  Parar: Boolean;

implementation

{$R *.dfm}

procedure TForm1.btnIniciarClick(Sender: TObject);
var
 I : Integer;
begin
   btnIniciar.Visible := False;
   btnIniciar.Enabled := False;
   Parar:= False;
   Total := StrToInt(lbledtQTDCliks.Text);
   PgBar.Max := Total;

   for I := 0 to Total do
   begin
     if Parar then
     begin
       Total := I;
     end;
        {Simula o pressionamento do botãoesquerdo do mouse}
     Mouse_Event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
        { Simula soltando o botãoesquerdo do mouse }
     Mouse_Event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);

     Sleep(StrToInt(EdtTempoMLS.Text));

     PgBar.Position := I;

   end;
//   btnIniciar.Visible := True;
//   btnIniciar.Enabled := True;

end;


procedure TForm1.btnPararClick(Sender: TObject);
begin
   Parar := True;
   btnIniciar.Visible := True;
   btnIniciar.Enabled := True;

end;


end.
