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
        Top = 101
        Width = 110
        Height = 25
        Caption = 'Enviar'
        TabOrder = 0
        OnClick = btnAutenticarClick
      end
      object EdtStatusResponse: TEdit
        Left = 132
        Top = 103
        Width = 735
        Height = 21
        TabOrder = 1
        Text = 'Status Response'
      end
      object mm1: TMemo
        Left = 16
        Top = 132
        Width = 851
        Height = 333
        Lines.Strings = (
          'Memo1')
        ScrollBars = ssBoth
        TabOrder = 2
      end
      object BtnCarregar: TButton
        Left = 16
        Top = 3
        Width = 110
        Height = 25
        Caption = 'Carregar'
        TabOrder = 3
        OnClick = BtnCarregarClick
      end
      object EdtLoad: TEdit
        Left = 132
        Top = 3
        Width = 735
        Height = 21
        TabOrder = 4
        Text = 
          'C:\github\pessoal\Project_Mobile_App_NeoFleet\Exemplos_Json\Viag' +
          'em_3.json'
      end
      object LbTxtToken: TLabeledEdit
        Left = 16
        Top = 53
        Width = 249
        Height = 21
        EditLabel.Width = 99
        EditLabel.Height = 13
        EditLabel.Caption = 'Authorization Bearer'
        TabOrder = 5
        Text = '3acbb786-1204-4e38-8dbc-2784efe337a3'
      end
      object TbTxtSubDomain: TLabeledEdit
        Left = 292
        Top = 53
        Width = 101
        Height = 21
        EditLabel.Width = 53
        EditLabel.Height = 13
        EditLabel.Caption = 'SubDomain'
        TabOrder = 6
        Text = 'logtech'
      end
    end
  end
end
