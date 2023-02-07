unit UntLog;

interface

uses
  System.SysUtils, Vcl.Forms;

type
  TLog = class
  private

  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure CriarLogException(E: Exception);
    procedure CriarLogMensagem(E: String);
  end;

var
  Log: TLog;

implementation

{ TEmail }


procedure TLog.AfterConstruction;
begin
  inherited;

end;

procedure TLog.BeforeDestruction;
begin

  inherited;
end;

procedure TLog.CriarLogException(E: Exception);
var
  NomeLog: string;
  Arquivo: TextFile;
begin
  NomeLog := ChangeFileExt(Application.Exename, '.log');
  AssignFile(Arquivo, NomeLog);
  if FileExists(NomeLog) then
    Append(arquivo) { se existir, apenas adiciona linhas }
  else
    ReWrite(arquivo); { cria um novo se não existir }
  try
    WriteLn(arquivo, DateTimeToStr(Now) + ':' + E.Message);
  finally
    CloseFile(arquivo)
  end;
end;

procedure TLog.CriarLogMensagem(E: String);
var
  NomeLog: string;
  Arquivo: TextFile;
begin
  NomeLog := ChangeFileExt(Application.Exename, '.log');
  AssignFile(Arquivo, NomeLog);
  if FileExists(NomeLog) then
    Append(arquivo) { se existir, apenas adiciona linhas }
  else
    ReWrite(arquivo); { cria um novo se não existir }
  try
    WriteLn(arquivo, '['+DateTimeToStr(Now)+']' + ':' + E);
  finally
    CloseFile(arquivo)
  end;
end;

end.
