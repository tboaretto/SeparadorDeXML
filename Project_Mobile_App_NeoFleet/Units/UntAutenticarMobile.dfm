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
        Caption = 'Enviar'
        TabOrder = 0
        OnClick = btnAutenticarClick
      end
      object EdtStatusResponse: TEdit
        Left = 132
        Top = 7
        Width = 735
        Height = 21
        ReadOnly = True
        TabOrder = 1
        Text = 'Status Response'
      end
      object mm1: TMemo
        Left = 16
        Top = 80
        Width = 851
        Height = 385
        Lines.Strings = (
          'Memo1')
        ScrollBars = ssBoth
        TabOrder = 2
      end
      object BtnCarregar: TButton
        Left = 16
        Top = 48
        Width = 110
        Height = 25
        Caption = 'Carregar'
        TabOrder = 3
        OnClick = BtnCarregarClick
      end
      object EdtLoad: TEdit
        Left = 132
        Top = 52
        Width = 735
        Height = 21
        TabOrder = 4
        Text = 
          'C:\github\pessoal\Project_Mobile_App_NeoFleet\Exemplos_Json\Viag' +
          'em_3.json'
      end
    end
  end
end
