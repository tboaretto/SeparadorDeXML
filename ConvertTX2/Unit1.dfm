object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 499
  ClientWidth = 1062
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
    Height = 499
    Align = alLeft
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object BtnText: TButton
    Left = 344
    Top = 152
    Width = 201
    Height = 25
    Caption = 'Carregar como texto'
    TabOrder = 1
    OnClick = BtnTextClick
  end
  object Memo2: TMemo
    Left = 572
    Top = 0
    Width = 490
    Height = 499
    Align = alRight
    Lines.Strings = (
      'Memo2')
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object BtnConverter: TButton
    Left = 344
    Top = 191
    Width = 201
    Height = 25
    Caption = 'Converter'
    TabOrder = 3
    OnClick = BtnConverterClick
  end
  object EdtXml: TLabeledEdit
    Left = 344
    Top = 104
    Width = 201
    Height = 21
    EditLabel.Width = 127
    EditLabel.Height = 13
    EditLabel.Caption = 'Informar o caminho do xml'
    TabOrder = 4
    Text = 'C:\gabriel\XMLs\Exemplo_CTE.xml'
  end
  object BtnExemplotx2: TButton
    Left = 344
    Top = 264
    Width = 201
    Height = 25
    Caption = 'Exemplo tx2'
    TabOrder = 5
    OnClick = BtnExemplotx2Click
  end
  object BtnNodexmlCTE: TButton
    Left = 344
    Top = 384
    Width = 201
    Height = 25
    Caption = 'Carregar por nodes do XML CTE'
    TabOrder = 6
    OnClick = BtnNodexmlCTEClick
  end
  object BtnNodexmlMDFe: TButton
    Left = 344
    Top = 440
    Width = 201
    Height = 25
    Caption = 'Carregar por nodes do XML MDFe'
    TabOrder = 7
    OnClick = BtnNodexmlMDFeClick
  end
  object XMLDocument1: TXMLDocument
    Left = 421
    Top = 40
  end
end
