object Frm: TFrm
  Left = 0
  Top = 0
  Caption = 'Frm'
  ClientHeight = 400
  ClientWidth = 936
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblserialnumber: TLabel
    Left = 48
    Top = 15
    Width = 66
    Height = 13
    Caption = 'Serial Number'
  end
  object lblultnsu: TLabel
    Left = 48
    Top = 64
    Width = 34
    Height = 13
    Caption = 'Ult Nsu'
  end
  object lbluf: TLabel
    Left = 208
    Top = 64
    Width = 13
    Height = 13
    Caption = 'UF'
  end
  object lblempagcnpj: TLabel
    Left = 351
    Top = 64
    Width = 64
    Height = 13
    Caption = 'Emp Ag CNPJ'
    FocusControl = edtempagcnpj
  end
  object edtSerialNumber: TEdit
    Left = 48
    Top = 34
    Width = 481
    Height = 21
    TabOrder = 0
  end
  object edtultnsu: TEdit
    Left = 48
    Top = 83
    Width = 137
    Height = 21
    TabOrder = 1
    Text = '000000000000000'
  end
  object edtuf: TEdit
    Left = 208
    Top = 83
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object edtempagcnpj: TEdit
    Left = 351
    Top = 83
    Width = 178
    Height = 21
    TabOrder = 3
  end
  object btnEnviar: TButton
    Left = 580
    Top = 32
    Width = 141
    Height = 72
    Caption = 'Enviar'
    TabOrder = 4
    OnClick = btnEnviarClick
  end
  object mmoresponse: TMemo
    Left = 8
    Top = 131
    Width = 920
    Height = 265
    Lines.Strings = (
      'mmoresponse')
    TabOrder = 5
  end
  object btnLimpar: TButton
    Left = 727
    Top = 81
    Width = 75
    Height = 25
    Caption = 'Limpar'
    TabOrder = 6
    OnClick = btnLimparClick
  end
  object XMLDocument1: TXMLDocument
    Left = 96
    Top = 48
  end
end
