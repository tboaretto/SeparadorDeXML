unit ClassHired;

interface

uses
  System.Generics.Collections;

type
  THiredPersonalInformation = class
  private
    FBirthDate: string;
    FGender: string;
    FLegalDependents: Integer;
    FName: string;
  published
    property BirthDate: string read FBirthDate write FBirthDate;
    property Gender: string read FGender write FGender;
    property LegalDependents: Integer read FLegalDependents write FLegalDependents;
    property Name: string read FName write FName;
  end;

  TCompanyInformation = class
  private
    FCompanyName: string;
  published
    property CompanyName: string read FCompanyName write FCompanyName;
  end;

  TAddress = class
  private
    FComplement: string;
    FNeighborhood: string;
    FNumber: string;
    FStreet: string;
    FZipCode: string;
  published
    property Complement: string read FComplement write FComplement;
    property Neighborhood: string read FNeighborhood write FNeighborhood;
    property Number: string read FNumber write FNumber;
    property Street: string read FStreet write FStreet;
    property ZipCode: string read FZipCode write FZipCode;
  end;

  THiredPessoaJuridica = class
  private
    FInscricaoEstadual: string;
    FInscricaoMunicipal: string;
    FNomeFantasia: string;
    FOptanteSimplesNacional: Boolean;
  published
    property InscricaoEstadual: string read FInscricaoEstadual write FInscricaoEstadual;
    property InscricaoMunicipal: string read FInscricaoMunicipal write FInscricaoMunicipal;
    property NomeFantasia: string read FNomeFantasia write FNomeFantasia;
    property OptanteSimplesNacional: Boolean read FOptanteSimplesNacional write FOptanteSimplesNacional;
  end;

  THiredPessoaFisica = class
  private
    FINSS: string;
    FRG: string;
  published
    property INSS: string read FINSS write FINSS;
    property RG: string read FRG write FRG;
  end;

  TBrazilianSettings = class
  private
    FRNTRC: string;
    FHiredPessoaFisica: THiredPessoaFisica;
    FHiredPessoaJuridica: THiredPessoaJuridica;
  published
    property RNTRC: string read FRNTRC write FRNTRC;
    property HiredPessoaFisica: THiredPessoaFisica read FHiredPessoaFisica write FHiredPessoaFisica;
    property HiredPessoaJuridica: THiredPessoaJuridica read FHiredPessoaJuridica write FHiredPessoaJuridica;
  public
//    constructor Create;
    destructor Destroy; override;
  end;

  TPhones = class
  private
    FAreaCode: string;
    FNumber: string;
    FPreferential: Boolean;
    FTypeId: string;
  published
    property AreaCode: string read FAreaCode write FAreaCode;
    property Number: string read FNumber write FNumber;
    property Preferential: Boolean read FPreferential write FPreferential;
    property TypeId: string read FTypeId write FTypeId;
  end;

  THired = class
  private
    FCountry: string;
//    FCOUNTRY: string;
    FHiredType: string;
    FNationalId: string;
    FEmail: string;
    FPhones: TArray<TPhones>;
    FBrazilianSettings: TBrazilianSettings;
    FAddress: TAddress;
    FCompanyInformation: TCompanyInformation;
    FHiredPersonalInformation: THiredPersonalInformation;
    FFuelVoucherPercentage: string;
//    [JSONName('Phones')]
//    FPhonesArray: TArray<TPhones>;
//    [GenericListReflect]
//    function GetPhones: TObjectList<TPhones>;
  published
    property Country: string read FCountry write FCountry;
//    property COUNTRY: string read FCOUNTRY write FCOUNTRY;
    property HiredType: string read FHiredType write FHiredType;
    property NationalId: string read FNationalId write FNationalId;
    property Email: string read FEmail write FEmail;
    property Phones: TArray<TPhones> read FPhones write FPhones;
    property BrazilianSettings: TBrazilianSettings read FBrazilianSettings write FBrazilianSettings;
    property Address: TAddress read FAddress write FAddress;
    property CompanyInformation: TCompanyInformation read FCompanyInformation write FCompanyInformation;
    property HiredPersonalInformation: THiredPersonalInformation read FHiredPersonalInformation write FHiredPersonalInformation;
    property FuelVoucherPercentage: string read FFuelVoucherPercentage write FFuelVoucherPercentage;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{constructor TBrazilianSettings.Create;
begin
  inherited;
  FHiredPessoaFisica := THiredPessoaFisica.Create;
  FHiredPessoaJuridica := THiredPessoaJuridica.Create;
end;     }

destructor TBrazilianSettings.Destroy;
begin
  FHiredPessoaFisica.Free;
  FHiredPessoaJuridica.Free;
  inherited;
end;

constructor THired.Create;
begin
  inherited;
  FBrazilianSettings := TBrazilianSettings.Create;
  FAddress := TAddress.Create;
  FCompanyInformation := TCompanyInformation.Create;
  FHiredPersonalInformation := THiredPersonalInformation.Create;
end;

destructor THired.Destroy;
begin
  FBrazilianSettings.Free;
  FAddress.Free;
  FCompanyInformation.Free;
  FHiredPersonalInformation.Free;
//  GetPhones.Free;
  inherited;
end;
end.
