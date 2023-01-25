object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 634
  ClientWidth = 999
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LblDiretorio: TLabel
    Left = 24
    Top = 37
    Width = 185
    Height = 13
    AutoSize = False
    Caption = 'Clique para selecionar diret'#243'rio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHotLight
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = LblDiretorioClick
  end
  object BtnImprimir: TButton
    Left = 32
    Top = 400
    Width = 249
    Height = 25
    Caption = 'Imprimir'
    TabOrder = 0
    OnClick = BtnImprimirClick
  end
  object OpenDialog: TOpenDialog
    Left = 232
    Top = 32
  end
end
