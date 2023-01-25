unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, MDFeConsulta;

type
  TForm1 = class(TForm)
    BtnConsultaNaoEncerrados: TButton;
    procedure BtnConsultaNaoEncerradosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BtnConsultaNaoEncerradosClick(Sender: TObject);
var ConsultarMDfe : MDFeConsulta;
begin


end;

end.
