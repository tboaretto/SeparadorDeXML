unit untSLGBase;

interface

uses Classes, {untServerBD,} DB, SqlExpr, DBClient, DBXJSON, {JSONHelper,} SQLWriter, System.SysUtils, {untLib_DB,} System.JSON;

type
  EInteracao = class(Exception)

  private
    FCode: Integer;

  public
    constructor Create(Msg: string; Code: Integer); reintroduce;
    constructor CreateFmt(Msg: string; Code: Integer; Fmt: array of const ); reintroduce;
    property Code: Integer read FCode;
  end;

  EErroValidacao = class(Exception);

  // Classe base para Manipulação de Erros;
  TErro = class

  const
    // Constantes de tipo de erro
    teInteracao = 1;
    teErroValidacao = 2;

  private
    FTipo: Integer;
    FCodigo: Integer;
    FErro: string;

  public
    function ToJSON: TJSONObject;

    property Tipo: Integer read FTipo write FTipo;
    property Codigo: Integer read FCodigo write FCodigo;
    property Erro: string read FErro write FErro;
  end;

  TRetorno = class

  private
    FExecutado: Boolean;
    FErro: TErro;
    FChave: Variant;
    FDetalhes: TJSONObject;

  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    function ToJSON: TJSONObject;

    property Executado: Boolean read FExecutado write FExecutado;
    property Erro: TErro read FErro write FErro;
    property Chave: Variant read FChave write FChave;
    property Detalhes: TJSONObject read FDetalhes write FDetalhes;
  end;

  // Classe base para manipulação de rotinas da untCall
  TSLGBase = class(TComponent)

  strict private
    // Gerenciador de banco de dados proveniente da TCall
{    FServer: TServerBD;}
    FSQLWriter: TSQLWriter;
    FListaFuncoesModulo: TStringList;

  private
    function GetUsuarioFuncao(IDFuncao: Integer): Boolean;

  protected
    procedure LoadSQL(ADataSet: TClientDataSet; ASQL: string; AFilters: array of const );


    property UsuarioFuncao[IDFuncao: Integer]: Boolean read GetUsuarioFuncao;
{    property DB: TServerBD read FServer;     }
    property SQLWriter: TSQLWriter read FSQLWriter;

  public
 {   constructor Create(ServerBD: TServerBD); reintroduce;}
    destructor Destroy; override;
  end;

  TSLGCallParams = array of Variant;

  TBaseCall = class(TSLGBase)
  protected
    FParams: TSLGCallParams;

    function GetRetorno: Variant; virtual; abstract;

  public
{    constructor Create(ServerBD: TServerBD; Params: TSLGCallParams); virtual;    }

    function Executar: Boolean; virtual; abstract;

    property Retorno: Variant read GetRetorno;
  end;

  TSLGCall = class(TBaseCall)
  const
    taInsert = 1;
    taUpdate = 2;
    taDelete = 3;

  strict private
    // Lista de parâmetros proveniente da TCall
    FJSONParams: TJSONObject;

  protected
    FJSONRetorno: TJSONObject;
    FRetorno: Variant;

    function GetRetorno: Variant; override;

    property Params: TSLGCallParams read FParams;
    property JSONParams: TJSONObject read FJSONParams;

  public

    // Este método DEVERÁ OBRIGATÓRIAMENTE ser implementado em todas as classes herdadas
    function Executar: Boolean; override;
  end;

  TJSONCall = class(TBaseCall)

  const
    taInsert = 1;
    taUpdate = 2;
    taDelete = 3;

  strict private
    // Lista de parâmetros proveniente da TCall
    FJSONParams: TJSONObject;
    FRetorno: TRetorno;

  protected
    function GetRetorno: Variant; override;

    property JSONRetorno: TRetorno read FRetorno;
    property JSONParams: TJSONObject read FJSONParams;

  public
{    constructor Create(ServerBD: TServerBD; Params: TSLGCallParams); override;     }
    destructor Destroy; override;
    // Este método DEVERÁ OBRIGATÓRIAMENTE ser implementado em todas as classes herdadas
    function Executar: Boolean; override;
  end;

  TSLGCallClass = class of TBaseCall;

implementation

uses Variants, RegularExpressions;

{ TSLGBase }



destructor TSLGBase.Destroy;
begin
  FSQLWriter.Free;
  FListaFuncoesModulo.Free;
  inherited;
end;

function TSLGBase.GetUsuarioFuncao(IDFuncao: Integer): Boolean;
begin
  Result := FListaFuncoesModulo.IndexOf(IntToStr(IDFuncao)) > -1;
end;

procedure TSLGBase.LoadSQL(ADataSet: TClientDataSet; ASQL: string; AFilters: array of const );
begin
  if ASQL = '' then
    raise EErroValidacao.Create('SQL Não encontrado');

  if ADataSet = nil then
    raise EErroValidacao.Create('DataSet não instanciado');

  try
    ADataSet.Close;
    ADataSet.CommandText := Format(ASQL, AFilters);
    ADataSet.Open;
  except
    on E: Exception do
      Exception.Create(E.Message);
  end;
end;



function TSLGCall.Executar: Boolean;
begin
  Result := False;
end;

function TSLGCall.GetRetorno: Variant;
begin
  if FJSONRetorno.Count > 0 then
    Result := FJSONRetorno.ToString
  else
    Result := FRetorno;
end;

{ TRetorno }

procedure TRetorno.AfterConstruction;
begin
  inherited;
  FErro := TErro.Create;
  FDetalhes := TJSONObject.Create;
  FChave := Null;
end;

procedure TRetorno.BeforeDestruction;
begin
  inherited;
  FErro.Free;
  FDetalhes.Free;
end;

function TRetorno.ToJSON: TJSONObject;
var
  Obj: TJSONObject;
begin
  Result := TJSONObject.Create;
  Obj := FErro.ToJSON;
//  Result.AddPair('executado', FExecutado);
  Result.AddPair('erro', Obj);
  Result.AddPair('chave', FChave);
  Result.AddPair('detalhes', TJSONObject(FDetalhes.Clone));
end;

{ EInteracao }
constructor EInteracao.Create(Msg: string; Code: Integer);
begin
  FCode := Code;
  inherited Create(Msg);
end;

constructor EInteracao.CreateFmt(Msg: string; Code: Integer; Fmt: array of const );
begin
  FCode := Code;
  inherited CreateFmt(Msg, Fmt);
end;

{ TErro }

function TErro.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
//  Result.AddPair('codigo', FCodigo);
//  Result.AddPair('tipo', FTipo);
//  Result.AddPair('erro', FErro);
end;

destructor TJSONCall.Destroy;
begin
  FJSONParams.Free;
  FRetorno.Free;
  inherited;
end;

function TJSONCall.Executar: Boolean;
begin
  Result := False;
end;

function TJSONCall.GetRetorno: Variant;
var
  Obj: TJSONObject;
  StringReplace: string;
begin
  Obj := FRetorno.ToJSON;
  try
    StringReplace := Obj.ToString;
    Result := StringReplace.Replace('\\"', '\"');
  finally
    Obj.Free;
  end;
end;

end.
