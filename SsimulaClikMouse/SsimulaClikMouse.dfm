object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 257
  ClientWidth = 344
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnIniciar: TButton
    Left = 40
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Iniciar'
    TabOrder = 0
    OnClick = btnIniciarClick
  end
  object PgBar: TProgressBar
    Left = 40
    Top = 192
    Width = 257
    Height = 17
    TabOrder = 1
  end
  object EdtTempoMLS: TLabeledEdit
    Left = 40
    Top = 138
    Width = 121
    Height = 21
    Alignment = taRightJustify
    EditLabel.Width = 112
    EditLabel.Height = 13
    EditLabel.Caption = 'Tempo em milisegundos'
    TabOrder = 2
    Text = '50'
  end
  object lbledtQTDCliks: TLabeledEdit
    Left = 40
    Top = 82
    Width = 121
    Height = 21
    Alignment = taRightJustify
    EditLabel.Width = 107
    EditLabel.Height = 13
    EditLabel.Caption = 'Quantidade de "clikes"'
    TabOrder = 3
    Text = '50'
  end
  object btnParar: TButton
    Left = 192
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Parar'
    TabOrder = 4
    OnClick = btnPararClick
  end
end
