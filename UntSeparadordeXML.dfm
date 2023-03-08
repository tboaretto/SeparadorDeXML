object FrmSeparadordeXML: TFrmSeparadordeXML
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Separador de XML'
  ClientHeight = 475
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
    Height = 475
    Align = alClient
    BevelOuter = bvNone
    BiDiMode = bdLeftToRight
    BorderStyle = bsSingle
    Color = clMenuBar
    ParentBiDiMode = False
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 32
      Top = 379
      Width = 53
      Height = 13
      Caption = 'Data Inicial'
    end
    object Label2: TLabel
      Left = 176
      Top = 379
      Width = 48
      Height = 13
      Caption = 'Data Final'
    end
    object btnExecutar: TButton
      Left = 639
      Top = 428
      Width = 114
      Height = 27
      Caption = 'Separar Lote'
      TabOrder = 10
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
    end
    object EdtDestinoXML: TLabeledEdit
      Left = 128
      Top = 64
      Width = 449
      Height = 21
      EditLabel.Width = 131
      EditLabel.Height = 13
      EditLabel.Caption = 'Caminho de destino do XML'
      TabOrder = 3
    end
    object BtnOrigemXML: TButton
      Left = 32
      Top = 20
      Width = 90
      Height = 25
      Caption = 'Origem XML'
      TabOrder = 0
      OnClick = BtnOrigemXMLClick
    end
    object BtnDestinoXML: TButton
      Left = 32
      Top = 62
      Width = 90
      Height = 25
      Caption = 'Destino XML'
      TabOrder = 2
      OnClick = BtnDestinoXMLClick
    end
    object DateIni: TDateTimePicker
      Left = 32
      Top = 397
      Width = 130
      Height = 21
      Date = 44960.443192337960000000
      Time = 44960.443192337960000000
      TabOrder = 5
    end
    object DateFinal: TDateTimePicker
      Left = 176
      Top = 397
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
          Alignment = taCenter
          Caption = 'EMPRESA'
          Width = 200
        end
        item
          Alignment = taCenter
          Caption = 'CNPJ'
          Width = 100
        end
        item
          Alignment = taCenter
          Caption = 'E-MAIL'
          Width = 152
        end
        item
          Alignment = taCenter
          Caption = 'ENVIAR E-MAIL'
          Width = 90
        end
        item
          Alignment = taCenter
          Caption = 'CONSULTA'
          Width = 120
        end
        item
          Alignment = taCenter
          Caption = 'PROTOCOLO'
          Width = 220
        end>
      MultiSelect = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 4
      ViewStyle = vsReport
    end
    object btnBaixar: TButton
      Left = 519
      Top = 429
      Width = 114
      Height = 26
      Caption = 'Baixar Lote'
      TabOrder = 9
      OnClick = btnBaixarClick
    end
    object CheckVerify: TCheckBox
      Left = 423
      Top = 399
      Width = 97
      Height = 17
      Caption = ' Baixar Todos'
      TabOrder = 8
    end
    object CheckEmail: TCheckBox
      Left = 320
      Top = 399
      Width = 97
      Height = 17
      Caption = 'Disparar E-mail'
      Checked = True
      State = cbChecked
      TabOrder = 7
    end
  end
  object XMLDocument1: TXMLDocument
    Left = 688
    Top = 296
  end
end
