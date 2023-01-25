unit SevenZip;

interface

uses
  SysUtils, Classes;

type
  TCompressionFormat = (cf7z, cfZip);
  TCompressionLevel = (clArchive = 1, cl2 = 2, cl3 = 3, cl4 =4, clNormal = 5, cl6 = 6, cl7 = 7, cl8 = 8, clUltra = 9);

  TSevenZip = class
  private
    FEngine: TFileName;

    function GetFormatFlag(Format: TCompressionFormat): string;
    function GetCompressionFlag(Level: TCompressionLevel): string;
    function ExecuteSevenZip(CommandLine, CurrentDirectory: string): Boolean;
  public
    constructor Create(SevenZipExecutable: TFileName);

    function ZipFolder(FolderPath, OutputFilename: TFileName; FileTypeMask: string = '*.*'; CompressionFormat: TCompressionFormat = cf7z; CompressionLevel: TCompressionLevel = clNormal): Boolean;
    function ZipFile(Filename, OutputFilename: TFileName; CompressionFormat: TCompressionFormat = cf7z; CompressionLevel: TCompressionLevel = clNormal): Boolean;
    function UnzipFolder(FolderPath: string; FileExt: string = '.7z'; OutputPath: string = ''): Boolean;
    function UnzipFile(FileName: string; OutputPath: string = ''): Boolean;
  end;

implementation

uses
  Windows, StrUtils;

{ TSevenZip }

function TSevenZip.GetFormatFlag(Format: TCompressionFormat): string;
begin
  Result := IfThen(Format = cf7z, '-t7z', '-tzip');
end;

function TSevenZip.UnzipFile(FileName: string; OutputPath: string = ''): Boolean;
const
  S_COMMAND = '"%s" e "%s" -aoa "%s"';
var
  CommandLine, CurrentDir: string;
begin
  CurrentDir := ExtractFilePath(FileName);
  // Se não vier nenhum OutputPath específico, extrai os arquivos na mesma pasta dos .zip
  if OutputPath = '' then
    OutputPath := '-o' + CurrentDir;

  CommandLine := Format(S_COMMAND, [FEngine, FileName, OutputPath]);
  Result := ExecuteSevenZip(CommandLine, CurrentDir);
end;

function TSevenZip.UnzipFolder(FolderPath: string; FileExt: string = '.7z'; OutputPath: string = ''): Boolean;
const
  S_COMMAND = '"%s" e "%s" -aoa "%s"';
var
  CommandLine, CurrentDir: string;
begin
  // Se não vier nenhum OutputPath específico, extrai os arquivos na mesma pasta dos .zip
  if OutputPath = '' then
    OutputPath := '-o' + FolderPath;

  CurrentDir := FolderPath;
  // Extrai todos os arquivos da pasta com a extensão informada, default = .7z
  FolderPath := FolderPath + '*' + FileExt;
  CommandLine := Format(S_COMMAND, [FEngine, FolderPath, OutputPath]);
  Result := ExecuteSevenZip(CommandLine, CurrentDir);
end;

function TSevenZip.GetCompressionFlag(Level: TCompressionLevel): string;
begin
  Result := Format('-mx%d', [Ord(Level)]);
end;

constructor TSevenZip.Create(SevenZipExecutable: TFileName);
begin
  FEngine := SevenZipExecutable;
end;

function TSevenZip.ExecuteSevenZip(CommandLine, CurrentDirectory: string): Boolean;
var
  StartupInfo: TStartupInfoW;
  ProcessInfo: TProcessInformation;
begin
  Result := False;

  StartupInfo := Default(TStartupInfoW);
  StartupInfo.cb := SizeOf(TStartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := SW_HIDE;

  if not CreateProcessW(nil, PWideChar(WideString(CommandLine)), nil, nil, False, 0, nil, PWideChar(WideString(CurrentDirectory)), StartupInfo, ProcessInfo) then
  begin
//    Log.Log('TSevenZip.ExecuteSevenZip', Format('Falha ao executar o 7zip: %s', [SysErrorMessage(GetLastError)]), ltError);
    Exit;
  end;

  try
    Result := WaitForSingleObject(ProcessInfo.hProcess, INFINITE) = WAIT_OBJECT_0;
  finally
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end;
end;

function TSevenZip.ZipFolder(FolderPath, OutputFilename: TFileName; FileTypeMask: string = '*.*'; CompressionFormat: TCompressionFormat = cf7z; CompressionLevel: TCompressionLevel = clNormal): Boolean;
const
  S_COMMAND = '"%s" a %s %s "%s" %s';
var
  CommandLine, CurrentDir: string;
begin
  CommandLine := Format(S_COMMAND, [FEngine, GetFormatFlag(CompressionFormat), GetCompressionFlag(CompressionLevel), OutputFilename, FileTypeMask]);
  CurrentDir := FolderPath;
  Result := ExecuteSevenZip(CommandLine, CurrentDir);
end;

function TSevenZip.ZipFile(Filename, OutputFilename: TFileName; CompressionFormat: TCompressionFormat = cf7z; CompressionLevel: TCompressionLevel = clNormal): Boolean;
const
  S_COMMAND = '"%s" a %s %s "%s" "%s"';
var
  CommandLine, CurrentDir: string;
begin
  CommandLine := Format(S_COMMAND, [FEngine, GetFormatFlag(CompressionFormat), GetCompressionFlag(CompressionLevel), OutputFilename, Filename]);
  CurrentDir := ExtractFilePath(Filename);
  Result := ExecuteSevenZip(CommandLine, CurrentDir);
end;

end.
