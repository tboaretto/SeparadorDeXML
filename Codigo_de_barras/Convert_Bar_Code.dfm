object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Gerador de codigo de barras'
  ClientHeight = 200
  ClientWidth = 506
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object img1: TImage
    Left = 32
    Top = 16
    Width = 425
    Height = 81
    Align = alCustom
  end
  object lbledt1: TLabeledEdit
    Left = 32
    Top = 120
    Width = 425
    Height = 21
    EditLabel.Width = 135
    EditLabel.Height = 13
    EditLabel.Caption = 'Numero do c'#243'digo de barras'
    TabOrder = 0
  end
  object btn2: TBitBtn
    Left = 32
    Top = 147
    Width = 75
    Height = 25
    Caption = 'Gerar'
    TabOrder = 1
    OnClick = btn2Click
  end
end
