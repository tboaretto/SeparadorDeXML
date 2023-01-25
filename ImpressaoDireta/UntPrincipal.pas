unit UntPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Printers, shellapi;

type
  TForm1 = class(TForm)
    LblDiretorio: TLabel;
    OpenDialog: TOpenDialog;
    BtnImprimir: TButton;
    procedure LblDiretorioClick(Sender: TObject);
    procedure TBtnImprimirClick(Sender: TObject);
    procedure BtnFinalizarVendaClick(Sender: TObject);
    procedure SetDefaultPrinter(PrinterName:string);
    procedure BtnOkImpressoraClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BtnImprimirClick(Sender: TObject);

begin

ShellExecute(Handle, 'copy', PChar('C:\SIALOG\Etiqueta\teste.txt  \\dev01sialog\argox'), nil, nil, SW_HIDE) ;

end;





procedure TForm1.LblDiretorioClick(Sender: TObject);
begin
 if OpenDialog.Execute then
    LblDiretorio.Caption := OpenDialog.FileName;

end;


procedure TForm1.TBtnImprimirClick(Sender: TObject);
var
  I:Integer;
begin


end;

end.

