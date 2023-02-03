object FrmSeparadordeXML: TFrmSeparadordeXML
  Left = 0
  Top = 0
  Caption = 'Separador de XML'
  ClientHeight = 316
  ClientWidth = 520
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 520
    Height = 316
    Align = alClient
    BevelOuter = bvNone
    BiDiMode = bdLeftToRight
    BorderStyle = bsSingle
    ParentBiDiMode = False
    TabOrder = 0
    ExplicitLeft = -8
    ExplicitTop = -8
    ExplicitWidth = 582
    ExplicitHeight = 322
    object Label1: TLabel
      Left = 32
      Top = 93
      Width = 53
      Height = 13
      Caption = 'Data Inicial'
    end
    object Label2: TLabel
      Left = 168
      Top = 93
      Width = 48
      Height = 13
      Caption = 'Data Final'
    end
    object Button1: TButton
      Left = 160
      Top = 183
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
      Text = 'D:\github\pessoal\tmp'
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
      Text = 'D:\github\pessoal\XML'
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
    object DateIni: TDateTimePicker
      Left = 32
      Top = 112
      Width = 130
      Height = 21
      Date = 44960.443192337960000000
      Time = 44960.443192337960000000
      TabOrder = 5
    end
    object DateFinal: TDateTimePicker
      Left = 168
      Top = 112
      Width = 130
      Height = 21
      Date = 44960.443192337960000000
      Time = 44960.443192337960000000
      TabOrder = 6
    end
    object Button2: TButton
      Left = 160
      Top = 235
      Width = 225
      Height = 46
      Caption = 'Baixar Lote'
      TabOrder = 7
      OnClick = Button2Click
    end
  end
  object XMLDocument1: TXMLDocument
    Left = 432
    Top = 176
  end
  object RESTClientTecnoSpeed: TRESTClient
    Params = <>
    HandleRedirects = True
    Left = 56
    Top = 168
  end
  object RESTRequestTecnoSpeed: TRESTRequest
    Client = RESTClientTecnoSpeed
    Params = <>
    Response = RESTResponseTecnoSpeed
    SynchronizedEvents = False
    Left = 56
    Top = 232
  end
  object RESTResponseTecnoSpeed: TRESTResponse
    Left = 424
    Top = 112
  end
end
