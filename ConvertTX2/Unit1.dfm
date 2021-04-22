object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 406
  ClientWidth = 897
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
    Width = 313
    Height = 406
    Align = alLeft
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object BtnText: TButton
    Left = 368
    Top = 232
    Width = 133
    Height = 25
    Caption = 'Carregar como texto'
    TabOrder = 1
    OnClick = BtnTextClick
  end
  object Memo2: TMemo
    Left = 575
    Top = 0
    Width = 322
    Height = 406
    Align = alRight
    Lines.Strings = (
      'Memo2')
    TabOrder = 2
  end
  object BtnConverter: TButton
    Left = 368
    Top = 279
    Width = 133
    Height = 25
    Caption = 'Converter'
    TabOrder = 3
    OnClick = BtnConverterClick
  end
  object EdtXml: TLabeledEdit
    Left = 368
    Top = 184
    Width = 201
    Height = 21
    EditLabel.Width = 127
    EditLabel.Height = 13
    EditLabel.Caption = 'Informar o caminho do xml'
    TabOrder = 4
    Text = 'C:\gabriel\XMLs\Exemplo_CTE.xml'
  end
  object XMLDocument1: TXMLDocument
    Left = 421
    Top = 112
  end
end
