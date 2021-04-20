object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 679
  ClientWidth = 1242
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 553
    Height = 679
    Align = alLeft
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Button1: TButton
    Left = 595
    Top = 533
    Width = 107
    Height = 25
    Caption = 'Convert'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 595
    Top = 564
    Width = 107
    Height = 25
    Caption = 'TAGS'
    TabOrder = 2
    OnClick = Button2Click
  end
  object BtnTagValue: TButton
    Left = 595
    Top = 502
    Width = 107
    Height = 25
    Caption = 'TAGS e Value'
    TabOrder = 3
    OnClick = BtnTagValueClick
  end
  object BtnText: TButton
    Left = 580
    Top = 176
    Width = 133
    Height = 25
    Caption = 'Carregar como texto'
    TabOrder = 4
    OnClick = BtnTextClick
  end
  object Memo2: TMemo
    Left = 752
    Top = 0
    Width = 490
    Height = 679
    Align = alRight
    Lines.Strings = (
      'Memo2')
    TabOrder = 5
  end
  object BtnConverter: TButton
    Left = 593
    Top = 207
    Width = 107
    Height = 25
    Caption = 'Converter'
    TabOrder = 6
    OnClick = BtnConverterClick
  end
  object XMLDocument1: TXMLDocument
    Left = 629
    Top = 112
  end
end
