object FrmSeparadordeXML: TFrmSeparadordeXML
  Left = 0
  Top = 0
  Caption = 'Separador de XML'
  ClientHeight = 209
  ClientWidth = 514
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 514
    Height = 209
    Align = alClient
    BevelOuter = bvNone
    BiDiMode = bdLeftToRight
    BorderStyle = bsSingle
    ParentBiDiMode = False
    TabOrder = 0
    object Button1: TButton
      Left = 112
      Top = 109
      Width = 225
      Height = 46
      Caption = 'Executar'
      TabOrder = 0
      OnClick = Button1Click
    end
    object EdtOrigemXML: TLabeledEdit
      Left = 128
      Top = 22
      Width = 353
      Height = 21
      EditLabel.Width = 128
      EditLabel.Height = 13
      EditLabel.Caption = 'Caminho de origem do XML'
      TabOrder = 1
      Text = 'D:\github\pessoal\SeparadorDeXML\tmp'
    end
    object EdtDestinoXML: TLabeledEdit
      Left = 128
      Top = 64
      Width = 353
      Height = 21
      EditLabel.Width = 131
      EditLabel.Height = 13
      EditLabel.Caption = 'Caminho de destino do XML'
      TabOrder = 2
      Text = 'D:\github\pessoal\SeparadorDeXML\XML'
    end
    object BtnOrigemXML: TButton
      Left = 32
      Top = 20
      Width = 90
      Height = 25
      Caption = 'Origem XML'
      TabOrder = 3
      OnClick = BtnOrigemXMLClick
    end
    object BtnDestinoXML: TButton
      Left = 32
      Top = 62
      Width = 90
      Height = 25
      Caption = 'Destino XML'
      TabOrder = 4
      OnClick = BtnDestinoXMLClick
    end
  end
  object XMLDocument1: TXMLDocument
    Left = 408
    Top = 112
  end
end
