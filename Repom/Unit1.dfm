object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 618
  ClientWidth = 989
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
    Width = 989
    Height = 618
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Token'
      object btnToken: TButton
        Left = 171
        Top = 3
        Width = 110
        Height = 25
        Caption = 'Requisitar Token'
        TabOrder = 0
        OnClick = btnTokenClick
      end
      object MemoToken: TMemo
        Left = 16
        Top = 152
        Width = 851
        Height = 87
        Lines.Strings = (
          'Memo1')
        TabOrder = 1
      end
      object BtnParametros: TButton
        Left = 16
        Top = 3
        Width = 113
        Height = 25
        Caption = 'Carregar Par'#226'metros'
        TabOrder = 2
        OnClick = BtnParametrosClick
      end
      object Edtgrant_type: TEdit
        Left = 171
        Top = 42
        Width = 265
        Height = 21
        TabOrder = 3
        Text = 'grant_type'
      end
      object Edtusername: TEdit
        Left = 442
        Top = 42
        Width = 298
        Height = 21
        TabOrder = 4
        Text = 'username'
      end
      object Edtpassword: TEdit
        Left = 171
        Top = 69
        Width = 265
        Height = 21
        TabOrder = 5
        Text = 'password'
      end
      object Edtpartner: TEdit
        Left = 442
        Top = 69
        Width = 298
        Height = 21
        TabOrder = 6
        Text = 'partner'
      end
      object EdtStatusResponse: TEdit
        Left = 16
        Top = 96
        Width = 851
        Height = 21
        Enabled = False
        ReadOnly = True
        TabOrder = 7
        Text = 'Status Response'
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Motorista'
      ImageIndex = 1
      object Label1: TLabel
        Left = 10
        Top = 59
        Width = 39
        Height = 13
        Caption = 'Address'
      end
      object btnMot: TButton
        Left = 3
        Top = 319
        Width = 126
        Height = 25
        Caption = 'Consulta de motorista'
        TabOrder = 0
        OnClick = btnMotClick
      end
      object MemoMotRequest: TMemo
        Left = 3
        Top = 200
        Width = 694
        Height = 33
        Lines.Strings = (
          'MemoMotRequest')
        ScrollBars = ssVertical
        TabOrder = 1
      end
      object memoMot: TMemo
        Left = 3
        Top = 239
        Width = 694
        Height = 34
        Lines.Strings = (
          'Memo1')
        ScrollBars = ssVertical
        TabOrder = 2
      end
      object Button1: TButton
        Left = 221
        Top = 3
        Width = 126
        Height = 25
        Caption = 'Cadastro de Motorista'
        TabOrder = 3
        OnClick = Button1Click
      end
      object EdtCountry1: TEdit
        Left = 3
        Top = 34
        Width = 90
        Height = 21
        Enabled = False
        ReadOnly = True
        TabOrder = 4
        Text = 'EdtCountry1'
      end
      object EdtNationalId: TEdit
        Left = 99
        Top = 34
        Width = 116
        Height = 21
        TabOrder = 5
        Text = 'NationalId'
      end
      object EdtDriverLicenseNumber: TEdit
        Left = 221
        Top = 34
        Width = 126
        Height = 21
        TabOrder = 6
        Text = 'DriverLicenseNumber'
      end
      object Panel2: TPanel
        Left = 3
        Top = 102
        Width = 694
        Height = 65
        BevelInner = bvLowered
        TabOrder = 7
        object Label2: TLabel
          Left = 7
          Top = 11
          Width = 35
          Height = 13
          Caption = 'Phones'
        end
        object Label3: TLabel
          Left = 10
          Top = 43
          Width = 126
          Height = 13
          Caption = 'DriverPersonalInformation'
        end
        object EdtAreaCode: TEdit
          Left = 53
          Top = 7
          Width = 58
          Height = 21
          TabOrder = 0
          Text = 'AreaCode'
        end
        object EdtPhoneNumber: TEdit
          Left = 117
          Top = 7
          Width = 88
          Height = 21
          TabOrder = 1
          Text = 'Number'
        end
        object EdtPreferential: TEdit
          Left = 211
          Top = 7
          Width = 98
          Height = 21
          Enabled = False
          ReadOnly = True
          TabOrder = 2
          Text = 'Preferential'
        end
        object EdtTypeId: TEdit
          Left = 315
          Top = 7
          Width = 58
          Height = 21
          TabOrder = 3
          Text = 'TypeId'
        end
        object EdtBirthDate: TEdit
          Left = 146
          Top = 34
          Width = 106
          Height = 21
          TabOrder = 4
          Text = 'BirthDate'
        end
        object EdtName: TEdit
          Left = 258
          Top = 34
          Width = 166
          Height = 21
          TabOrder = 5
          Text = 'Name'
        end
        object EdtGender: TEdit
          Left = 430
          Top = 34
          Width = 51
          Height = 21
          TabOrder = 6
          Text = 'Gender'
        end
      end
      object Memo7: TMemo
        Left = 703
        Top = 3
        Width = 275
        Height = 364
        Lines.Strings = (
          'Memo6')
        ScrollBars = ssVertical
        TabOrder = 8
      end
      object BtnExemploMotorista: TButton
        Left = 3
        Top = 3
        Width = 166
        Height = 25
        Caption = 'Carregar exemplo de Motorista'
        TabOrder = 9
        OnClick = BtnExemploMotoristaClick
      end
      object EdtStreet: TEdit
        Left = 8
        Top = 75
        Width = 152
        Height = 21
        TabOrder = 10
        Text = 'Street'
      end
      object EdtAdressNumber: TEdit
        Left = 166
        Top = 75
        Width = 59
        Height = 21
        TabOrder = 11
        Text = 'Number'
      end
      object EdtComplement: TEdit
        Left = 231
        Top = 75
        Width = 87
        Height = 21
        TabOrder = 12
        Text = 'Complement'
      end
      object EdtNeighborhood: TEdit
        Left = 324
        Top = 75
        Width = 143
        Height = 21
        TabOrder = 13
        Text = 'Neighborhood'
      end
      object EdtZipCode: TEdit
        Left = 473
        Top = 75
        Width = 85
        Height = 21
        TabOrder = 14
        Text = 'ZipCode'
      end
      object EdtStatusResponseMot: TEdit
        Left = 3
        Top = 173
        Width = 121
        Height = 21
        Enabled = False
        ReadOnly = True
        TabOrder = 15
        Text = 'Status Response'
      end
      object EdtConsultaNome: TEdit
        Left = 135
        Top = 319
        Width = 292
        Height = 21
        TabOrder = 16
        Text = 'Consulta por Nome'
      end
      object MemoMetodoConsultaMot: TMemo
        Left = 3
        Top = 350
        Width = 694
        Height = 28
        Lines.Strings = (
          'Request')
        TabOrder = 17
      end
      object MemoRetConsultaMotorista: TMemo
        Left = 3
        Top = 384
        Width = 694
        Height = 97
        Lines.Strings = (
          'Retorno da consulta de motorista')
        ScrollBars = ssVertical
        TabOrder = 18
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'roteiro'
      ImageIndex = 2
      object BtnRoteiro: TButton
        Left = 257
        Top = 16
        Width = 105
        Height = 25
        Caption = 'Cadastro de roteiro'
        TabOrder = 0
        OnClick = BtnRoteiroClick
      end
      object EdtBranchIdentifier: TEdit
        Left = 25
        Top = 47
        Width = 85
        Height = 21
        ReadOnly = True
        TabOrder = 1
        Text = 'BranchIdentifier'
      end
      object EdtOriginIBGECode: TEdit
        Left = 116
        Top = 47
        Width = 85
        Height = 21
        ReadOnly = True
        TabOrder = 2
        Text = 'OriginIBGECode'
      end
      object EdtDestinyIBGECode: TEdit
        Left = 207
        Top = 47
        Width = 98
        Height = 21
        ReadOnly = True
        TabOrder = 3
        Text = 'DestinyIBGECode'
      end
      object EdtRoundTrip: TEdit
        Left = 311
        Top = 47
        Width = 63
        Height = 21
        ReadOnly = True
        TabOrder = 4
        Text = 'RoundTrip'
      end
      object EdtNote: TEdit
        Left = 25
        Top = 74
        Width = 349
        Height = 21
        ReadOnly = True
        TabOrder = 5
        Text = 'Note'
      end
      object EdtTraceIdentifier: TEdit
        Left = 25
        Top = 103
        Width = 85
        Height = 21
        ReadOnly = True
        TabOrder = 6
        Text = 'TraceIdentifier'
      end
      object EdtShippingPaymentPlaceType: TEdit
        Left = 116
        Top = 103
        Width = 141
        Height = 21
        ReadOnly = True
        TabOrder = 7
        Text = 'ShippingPaymentPlaceType'
      end
      object EdtHighwayNames: TEdit
        Left = 263
        Top = 103
        Width = 111
        Height = 21
        ReadOnly = True
        TabOrder = 8
        Text = 'HighwayNames'
      end
      object Memo6: TMemo
        Left = 25
        Top = 144
        Width = 192
        Height = 31
        Lines.Strings = (
          'Memo6')
        TabOrder = 9
      end
      object Memo8: TMemo
        Left = 25
        Top = 181
        Width = 349
        Height = 76
        Lines.Strings = (
          'Memo8')
        TabOrder = 10
      end
      object Memo10: TMemo
        Left = 380
        Top = 47
        Width = 213
        Height = 212
        Lines.Strings = (
          'Memo10')
        TabOrder = 11
      end
      object BtnExemploRoteiro: TButton
        Left = 25
        Top = 16
        Width = 154
        Height = 25
        Caption = 'Carregar Exemplo de roteiro'
        TabOrder = 12
        OnClick = BtnExemploRoteiroClick
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'prestador'
      ImageIndex = 3
      object Label4: TLabel
        Left = 16
        Top = 82
        Width = 35
        Height = 13
        Caption = 'Phones'
      end
      object Label5: TLabel
        Left = 16
        Top = 109
        Width = 78
        Height = 13
        Caption = 'BrazilianSettings'
      end
      object Label6: TLabel
        Left = 218
        Top = 114
        Width = 63
        Height = 13
        Caption = 'Pessoa Fisica'
      end
      object Label7: TLabel
        Left = 21
        Top = 149
        Width = 73
        Height = 13
        Caption = 'Pessoa Juridica'
      end
      object Label8: TLabel
        Left = 16
        Top = 186
        Width = 39
        Height = 13
        Caption = 'Address'
      end
      object Label9: TLabel
        Left = 16
        Top = 223
        Width = 101
        Height = 13
        Caption = 'CompanyInformation'
      end
      object Label10: TLabel
        Left = 16
        Top = 263
        Width = 122
        Height = 13
        Caption = 'HiredPersonalInformation'
      end
      object BtnPrestador: TButton
        Left = 188
        Top = 16
        Width = 129
        Height = 25
        Caption = 'Cadastro de Prestador'
        TabOrder = 0
        OnClick = BtnPrestadorClick
      end
      object Memo16: TMemo
        Left = 16
        Top = 344
        Width = 257
        Height = 33
        Lines.Strings = (
          'Memo16')
        TabOrder = 1
      end
      object Memo17: TMemo
        Left = 16
        Top = 383
        Width = 674
        Height = 194
        Lines.Strings = (
          'Memo16')
        ScrollBars = ssVertical
        TabOrder = 2
      end
      object Memo18: TMemo
        Left = 696
        Top = 3
        Width = 282
        Height = 584
        Lines.Strings = (
          'Memo16')
        ScrollBars = ssVertical
        TabOrder = 3
      end
      object EdtHiredCountry: TEdit
        Left = 16
        Top = 47
        Width = 121
        Height = 21
        Enabled = False
        ReadOnly = True
        TabOrder = 4
        Text = 'Country'
      end
      object EdtHiredType: TEdit
        Left = 143
        Top = 47
        Width = 121
        Height = 21
        TabOrder = 5
        Text = 'HiredType'
      end
      object EdtHiredNationalId: TEdit
        Left = 270
        Top = 47
        Width = 121
        Height = 21
        TabOrder = 6
        Text = 'NationalId'
      end
      object EdtEmail: TEdit
        Left = 397
        Top = 47
        Width = 178
        Height = 21
        TabOrder = 7
        Text = 'Email'
      end
      object EdtHiredAreaCode: TEdit
        Left = 57
        Top = 74
        Width = 52
        Height = 21
        TabOrder = 8
        Text = 'AreaCode'
      end
      object EdtHiredNumber: TEdit
        Left = 115
        Top = 74
        Width = 94
        Height = 21
        TabOrder = 9
        Text = 'Number'
      end
      object EdtHiredPreferential: TEdit
        Left = 215
        Top = 74
        Width = 66
        Height = 21
        Enabled = False
        ReadOnly = True
        TabOrder = 10
        Text = 'Preferential'
      end
      object EdtHiredTypeId: TEdit
        Left = 287
        Top = 74
        Width = 76
        Height = 21
        TabOrder = 11
        Text = 'TypeId'
      end
      object EdtHiredRNTRC: TEdit
        Left = 100
        Top = 106
        Width = 82
        Height = 21
        TabOrder = 12
        Text = 'RNTRC'
      end
      object EdtINSS: TEdit
        Left = 287
        Top = 106
        Width = 121
        Height = 21
        TabOrder = 13
        Text = 'INSS'
      end
      object EdtRG: TEdit
        Left = 414
        Top = 106
        Width = 121
        Height = 21
        TabOrder = 14
        Text = 'RG'
      end
      object EdtInscricaoEstadual: TEdit
        Left = 100
        Top = 146
        Width = 121
        Height = 21
        TabOrder = 15
        Text = 'InscricaoEstadual'
      end
      object EdtInscricaoMunicipal: TEdit
        Left = 227
        Top = 146
        Width = 121
        Height = 21
        TabOrder = 16
        Text = 'InscricaoMunicipal'
      end
      object EdtHiredNomeFantasia: TEdit
        Left = 354
        Top = 146
        Width = 121
        Height = 21
        TabOrder = 17
        Text = 'NomeFantasia'
      end
      object EdtOptanteSimplesNacional: TEdit
        Left = 481
        Top = 146
        Width = 137
        Height = 21
        Enabled = False
        ReadOnly = True
        TabOrder = 18
        Text = 'OptanteSimplesNacional'
      end
      object EdtHiredStreet: TEdit
        Left = 61
        Top = 183
        Width = 121
        Height = 21
        TabOrder = 19
        Text = 'Street'
      end
      object EdtHiredNumber2: TEdit
        Left = 188
        Top = 183
        Width = 121
        Height = 21
        TabOrder = 20
        Text = 'Number'
      end
      object EdtHiredComplement: TEdit
        Left = 315
        Top = 183
        Width = 121
        Height = 21
        TabOrder = 21
        Text = 'Complement'
      end
      object EdtHiredNeighborhood: TEdit
        Left = 442
        Top = 183
        Width = 121
        Height = 21
        TabOrder = 22
        Text = 'Neighborhood'
      end
      object EdtHiredZipCode: TEdit
        Left = 569
        Top = 183
        Width = 121
        Height = 21
        TabOrder = 23
        Text = 'ZipCode'
      end
      object EdtCompanyName: TEdit
        Left = 133
        Top = 220
        Width = 230
        Height = 21
        TabOrder = 24
        Text = 'CompanyName'
      end
      object EdtHiredName: TEdit
        Left = 160
        Top = 260
        Width = 121
        Height = 21
        TabOrder = 25
        Text = 'Name'
      end
      object EdtHiredBirthDate: TEdit
        Left = 297
        Top = 260
        Width = 121
        Height = 21
        TabOrder = 26
        Text = 'BirthDate'
      end
      object EdtLegalDependents: TEdit
        Left = 424
        Top = 260
        Width = 121
        Height = 21
        TabOrder = 27
        Text = 'Dependents'
      end
      object EdtHiredGender: TEdit
        Left = 551
        Top = 260
        Width = 121
        Height = 21
        TabOrder = 28
        Text = 'Gender'
      end
      object EdtFuelVoucherPercentage: TEdit
        Left = 17
        Top = 295
        Width = 161
        Height = 21
        TabOrder = 29
        Text = 'FuelVoucherPercentage'
      end
      object BtnExemploPrestador: TButton
        Left = 17
        Top = 16
        Width = 165
        Height = 25
        Caption = 'Carregar Exemplo de prestador'
        TabOrder = 30
        OnClick = BtnExemploPrestadorClick
      end
    end
    object TabSheet5: TTabSheet
      Caption = 've'#237'culo'
      ImageIndex = 4
      object Button2: TButton
        Left = 41
        Top = 26
        Width = 121
        Height = 25
        Caption = 'Cadastro de ve'#237'culos'
        TabOrder = 0
        OnClick = Button2Click
      end
      object EdtCountry: TEdit
        Left = 168
        Top = 26
        Width = 189
        Height = 21
        ReadOnly = True
        TabOrder = 1
        Text = 'Country'
      end
      object EdtLicensePlate: TEdit
        Left = 365
        Top = 26
        Width = 189
        Height = 21
        ReadOnly = True
        TabOrder = 2
        Text = 'LicensePlate'
      end
      object EdtVehicleClassification: TEdit
        Left = 560
        Top = 26
        Width = 189
        Height = 21
        ReadOnly = True
        TabOrder = 3
        Text = 'VehicleClassification'
      end
      object EdtVehicleCategory: TEdit
        Left = 168
        Top = 57
        Width = 386
        Height = 21
        ReadOnly = True
        TabOrder = 4
        Text = 'VehicleCategory'
      end
      object EdtVehicleAxles: TEdit
        Left = 560
        Top = 57
        Width = 189
        Height = 21
        ReadOnly = True
        TabOrder = 5
        Text = 'VehicleAxles'
      end
      object EdtType: TEdit
        Left = 755
        Top = 57
        Width = 189
        Height = 21
        ReadOnly = True
        TabOrder = 6
        Text = 'Type'
      end
      object EdtVehicleOwnerCountry: TEdit
        Left = 168
        Top = 92
        Width = 189
        Height = 21
        ReadOnly = True
        TabOrder = 7
        Text = 'VehicleOwnerCountry'
      end
      object EdtVehicleOwnerNationalId: TEdit
        Left = 363
        Top = 92
        Width = 189
        Height = 21
        ReadOnly = True
        TabOrder = 8
        Text = 'VehicleOwnerNationalId'
      end
      object EdtRNTRC: TEdit
        Left = 558
        Top = 92
        Width = 189
        Height = 21
        ReadOnly = True
        TabOrder = 9
        Text = 'RNTRC'
      end
      object EdtNomeFantasia: TEdit
        Left = 168
        Top = 126
        Width = 189
        Height = 21
        ReadOnly = True
        TabOrder = 10
        Text = 'NomeFantasia'
      end
      object EdtVehicleOwnerType: TEdit
        Left = 363
        Top = 126
        Width = 189
        Height = 21
        ReadOnly = True
        TabOrder = 11
        Text = 'VehicleOwnerType'
      end
      object EdtVehiclePersonalInformationName: TEdit
        Left = 558
        Top = 126
        Width = 384
        Height = 21
        ReadOnly = True
        TabOrder = 12
        Text = 'VehiclePersonalInformationName'
      end
      object Memo11: TMemo
        Left = 34
        Top = 168
        Width = 137
        Height = 25
        Lines.Strings = (
          'Memo11')
        TabOrder = 13
      end
      object Memo12: TMemo
        Left = 624
        Top = 168
        Width = 318
        Height = 305
        Lines.Strings = (
          'Memo11')
        TabOrder = 14
      end
      object Memo14: TMemo
        Left = 34
        Top = 199
        Width = 584
        Height = 154
        Lines.Strings = (
          'Memo11')
        TabOrder = 15
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'Viagem'
      ImageIndex = 5
      object BtnIniciarViagem: TButton
        Left = 0
        Top = 3
        Width = 113
        Height = 25
        Caption = 'Iniciar Viagem'
        TabOrder = 0
        OnClick = BtnIniciarViagemClick
      end
      object Memo9: TMemo
        Left = 616
        Top = 3
        Width = 362
        Height = 584
        Lines.Strings = (
          'Memo9')
        ScrollBars = ssVertical
        TabOrder = 1
      end
      object Memo13: TMemo
        Left = 119
        Top = 3
        Width = 113
        Height = 25
        Lines.Strings = (
          'Memo13')
        TabOrder = 2
      end
      object Memo15: TMemo
        Left = 3
        Top = 34
        Width = 607
        Height = 63
        Lines.Strings = (
          'Memo13')
        ScrollBars = ssBoth
        TabOrder = 3
      end
      object Button3: TButton
        Left = 3
        Top = 112
        Width = 110
        Height = 25
        Caption = 'Button3'
        TabOrder = 4
      end
    end
  end
end
