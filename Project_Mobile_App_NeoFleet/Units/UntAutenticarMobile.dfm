object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 495
  ClientWidth = 878
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PgcMobile: TPageControl
    Left = 0
    Top = 0
    Width = 878
    Height = 495
    ActivePage = TsAutenticar
    Align = alClient
    TabOrder = 0
    object TsAutenticar: TTabSheet
      Caption = 'Autenticar'
      object btnAutenticar: TButton
        Left = 16
        Top = 5
        Width = 110
        Height = 25
        Caption = 'Autenticar'
        TabOrder = 0
        OnClick = btnAutenticarClick
      end
      object EdtStatusResponse: TEdit
        Left = 132
        Top = 7
        Width = 735
        Height = 21
        Enabled = False
        ReadOnly = True
        TabOrder = 1
        Text = 'Status Response'
      end
      object MemoToken: TMemo
        Left = 16
        Top = 36
        Width = 851
        Height = 429
        Alignment = taCenter
        Lines.Strings = (
          'Memo1')
        ScrollBars = ssBoth
        TabOrder = 2
      end
    end
  end
end
