unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, atlas;

type
  TForm1 = class(TForm)
    btn1: TButton;
    edt1: TEdit;
    procedure btn1Click(Sender: TObject);
  private
      FAtlas: AtlasPortType;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var veiculoResposta: VeiculoResponse;
begin

      FAtlas:= atlas.GetAtlasPortType(true, '');

      veiculoResposta := FAtlas.getVeiculo({cod_cliente}, {cod_usuario}, {senha usuario});


      edt1.Text :=  IntToStr(veiculoResposta.responseCode) +' - '+ veiculoResposta.responseMessage;

end;

end.
