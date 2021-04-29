unit Driver;

interface
 type

 TAddress = class
 private
   FStreet: string;
   FNumber: string;
   FComplement: string;
   FNeighborhood: string;
   FZipCode: string;
 public
   property Street: string read FStreet write FStreet;
   property Number: string read FNumber write FNumber;
   property Complement: string read FComplement write FComplement;
   property Neighborhood: string read FNeighborhood write FNeighborhood;
   property ZipCode: string read FZipCode write FZipCode;
 end;

 TPhones = class
 private
   FAreaCode: string;
   FNumber: string;
   FPreferential: string;
   FTypeId: string;
 public
   property AreaCode: string read FAreaCode write FAreaCode;
   property Number: string read FNumber write FNumber;
   property Preferential: string read FPreferential write FPreferential;
   property TypeId: string read FTypeId write FTypeId;
 end;

 TDriverPersonalInformation = class
 private
   FBirthDate: string;
   FName: string;
   FGender: string;
 public
   property BirthDate: string read FBirthDate write FBirthDate;
   property Name: string read FName write FName;
   property Gender: string read FGender write FGender;
 end;


 TDriver = class
 private
   FCountry: string;
   FNationalId: string;
   FDriverLicenseNumber: string;
   FAddress: TArray<TAddress>;
   FPhones: TArray<TPhones>;
   FDriverPersonalInformation: TArray<TDriverPersonalInformation>;
 public
   property Country: string read FCountry write FCountry;
   property NationalId: string read FNationalId write FNationalId;
   property DriverLicenseNumber: string read FDriverLicenseNumber write FDriverLicenseNumber;
//   property Address: TArray<TAddress> read FAddress write FAddress;
   property Address: TArray<TAddress> read FAddress write FAddress;
   property Phones: TArray<TPhones> read FPhones write FPhones;
   property DriverPersonalInformation: TArray<TDriverPersonalInformation> read FDriverPersonalInformation write FDriverPersonalInformation;
//   destructor Destroy; override;
 end;



{
 TPhones = class
 private
   FAreaCode: string;
   FNumber: string;
   FPreferential: string;
   FTypeId: string;
 public
   property AreaCode: string read FAreaCode write FAreaCode;
   property Number: string read FNumber write FNumber;
   property Preferential: string read FPreferential write FPreferential;
   property TypeId: string read FTypeId write FTypeId;
 end;

 TDriverPersonalInformation = class
 private
   FBirthDate: string;
   FName: string;
   FGender: string;
 public
   property BirthDate: string read FBirthDate write FBirthDate;
   property Name: string read FName write FName;
   property Gender: string read FGender write FGender;
 end;
           }

implementation



{ TDriver }
{
destructor TDriver.Destroy;
begin

  inherited;
end;
              }
end.
