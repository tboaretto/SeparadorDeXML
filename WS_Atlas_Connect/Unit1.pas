unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, atlas, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    pgc1: TPageControl;
    tsGetVeiculo: TTabSheet;
    btngetVeiculo: TButton;
    edtRespGetVeiculo: TEdit;
    ts1: TTabSheet;
    btn1: TButton;
    edt1: TEdit;
    procedure btngetVeiculoClick(Sender: TObject);
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
var SendveiculoResposta: SendVeiculoResponse;
   Veic:   parametrosVeiculo;
begin
    Veic  := parametrosVeiculo.Create();
    FAtlas:= atlas.GetAtlasPortType(true, '');
    Veic.cod_operacao := 226;
    Veic.placa:= 'XXX0001';
    Veic.cod_vinculo_contratual := 'AGR';
    Veic.cod_marca:= 'VOLKSWAGEM';
    Veic.cod_tipo:= 'AUTOMOVEL';
    Veic.cod_modelo:= '1279';
    Veic.cod_carroceria:= 'SC';
    Veic.cod_empresa_consulta:= '0';
    Veic.data_consulta:= '01/10/2021';
    Veic.num_autorizacao_consulta:= 'NSA';
    Veic.num_frota:= 'NSA0000';
    Veic.velocidade_maxima:= '0';
    Veic.cod_cor:= '1';
    Veic.ano_fabricacao:= '2000';
    Veic.uf_placa:= 'SP';
    Veic.cod_ibge_placa:= '3550308';
    Veic.validade_placa:= '01/11/2021';
    Veic.inicio_horario_restr:= '00:00';
    Veic.fim_horario_restr:= '00:00';
    Veic.prod_homolog:= 'P';
   SendveiculoResposta := FAtlas.sendVeiculo(3685, '2lYuV5maKlW', 0185, Veic);
   edt1.Text :=  IntToStr(SendveiculoResposta.responseCode) +' - '+ SendveiculoResposta.responseMessage;
end;

procedure TForm1.btngetVeiculoClick(Sender: TObject);
var veiculoResposta: VeiculoResponse;
begin
   FAtlas:= atlas.GetAtlasPortType(true, '');
   veiculoResposta := FAtlas.getVeiculo(0185, 3685, '2lYuV5maKlW');
   edtRespGetVeiculo.Text :=  IntToStr(veiculoResposta.responseCode) +' - '+ veiculoResposta.responseMessage;
end;

end.
