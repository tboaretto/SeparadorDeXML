object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 537
  ClientWidth = 898
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Roteiro: TPageControl
    Left = 0
    Top = 0
    Width = 898
    Height = 537
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Token'
      object pgc1: TPageControl
        Left = 552
        Top = 80
        Width = 289
        Height = 193
        TabOrder = 3
      end
      object btnAutenticar: TButton
        Left = 16
        Top = 19
        Width = 110
        Height = 25
        Caption = 'Autenticar'
        TabOrder = 0
        OnClick = btnAutenticarClick
      end
      object MemoToken: TMemo
        Left = 16
        Top = 56
        Width = 851
        Height = 417
        Lines.Strings = (
          'Memo1')
        TabOrder = 1
      end
      object EdtStatusResponse: TEdit
        Left = 144
        Top = 21
        Width = 723
        Height = 21
        Enabled = False
        ReadOnly = True
        TabOrder = 2
        Text = 'Status Response'
      end
    end
  end
end
