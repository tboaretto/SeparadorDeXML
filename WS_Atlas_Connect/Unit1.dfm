object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 263
  ClientWidth = 660
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pgc1: TPageControl
    Left = 0
    Top = 0
    Width = 660
    Height = 263
    ActivePage = ts1
    Align = alClient
    TabOrder = 0
    object tsGetVeiculo: TTabSheet
      Caption = 'GetVeiculo'
      object btngetVeiculo: TButton
        Left = 10
        Top = 23
        Width = 75
        Height = 25
        Caption = 'getVeiculo'
        TabOrder = 0
        OnClick = btngetVeiculoClick
      end
      object edtRespGetVeiculo: TEdit
        Left = 10
        Top = 112
        Width = 463
        Height = 21
        TabOrder = 1
      end
    end
    object ts1: TTabSheet
      Caption = 'ts1'
      ImageIndex = 1
      object btn1: TButton
        Left = 32
        Top = 32
        Width = 75
        Height = 25
        Caption = 'btn1'
        TabOrder = 0
        OnClick = btn1Click
      end
      object edt1: TEdit
        Left = 32
        Top = 96
        Width = 593
        Height = 21
        TabOrder = 1
      end
    end
  end
end
