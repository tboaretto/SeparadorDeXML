object FrmSeparadordeXML: TFrmSeparadordeXML
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Separador de XML'
  ClientHeight = 456
  ClientWidth = 787
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 787
    Height = 456
    Align = alClient
    BevelOuter = bvNone
    BiDiMode = bdLeftToRight
    BorderStyle = bsSingle
    ParentBiDiMode = False
    TabOrder = 0
    object Label1: TLabel
      Left = 32
      Top = 373
      Width = 53
      Height = 13
      Caption = 'Data Inicial'
    end
    object Label2: TLabel
      Left = 176
      Top = 373
      Width = 48
      Height = 13
      Caption = 'Data Final'
    end
    object Label3: TLabel
      Left = 32
      Top = 432
      Width = 64
      Height = 13
      Caption = 'Consultando:'
    end
    object lblContador: TLabel
      Left = 102
      Top = 432
      Width = 6
      Height = 13
      Caption = '0'
    end
    object btnExecutar: TButton
      Left = 639
      Top = 418
      Width = 114
      Height = 27
      Caption = 'Executar'
      TabOrder = 0
      OnClick = btnExecutarClick
    end
    object EdtOrigemXML: TLabeledEdit
      Left = 128
      Top = 22
      Width = 449
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
      Width = 449
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
      Top = 392
      Width = 130
      Height = 21
      Date = 44960.443192337960000000
      Time = 44960.443192337960000000
      TabOrder = 5
    end
    object DateFinal: TDateTimePicker
      Left = 176
      Top = 392
      Width = 130
      Height = 21
      Date = 44960.443192337960000000
      Time = 44960.443192337960000000
      TabOrder = 6
    end
    object ListView1: TListView
      Left = 32
      Top = 93
      Width = 721
      Height = 274
      Columns = <
        item
          Caption = 'GRUPO'
          Width = 55
        end
        item
          Caption = 'EMPRESA'
          Width = 178
        end
        item
          Caption = 'CNPJ'
          Width = 100
        end
        item
          Caption = 'E-MAIL'
          Width = 130
        end
        item
          Caption = 'PROTOCOLO'
          Width = 136
        end
        item
          Caption = 'CONSULTA'
          Width = 118
        end>
      MultiSelect = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 7
      ViewStyle = vsReport
    end
    object btnBaixar: TButton
      Left = 519
      Top = 419
      Width = 114
      Height = 26
      Caption = 'Baixar Lote'
      TabOrder = 8
      OnClick = btnBaixarClick
    end
    object CheckVerify: TCheckBox
      Left = 320
      Top = 396
      Width = 97
      Height = 17
      Caption = ' Baixar Todos'
      TabOrder = 9
    end
  end
  object XMLDocument1: TXMLDocument
    Left = 552
    Top = 296
  end
  object RESTClientTecnoSpeed: TRESTClient
    Params = <>
    HandleRedirects = True
    Left = 288
    Top = 296
  end
  object RESTRequestTecnoSpeed: TRESTRequest
    Client = RESTClientTecnoSpeed
    Params = <>
    Response = RESTResponseTecnoSpeed
    SynchronizedEvents = False
    Left = 152
    Top = 296
  end
  object RESTResponseTecnoSpeed: TRESTResponse
    Left = 424
    Top = 296
  end
end
