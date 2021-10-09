// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : https://connect.atlasgr.com.br/portalatlas/ui/V2/atlas.php?wsdl
//  >Import : https://connect.atlasgr.com.br/portalatlas/ui/V2/atlas.php?wsdl>0
// Encoding : UTF-8
// Version  : 1.0
// (08/10/2021 13:15:48 - - $Rev: 76228 $)
// ************************************************************************ //

unit atlas;

interface

uses Soap.InvokeRegistry,
     Soap.SOAPHTTPClient,
     System.Types,
     Soap.XSBuiltIns;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:double          - "http://www.w3.org/2001/XMLSchema"[Gbl]

  Logradouro           = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  EmpresaConsulta      = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  VeiculoTipo          = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  Embarcador           = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  MercadoriaSM         = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  Veiculo              = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  VeiculoCor           = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  VinculoContrat       = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  VeiculoModelo        = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  VeiculoMarca         = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  LogradourosResponse  = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  KM                   = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  getKMResponse        = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  EmpresaConsultaResponse = class;              { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  AlvosResponse        = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  sendMotoristaResponse = class;                { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  EmbarcadorResponse   = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  SendVeiculoResponse  = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  parametrosMotorista  = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  VeiculoTipoResponse  = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  SM                   = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  cancelaSmResponse    = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  getSMResponse        = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  parametrosSM         = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  parametrosVeiculo    = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  SendSmResponse       = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  VeiculoResponse      = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  VinculoContratResponse = class;               { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  VeiculoModeloResponse = class;                { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  VeiculoMarcaResponse = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  VeiculoCorResponse   = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  Alvo                 = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  Cidade               = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  CidadesResponse      = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  Pgr                  = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  Operacao             = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  OperacaoResponse     = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  RotasResponse        = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  PgrResponse          = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  Rota                 = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  Moeda                = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  Mercadoria           = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  MercadoriaResponse   = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  MotoristaResponse    = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  MoedaResponse        = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  Motorista            = class;                 { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }

  ListaVeiculoMarca = array of VeiculoMarca;    { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  ListaVeiculoModelo = array of VeiculoModelo;   { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  ListaVeiculoCor = array of VeiculoCor;        { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  ListaVinculoContrat = array of VinculoContrat;   { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  ListaVeiculo = array of Veiculo;              { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  ListaMercadoriasSM = array of MercadoriaSM;   { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  ListaSM    = array of SM;                     { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  ListaVeiculoTipo = array of VeiculoTipo;      { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  ListaEmbarcador = array of Embarcador;        { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  ListaEmpresaConsulta = array of EmpresaConsulta;   { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  ListaAlvos = array of Alvo;                   { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  ListaKM    = array of KM;                     { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  ListaLogradouros = array of Logradouro;       { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }


  // ************************************************************************ //
  // XML       : Logradouro, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  Logradouro = class(TRemotable)
  private
    Fcodigo: string;
    Fnome: string;
  published
    property codigo: string  read Fcodigo write Fcodigo;
    property nome:   string  read Fnome write Fnome;
  end;



  // ************************************************************************ //
  // XML       : EmpresaConsulta, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  EmpresaConsulta = class(TRemotable)
  private
    Fcodigo: string;
    Fnome: string;
  published
    property codigo: string  read Fcodigo write Fcodigo;
    property nome:   string  read Fnome write Fnome;
  end;



  // ************************************************************************ //
  // XML       : VeiculoTipo, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  VeiculoTipo = class(TRemotable)
  private
    Fcodigo: string;
    Fnome: string;
  published
    property codigo: string  read Fcodigo write Fcodigo;
    property nome:   string  read Fnome write Fnome;
  end;



  // ************************************************************************ //
  // XML       : Embarcador, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  Embarcador = class(TRemotable)
  private
    Fcodigo: string;
    Fnome: string;
  published
    property codigo: string  read Fcodigo write Fcodigo;
    property nome:   string  read Fnome write Fnome;
  end;



  // ************************************************************************ //
  // XML       : MercadoriaSM, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  MercadoriaSM = class(TRemotable)
  private
    Fcodigo: string;
    Fmoeda: string;
    Fvalor: string;
  published
    property codigo: string  read Fcodigo write Fcodigo;
    property moeda:  string  read Fmoeda write Fmoeda;
    property valor:  string  read Fvalor write Fvalor;
  end;



  // ************************************************************************ //
  // XML       : Veiculo, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  Veiculo = class(TRemotable)
  private
    Fplaca: string;
    Foperacao: string;
  published
    property placa:    string  read Fplaca write Fplaca;
    property operacao: string  read Foperacao write Foperacao;
  end;



  // ************************************************************************ //
  // XML       : VeiculoCor, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  VeiculoCor = class(TRemotable)
  private
    Fcodigo: string;
    Fnome: string;
  published
    property codigo: string  read Fcodigo write Fcodigo;
    property nome:   string  read Fnome write Fnome;
  end;



  // ************************************************************************ //
  // XML       : VinculoContrat, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  VinculoContrat = class(TRemotable)
  private
    Fcodigo: string;
    Fnome: string;
  published
    property codigo: string  read Fcodigo write Fcodigo;
    property nome:   string  read Fnome write Fnome;
  end;



  // ************************************************************************ //
  // XML       : VeiculoModelo, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  VeiculoModelo = class(TRemotable)
  private
    Fcodigo: string;
    Fnome_modelo: string;
    Fnome_marca: string;
  published
    property codigo:      string  read Fcodigo write Fcodigo;
    property nome_modelo: string  read Fnome_modelo write Fnome_modelo;
    property nome_marca:  string  read Fnome_marca write Fnome_marca;
  end;



  // ************************************************************************ //
  // XML       : VeiculoMarca, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  VeiculoMarca = class(TRemotable)
  private
    Fcodigo: string;
    Fnome: string;
  published
    property codigo: string  read Fcodigo write Fcodigo;
    property nome:   string  read Fnome write Fnome;
  end;



  // ************************************************************************ //
  // XML       : LogradourosResponse, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  LogradourosResponse = class(TRemotable)
  private
    FresponseCode: Integer;
    FresponseMessage: string;
    Fdados: ListaLogradouros;
  public
    destructor Destroy; override;
  published
    property responseCode:    Integer           read FresponseCode write FresponseCode;
    property responseMessage: string            read FresponseMessage write FresponseMessage;
    property dados:           ListaLogradouros  read Fdados write Fdados;
  end;



  // ************************************************************************ //
  // XML       : KM, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  KM = class(TRemotable)
  private
    Fcod_sm: Integer;
    Fplaca_veiculo: string;
    Finicio_viagem: string;
    Ffim_viagem: string;
    Fodometro_inicial: Integer;
    Fodometro_final: Integer;
    Frota_distancia: string;
    Frota_nome: string;
    Fdiferenca_km: Integer;
    Fstatus_sm: string;
  published
    property cod_sm:           Integer  read Fcod_sm write Fcod_sm;
    property placa_veiculo:    string   read Fplaca_veiculo write Fplaca_veiculo;
    property inicio_viagem:    string   read Finicio_viagem write Finicio_viagem;
    property fim_viagem:       string   read Ffim_viagem write Ffim_viagem;
    property odometro_inicial: Integer  read Fodometro_inicial write Fodometro_inicial;
    property odometro_final:   Integer  read Fodometro_final write Fodometro_final;
    property rota_distancia:   string   read Frota_distancia write Frota_distancia;
    property rota_nome:        string   read Frota_nome write Frota_nome;
    property diferenca_km:     Integer  read Fdiferenca_km write Fdiferenca_km;
    property status_sm:        string   read Fstatus_sm write Fstatus_sm;
  end;



  // ************************************************************************ //
  // XML       : getKMResponse, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  getKMResponse = class(TRemotable)
  private
    FresponseCode: Integer;
    FresponseMessage: string;
    Fdados: ListaKM;
  public
    destructor Destroy; override;
  published
    property responseCode:    Integer  read FresponseCode write FresponseCode;
    property responseMessage: string   read FresponseMessage write FresponseMessage;
    property dados:           ListaKM  read Fdados write Fdados;
  end;



  // ************************************************************************ //
  // XML       : EmpresaConsultaResponse, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  EmpresaConsultaResponse = class(TRemotable)
  private
    FresponseCode: Integer;
    FresponseMessage: string;
    Fdados: ListaEmpresaConsulta;
  public
    destructor Destroy; override;
  published
    property responseCode:    Integer               read FresponseCode write FresponseCode;
    property responseMessage: string                read FresponseMessage write FresponseMessage;
    property dados:           ListaEmpresaConsulta  read Fdados write Fdados;
  end;



  // ************************************************************************ //
  // XML       : AlvosResponse, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  AlvosResponse = class(TRemotable)
  private
    FresponseCode: Integer;
    FresponseMessage: string;
    Fdados: ListaAlvos;
  public
    destructor Destroy; override;
  published
    property responseCode:    Integer     read FresponseCode write FresponseCode;
    property responseMessage: string      read FresponseMessage write FresponseMessage;
    property dados:           ListaAlvos  read Fdados write Fdados;
  end;



  // ************************************************************************ //
  // XML       : sendMotoristaResponse, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  sendMotoristaResponse = class(TRemotable)
  private
    FresponseCode: Integer;
    FresponseMessage: string;
  published
    property responseCode:    Integer  read FresponseCode write FresponseCode;
    property responseMessage: string   read FresponseMessage write FresponseMessage;
  end;



  // ************************************************************************ //
  // XML       : EmbarcadorResponse, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  EmbarcadorResponse = class(TRemotable)
  private
    FresponseCode: Integer;
    FresponseMessage: string;
    Fdados: ListaEmbarcador;
  public
    destructor Destroy; override;
  published
    property responseCode:    Integer          read FresponseCode write FresponseCode;
    property responseMessage: string           read FresponseMessage write FresponseMessage;
    property dados:           ListaEmbarcador  read Fdados write Fdados;
  end;



  // ************************************************************************ //
  // XML       : SendVeiculoResponse, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  SendVeiculoResponse = class(TRemotable)
  private
    FresponseCode: Integer;
    FresponseMessage: string;
  published
    property responseCode:    Integer  read FresponseCode write FresponseCode;
    property responseMessage: string   read FresponseMessage write FresponseMessage;
  end;



  // ************************************************************************ //
  // XML       : parametrosMotorista, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  parametrosMotorista = class(TRemotable)
  private
    Fcod_operacao: Integer;
    Fcpf: string;
    Fnome: string;
    Fcod_vinculo_contratual: string;
    Frg: string;
    Fcnh: string;
    Fcep: string;
    Fuf: string;
    Fcod_ibge: string;
    Flogradouro: string;
    Fendereco: string;
    Fnumero: string;
    Fcomplemento: string;
    Fbairro: string;
    Fddd: string;
    Ffone_cel: string;
    Fcod_empresa_consulta: string;
    Fdata_consulta: string;
    Fnum_autorizacao_consulta: string;
    Fprod_homolog: string;
  published
    property cod_operacao:             Integer  read Fcod_operacao write Fcod_operacao;
    property cpf:                      string   read Fcpf write Fcpf;
    property nome:                     string   read Fnome write Fnome;
    property cod_vinculo_contratual:   string   read Fcod_vinculo_contratual write Fcod_vinculo_contratual;
    property rg:                       string   read Frg write Frg;
    property cnh:                      string   read Fcnh write Fcnh;
    property cep:                      string   read Fcep write Fcep;
    property uf:                       string   read Fuf write Fuf;
    property cod_ibge:                 string   read Fcod_ibge write Fcod_ibge;
    property logradouro:               string   read Flogradouro write Flogradouro;
    property endereco:                 string   read Fendereco write Fendereco;
    property numero:                   string   read Fnumero write Fnumero;
    property complemento:              string   read Fcomplemento write Fcomplemento;
    property bairro:                   string   read Fbairro write Fbairro;
    property ddd:                      string   read Fddd write Fddd;
    property fone_cel:                 string   read Ffone_cel write Ffone_cel;
    property cod_empresa_consulta:     string   read Fcod_empresa_consulta write Fcod_empresa_consulta;
    property data_consulta:            string   read Fdata_consulta write Fdata_consulta;
    property num_autorizacao_consulta: string   read Fnum_autorizacao_consulta write Fnum_autorizacao_consulta;
    property prod_homolog:             string   read Fprod_homolog write Fprod_homolog;
  end;



  // ************************************************************************ //
  // XML       : VeiculoTipoResponse, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  VeiculoTipoResponse = class(TRemotable)
  private
    FresponseCode: Integer;
    FresponseMessage: string;
    Fdados: ListaVeiculoTipo;
  public
    destructor Destroy; override;
  published
    property responseCode:    Integer           read FresponseCode write FresponseCode;
    property responseMessage: string            read FresponseMessage write FresponseMessage;
    property dados:           ListaVeiculoTipo  read Fdados write Fdados;
  end;



  // ************************************************************************ //
  // XML       : SM, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  SM = class(TRemotable)
  private
    Fcodigo_sm: Integer;
    Fcod_embarcador: Integer;
    Fnum_interno: Integer;
    Fnum_documento: string;
    Fnum_cliente: string;
    Fcod_ope: Integer;
    Fprev_ini_viagem: string;
    Fprev_fim_viagem: string;
    Fini_viagem: string;
    Ffim_viagem: string;
    Fcod_rota: Integer;
    Frota_nome: string;
    Frota_distancia: string;
    Fcod_rotaux: Integer;
    Frota_aux_nome: string;
    Frota_aux_distancia: Integer;
    Fcod_pgr: Integer;
    Fpgr_nome: Integer;
    Fcod_cpf_mtr: string;
    Fmtr_nome: string;
    Fmtr_aux_cpf: string;
    Fmtr_aux_nome: string;
    Fcod_uf_origem: string;
    Fcod_cdd_orig: string;
    Fcidade_orig: string;
    Fcod_alvo_rig: Integer;
    Falvo_orig: string;
    Fcod_uf_destino: string;
    Fcod_cdd_destino: string;
    Fcidade_dest: string;
    Fcod_alvo_dest: Integer;
    Falvo_dest: string;
    Fcod_veiculo: string;
    Fcod_carreta1: string;
    Fcod_carreta2: string;
    Fcod_carreta3: string;
    Fcod_escolta: string;
    Fmoeda: string;
    Fvlr_mercadoria: Integer;
    Furl_isca: string;
    Furl_isca_usuario: string;
    Furl_isca_senha: string;
    Fdt_cadastro_sm: string;
    Fativo_: string;
    Fcod_usuario: Integer;
    Fusr_nome: string;
    Fodometro: Integer;
    Fstatus_sm: string;
    Fodometro_inicial: Integer;
    Fodometro_final: Integer;
    Fdiferenca_km: Integer;
  published
    property codigo_sm:          Integer  read Fcodigo_sm write Fcodigo_sm;
    property cod_embarcador:     Integer  read Fcod_embarcador write Fcod_embarcador;
    property num_interno:        Integer  read Fnum_interno write Fnum_interno;
    property num_documento:      string   read Fnum_documento write Fnum_documento;
    property num_cliente:        string   read Fnum_cliente write Fnum_cliente;
    property cod_ope:            Integer  read Fcod_ope write Fcod_ope;
    property prev_ini_viagem:    string   read Fprev_ini_viagem write Fprev_ini_viagem;
    property prev_fim_viagem:    string   read Fprev_fim_viagem write Fprev_fim_viagem;
    property ini_viagem:         string   read Fini_viagem write Fini_viagem;
    property fim_viagem:         string   read Ffim_viagem write Ffim_viagem;
    property cod_rota:           Integer  read Fcod_rota write Fcod_rota;
    property rota_nome:          string   read Frota_nome write Frota_nome;
    property rota_distancia:     string   read Frota_distancia write Frota_distancia;
    property cod_rotaux:         Integer  read Fcod_rotaux write Fcod_rotaux;
    property rota_aux_nome:      string   read Frota_aux_nome write Frota_aux_nome;
    property rota_aux_distancia: Integer  read Frota_aux_distancia write Frota_aux_distancia;
    property cod_pgr:            Integer  read Fcod_pgr write Fcod_pgr;
    property pgr_nome:           Integer  read Fpgr_nome write Fpgr_nome;
    property cod_cpf_mtr:        string   read Fcod_cpf_mtr write Fcod_cpf_mtr;
    property mtr_nome:           string   read Fmtr_nome write Fmtr_nome;
    property mtr_aux_cpf:        string   read Fmtr_aux_cpf write Fmtr_aux_cpf;
    property mtr_aux_nome:       string   read Fmtr_aux_nome write Fmtr_aux_nome;
    property cod_uf_origem:      string   read Fcod_uf_origem write Fcod_uf_origem;
    property cod_cdd_orig:       string   read Fcod_cdd_orig write Fcod_cdd_orig;
    property cidade_orig:        string   read Fcidade_orig write Fcidade_orig;
    property cod_alvo_rig:       Integer  read Fcod_alvo_rig write Fcod_alvo_rig;
    property alvo_orig:          string   read Falvo_orig write Falvo_orig;
    property cod_uf_destino:     string   read Fcod_uf_destino write Fcod_uf_destino;
    property cod_cdd_destino:    string   read Fcod_cdd_destino write Fcod_cdd_destino;
    property cidade_dest:        string   read Fcidade_dest write Fcidade_dest;
    property cod_alvo_dest:      Integer  read Fcod_alvo_dest write Fcod_alvo_dest;
    property alvo_dest:          string   read Falvo_dest write Falvo_dest;
    property cod_veiculo:        string   read Fcod_veiculo write Fcod_veiculo;
    property cod_carreta1:       string   read Fcod_carreta1 write Fcod_carreta1;
    property cod_carreta2:       string   read Fcod_carreta2 write Fcod_carreta2;
    property cod_carreta3:       string   read Fcod_carreta3 write Fcod_carreta3;
    property cod_escolta:        string   read Fcod_escolta write Fcod_escolta;
    property moeda:              string   read Fmoeda write Fmoeda;
    property vlr_mercadoria:     Integer  read Fvlr_mercadoria write Fvlr_mercadoria;
    property url_isca:           string   read Furl_isca write Furl_isca;
    property url_isca_usuario:   string   read Furl_isca_usuario write Furl_isca_usuario;
    property url_isca_senha:     string   read Furl_isca_senha write Furl_isca_senha;
    property dt_cadastro_sm:     string   read Fdt_cadastro_sm write Fdt_cadastro_sm;
    property ativo_:             string   read Fativo_ write Fativo_;
    property cod_usuario:        Integer  read Fcod_usuario write Fcod_usuario;
    property usr_nome:           string   read Fusr_nome write Fusr_nome;
    property odometro:           Integer  read Fodometro write Fodometro;
    property status_sm:          string   read Fstatus_sm write Fstatus_sm;
    property odometro_inicial:   Integer  read Fodometro_inicial write Fodometro_inicial;
    property odometro_final:     Integer  read Fodometro_final write Fodometro_final;
    property diferenca_km:       Integer  read Fdiferenca_km write Fdiferenca_km;
  end;



  // ************************************************************************ //
  // XML       : cancelaSmResponse, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  cancelaSmResponse = class(TRemotable)
  private
    FresponseCode: Integer;
    FresponseMessage: string;
    Fdados: string;
  published
    property responseCode:    Integer  read FresponseCode write FresponseCode;
    property responseMessage: string   read FresponseMessage write FresponseMessage;
    property dados:           string   read Fdados write Fdados;
  end;



  // ************************************************************************ //
  // XML       : getSMResponse, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  getSMResponse = class(TRemotable)
  private
    FresponseCode: Integer;
    FresponseMessage: string;
    Fdados: ListaSM;
  public
    destructor Destroy; override;
  published
    property responseCode:    Integer  read FresponseCode write FresponseCode;
    property responseMessage: string   read FresponseMessage write FresponseMessage;
    property dados:           ListaSM  read Fdados write Fdados;
  end;



  // ************************************************************************ //
  // XML       : parametrosSM, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  parametrosSM = class(TRemotable)
  private
    Fcod_operacao: Integer;
    Fnum_interno: string;
    Fnum_docto: string;
    Fcod_pgr: Integer;
    Fcod_rota: Integer;
    Fplaca: string;
    Fcarreta_01: string;
    Fcarreta_02: string;
    Fcarreta_03: string;
    Fcpf_motorista: string;
    Fcpf_motorista_aux: string;
    Fprev_inicio: string;
    Fprev_fim: string;
    Fisca_numero: string;
    Furl_isca: string;
    Fusuario_url: string;
    Fsenha_url: string;
    FListaMercadoriasSM: ListaMercadoriasSM;
    Fprod_homolog: string;
    Fcod_emb: Integer;
  public
    destructor Destroy; override;
  published
    property cod_operacao:       Integer             read Fcod_operacao write Fcod_operacao;
    property num_interno:        string              read Fnum_interno write Fnum_interno;
    property num_docto:          string              read Fnum_docto write Fnum_docto;
    property cod_pgr:            Integer             read Fcod_pgr write Fcod_pgr;
    property cod_rota:           Integer             read Fcod_rota write Fcod_rota;
    property placa:              string              read Fplaca write Fplaca;
    property carreta_01:         string              read Fcarreta_01 write Fcarreta_01;
    property carreta_02:         string              read Fcarreta_02 write Fcarreta_02;
    property carreta_03:         string              read Fcarreta_03 write Fcarreta_03;
    property cpf_motorista:      string              read Fcpf_motorista write Fcpf_motorista;
    property cpf_motorista_aux:  string              read Fcpf_motorista_aux write Fcpf_motorista_aux;
    property prev_inicio:        string              read Fprev_inicio write Fprev_inicio;
    property prev_fim:           string              read Fprev_fim write Fprev_fim;
    property isca_numero:        string              read Fisca_numero write Fisca_numero;
    property url_isca:           string              read Furl_isca write Furl_isca;
    property usuario_url:        string              read Fusuario_url write Fusuario_url;
    property senha_url:          string              read Fsenha_url write Fsenha_url;
    property ListaMercadoriasSM: ListaMercadoriasSM  read FListaMercadoriasSM write FListaMercadoriasSM;
    property prod_homolog:       string              read Fprod_homolog write Fprod_homolog;
    property cod_emb:            Integer             read Fcod_emb write Fcod_emb;
  end;



  // ************************************************************************ //
  // XML       : parametrosVeiculo, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  parametrosVeiculo = class(TRemotable)
  private
    Fcod_operacao: Integer;
    Fplaca: string;
    Fcod_vinculo_contratual: string;
    Fcod_marca: string;
    Fcod_tipo: string;
    Fcod_modelo: string;
    Fcod_carroceria: string;
    Fcod_empresa_consulta: string;
    Fdata_consulta: string;
    Fnum_autorizacao_consulta: string;
    Fnum_frota: string;
    Fvelocidade_maxima: string;
    Fcod_cor: string;
    Fano_fabricacao: string;
    Fuf_placa: string;
    Fcod_ibge_placa: string;
    Fvalidade_placa: string;
    Finicio_horario_restr: string;
    Ffim_horario_restr: string;
    Fprod_homolog: string;
  published
    property cod_operacao:             Integer  read Fcod_operacao write Fcod_operacao;
    property placa:                    string   read Fplaca write Fplaca;
    property cod_vinculo_contratual:   string   read Fcod_vinculo_contratual write Fcod_vinculo_contratual;
    property cod_marca:                string   read Fcod_marca write Fcod_marca;
    property cod_tipo:                 string   read Fcod_tipo write Fcod_tipo;
    property cod_modelo:               string   read Fcod_modelo write Fcod_modelo;
    property cod_carroceria:           string   read Fcod_carroceria write Fcod_carroceria;
    property cod_empresa_consulta:     string   read Fcod_empresa_consulta write Fcod_empresa_consulta;
    property data_consulta:            string   read Fdata_consulta write Fdata_consulta;
    property num_autorizacao_consulta: string   read Fnum_autorizacao_consulta write Fnum_autorizacao_consulta;
    property num_frota:                string   read Fnum_frota write Fnum_frota;
    property velocidade_maxima:        string   read Fvelocidade_maxima write Fvelocidade_maxima;
    property cod_cor:                  string   read Fcod_cor write Fcod_cor;
    property ano_fabricacao:           string   read Fano_fabricacao write Fano_fabricacao;
    property uf_placa:                 string   read Fuf_placa write Fuf_placa;
    property cod_ibge_placa:           string   read Fcod_ibge_placa write Fcod_ibge_placa;
    property validade_placa:           string   read Fvalidade_placa write Fvalidade_placa;
    property inicio_horario_restr:     string   read Finicio_horario_restr write Finicio_horario_restr;
    property fim_horario_restr:        string   read Ffim_horario_restr write Ffim_horario_restr;
    property prod_homolog:             string   read Fprod_homolog write Fprod_homolog;
  end;



  // ************************************************************************ //
  // XML       : SendSmResponse, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  SendSmResponse = class(TRemotable)
  private
    FresponseCode: Integer;
    FresponseMessage: string;
    Fdados: string;
  published
    property responseCode:    Integer  read FresponseCode write FresponseCode;
    property responseMessage: string   read FresponseMessage write FresponseMessage;
    property dados:           string   read Fdados write Fdados;
  end;



  // ************************************************************************ //
  // XML       : VeiculoResponse, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  VeiculoResponse = class(TRemotable)
  private
    FresponseCode: Integer;
    FresponseMessage: string;
    Fdados: ListaVeiculo;
  public
    destructor Destroy; override;
  published
    property responseCode:    Integer       read FresponseCode write FresponseCode;
    property responseMessage: string        read FresponseMessage write FresponseMessage;
    property dados:           ListaVeiculo  read Fdados write Fdados;
  end;



  // ************************************************************************ //
  // XML       : VinculoContratResponse, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  VinculoContratResponse = class(TRemotable)
  private
    FresponseCode: Integer;
    FresponseMessage: string;
    Fdados: ListaVinculoContrat;
  public
    destructor Destroy; override;
  published
    property responseCode:    Integer              read FresponseCode write FresponseCode;
    property responseMessage: string               read FresponseMessage write FresponseMessage;
    property dados:           ListaVinculoContrat  read Fdados write Fdados;
  end;



  // ************************************************************************ //
  // XML       : VeiculoModeloResponse, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  VeiculoModeloResponse = class(TRemotable)
  private
    FresponseCode: Integer;
    FresponseMessage: string;
    Fdados: ListaVeiculoModelo;
  public
    destructor Destroy; override;
  published
    property responseCode:    Integer             read FresponseCode write FresponseCode;
    property responseMessage: string              read FresponseMessage write FresponseMessage;
    property dados:           ListaVeiculoModelo  read Fdados write Fdados;
  end;



  // ************************************************************************ //
  // XML       : VeiculoMarcaResponse, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  VeiculoMarcaResponse = class(TRemotable)
  private
    FresponseCode: Integer;
    FresponseMessage: string;
    Fdados: ListaVeiculoMarca;
  public
    destructor Destroy; override;
  published
    property responseCode:    Integer            read FresponseCode write FresponseCode;
    property responseMessage: string             read FresponseMessage write FresponseMessage;
    property dados:           ListaVeiculoMarca  read Fdados write Fdados;
  end;



  // ************************************************************************ //
  // XML       : VeiculoCorResponse, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  VeiculoCorResponse = class(TRemotable)
  private
    FresponseCode: Integer;
    FresponseMessage: string;
    Fdados: ListaVeiculoCor;
  public
    destructor Destroy; override;
  published
    property responseCode:    Integer          read FresponseCode write FresponseCode;
    property responseMessage: string           read FresponseMessage write FresponseMessage;
    property dados:           ListaVeiculoCor  read Fdados write Fdados;
  end;



  // ************************************************************************ //
  // XML       : Alvo, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  Alvo = class(TRemotable)
  private
    Fcodigo: string;
    Fnome: string;
    Ftipo_parada: string;
    Flatitude: string;
    Flongitude: string;
  published
    property codigo:      string  read Fcodigo write Fcodigo;
    property nome:        string  read Fnome write Fnome;
    property tipo_parada: string  read Ftipo_parada write Ftipo_parada;
    property latitude:    string  read Flatitude write Flatitude;
    property longitude:   string  read Flongitude write Flongitude;
  end;



  // ************************************************************************ //
  // XML       : Cidade, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  Cidade = class(TRemotable)
  private
    Fcodigo: string;
    Fuf: string;
    Fcidade: string;
  published
    property codigo: string  read Fcodigo write Fcodigo;
    property uf:     string  read Fuf write Fuf;
    property cidade: string  read Fcidade write Fcidade;
  end;

  ListaCidades = array of Cidade;               { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }


  // ************************************************************************ //
  // XML       : CidadesResponse, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  CidadesResponse = class(TRemotable)
  private
    FresponseCode: Integer;
    FresponseMessage: string;
    Fdados: ListaCidades;
  public
    destructor Destroy; override;
  published
    property responseCode:    Integer       read FresponseCode write FresponseCode;
    property responseMessage: string        read FresponseMessage write FresponseMessage;
    property dados:           ListaCidades  read Fdados write Fdados;
  end;



  // ************************************************************************ //
  // XML       : Pgr, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  Pgr = class(TRemotable)
  private
    Fcodigo: string;
    Fnome: string;
    Fvigencia: string;
    Fapolice: string;
    Flimite: string;
  published
    property codigo:   string  read Fcodigo write Fcodigo;
    property nome:     string  read Fnome write Fnome;
    property vigencia: string  read Fvigencia write Fvigencia;
    property apolice:  string  read Fapolice write Fapolice;
    property limite:   string  read Flimite write Flimite;
  end;



  // ************************************************************************ //
  // XML       : Operacao, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  Operacao = class(TRemotable)
  private
    Fcodigo: string;
    Frazaosocial: string;
  published
    property codigo:      string  read Fcodigo write Fcodigo;
    property razaosocial: string  read Frazaosocial write Frazaosocial;
  end;

  ListaOperacao = array of Operacao;            { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }


  // ************************************************************************ //
  // XML       : OperacaoResponse, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  OperacaoResponse = class(TRemotable)
  private
    FresponseCode: Integer;
    FresponseMessage: string;
    Fdados: ListaOperacao;
  public
    destructor Destroy; override;
  published
    property responseCode:    Integer        read FresponseCode write FresponseCode;
    property responseMessage: string         read FresponseMessage write FresponseMessage;
    property dados:           ListaOperacao  read Fdados write Fdados;
  end;

  ListaPgr   = array of Pgr;                    { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  ListaRotas = array of Rota;                   { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }


  // ************************************************************************ //
  // XML       : RotasResponse, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  RotasResponse = class(TRemotable)
  private
    FresponseCode: Integer;
    FresponseMessage: string;
    Fdados: ListaRotas;
  public
    destructor Destroy; override;
  published
    property responseCode:    Integer     read FresponseCode write FresponseCode;
    property responseMessage: string      read FresponseMessage write FresponseMessage;
    property dados:           ListaRotas  read Fdados write Fdados;
  end;



  // ************************************************************************ //
  // XML       : PgrResponse, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  PgrResponse = class(TRemotable)
  private
    FresponseCode: Integer;
    FresponseMessage: string;
    Fdados: ListaPgr;
  public
    destructor Destroy; override;
  published
    property responseCode:    Integer   read FresponseCode write FresponseCode;
    property responseMessage: string    read FresponseMessage write FresponseMessage;
    property dados:           ListaPgr  read Fdados write Fdados;
  end;



  // ************************************************************************ //
  // XML       : Rota, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  Rota = class(TRemotable)
  private
    Fcodigo: string;
    Fnome: string;
  published
    property codigo: string  read Fcodigo write Fcodigo;
    property nome:   string  read Fnome write Fnome;
  end;



  // ************************************************************************ //
  // XML       : Moeda, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  Moeda = class(TRemotable)
  private
    Fcodigo: Integer;
    Ftipo: string;
    Fsimbolo: string;
    Fsituacao: string;
  published
    property codigo:   Integer  read Fcodigo write Fcodigo;
    property tipo:     string   read Ftipo write Ftipo;
    property simbolo:  string   read Fsimbolo write Fsimbolo;
    property situacao: string   read Fsituacao write Fsituacao;
  end;



  // ************************************************************************ //
  // XML       : Mercadoria, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  Mercadoria = class(TRemotable)
  private
    Fcod_cliente: string;
    Fcodigo_pgr: string;
    Fsub_limite: Double;
    Fnome_mercadoria: string;
    Fcodigo_mercadoria: string;
  published
    property cod_cliente:       string  read Fcod_cliente write Fcod_cliente;
    property codigo_pgr:        string  read Fcodigo_pgr write Fcodigo_pgr;
    property sub_limite:        Double  read Fsub_limite write Fsub_limite;
    property nome_mercadoria:   string  read Fnome_mercadoria write Fnome_mercadoria;
    property codigo_mercadoria: string  read Fcodigo_mercadoria write Fcodigo_mercadoria;
  end;

  ListaMercadoria = array of Mercadoria;        { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }


  // ************************************************************************ //
  // XML       : MercadoriaResponse, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  MercadoriaResponse = class(TRemotable)
  private
    FresponseCode: Integer;
    FresponseMessage: string;
    Fdados: ListaMercadoria;
  public
    destructor Destroy; override;
  published
    property responseCode:    Integer          read FresponseCode write FresponseCode;
    property responseMessage: string           read FresponseMessage write FresponseMessage;
    property dados:           ListaMercadoria  read Fdados write Fdados;
  end;

  ListaMoeda = array of Moeda;                  { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }
  ListaMotorista = array of Motorista;          { "http://connect.atlasgr.com.br/soap/Atlas"[GblCplx] }


  // ************************************************************************ //
  // XML       : MotoristaResponse, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  MotoristaResponse = class(TRemotable)
  private
    FresponseCode: Integer;
    FresponseMessage: string;
    Fdados: ListaMotorista;
  public
    destructor Destroy; override;
  published
    property responseCode:    Integer         read FresponseCode write FresponseCode;
    property responseMessage: string          read FresponseMessage write FresponseMessage;
    property dados:           ListaMotorista  read Fdados write Fdados;
  end;



  // ************************************************************************ //
  // XML       : MoedaResponse, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  MoedaResponse = class(TRemotable)
  private
    FresponseCode: Integer;
    FresponseMessage: string;
    Fdados: ListaMoeda;
  public
    destructor Destroy; override;
  published
    property responseCode:    Integer     read FresponseCode write FresponseCode;
    property responseMessage: string      read FresponseMessage write FresponseMessage;
    property dados:           ListaMoeda  read Fdados write Fdados;
  end;



  // ************************************************************************ //
  // XML       : Motorista, global, <complexType>
  // Namespace : http://connect.atlasgr.com.br/soap/Atlas
  // ************************************************************************ //
  Motorista = class(TRemotable)
  private
    Fcodigo: string;
    Fnome: string;
    Fcpf: string;
    Fcod_operacao: string;
    Fnome_operacao: string;
  published
    property codigo:        string  read Fcodigo write Fcodigo;
    property nome:          string  read Fnome write Fnome;
    property cpf:           string  read Fcpf write Fcpf;
    property cod_operacao:  string  read Fcod_operacao write Fcod_operacao;
    property nome_operacao: string  read Fnome_operacao write Fnome_operacao;
  end;


  // ************************************************************************ //
  // Namespace : http://connect.atlasgr.com.br/portalatlas/ui/V2/atlas.php
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // use       : encoded
  // binding   : AtlasBinding
  // service   : Atlas
  // port      : AtlasPort
  // URL       : https://connect.atlasgr.com.br:443/portalatlas/ui/V2/atlas.php
  // ************************************************************************ //
  AtlasPortType = interface(IInvokable)
  ['{F084267D-8CC2-6B78-3131-CD0612F336E4}']
    function  getLogradouro(const cod_cliente: Integer; const cod_usuario: Integer; const senha_usuario: string): LogradourosResponse; stdcall;
    function  getCidade(const cod_cliente: Integer; const cod_usuario: Integer; const senha_usuario: string; const uf: string): CidadesResponse; stdcall;
    function  getAlvo(const cod_cliente: Integer; const cod_usuario: Integer; const senha_usuario: string): AlvosResponse; stdcall;
    function  getEmpresaConsulta(const cod_cliente: Integer; const cod_usuario: Integer; const senha_usuario: string): EmpresaConsultaResponse; stdcall;
    function  getKM(const cod_cliente: Integer; const cod_usuario: Integer; const senha_usuario: string; const cod_sm: Integer): getKMResponse; stdcall;
    function  getMercadoria(const cod_cliente: Integer; const cod_usuario: Integer; const senha_usuario: string): MercadoriaResponse; stdcall;
    function  getMoeda(const cod_cliente: Integer; const cod_usuario: Integer; const senha_usuario: string): MoedaResponse; stdcall;
    function  getMotorista(const cod_cliente: Integer; const cod_usuario: Integer; const senha_usuario: string): MotoristaResponse; stdcall;
    function  getOperacao(const cod_cliente: Integer; const cod_usuario: Integer; const senha_usuario: string): OperacaoResponse; stdcall;
    function  getPgr(const cod_cliente: Integer; const cod_usuario: Integer; const senha_usuario: string): PgrResponse; stdcall;
    function  getRotas(const cod_cliente: Integer; const cod_usuario: Integer; const senha_usuario: string): RotasResponse; stdcall;
    function  getVeiculo(const cod_cliente: Integer; const cod_usuario: Integer; const senha_usuario: string): VeiculoResponse; stdcall;
    function  getVinculoContrat(const cod_cliente: Integer; const cod_usuario: Integer; const senha_usuario: string): VinculoContratResponse; stdcall;
    function  getVeiculoCarroceria(const cod_cliente: Integer; const cod_usuario: Integer; const senha_usuario: string): VinculoContratResponse; stdcall;
    function  getVeiculoCor(const cod_cliente: Integer; const cod_usuario: Integer; const senha_usuario: string): VeiculoCorResponse; stdcall;
    function  getVeiculoMarca(const cod_cliente: Integer; const cod_usuario: Integer; const senha_usuario: string): VeiculoMarcaResponse; stdcall;
    function  getVeiculoModelo(const cod_cliente: Integer; const cod_usuario: Integer; const senha_usuario: string; const cod_marca: string): VeiculoModeloResponse; stdcall;
    function  getVeiculoTipo(const cod_cliente: Integer; const cod_usuario: Integer; const senha_usuario: string): VeiculoTipoResponse; stdcall;
    function  getEmbarcador(const cod_cliente: Integer; const cod_usuario: Integer; const senha_usuario: string): EmbarcadorResponse; stdcall;
    function  sendMotorista(const cod_usuario: Integer; const senha_usuario: string; const cod_cliente: Integer; const parametrosMotorista: parametrosMotorista): sendMotoristaResponse; stdcall;
    function  sendVeiculo(const cod_usuario: Integer; const senha_usuario: string; const cod_cliente: Integer; const parametrosVeiculo: parametrosVeiculo): SendVeiculoResponse; stdcall;
    function  sendSm(const cod_usuario: Integer; const senha_usuario: string; const cod_cliente: Integer; const parametrosSM: parametrosSM): SendSmResponse; stdcall;
    function  getSM(const cod_cliente: Integer; const cod_usuario: Integer; const senha_usuario: string; const cod_sm: Integer; const cod_interno: Integer): getSMResponse; stdcall;
    function  cancelaSm(const cod_cliente: Integer; const cod_usuario: Integer; const senha_usuario: string; const cod_operacao: Integer; const cod_sm: Integer; const prod_homolog: string
                        ): cancelaSmResponse; stdcall;
  end;

function GetAtlasPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): AtlasPortType;


implementation
  uses System.SysUtils;

function GetAtlasPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): AtlasPortType;
const
  defWSDL = 'https://connect.atlasgr.com.br/portalatlas/ui/V2/atlas.php?wsdl';
  defURL  = 'https://connect.atlasgr.com.br:443/portalatlas/ui/V2/atlas.php';
  defSvc  = 'Atlas';
  defPrt  = 'AtlasPort';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as AtlasPortType);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


destructor LogradourosResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fdados)-1 do
    System.SysUtils.FreeAndNil(Fdados[I]);
  System.SetLength(Fdados, 0);
  inherited Destroy;
end;

destructor getKMResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fdados)-1 do
    System.SysUtils.FreeAndNil(Fdados[I]);
  System.SetLength(Fdados, 0);
  inherited Destroy;
end;

destructor EmpresaConsultaResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fdados)-1 do
    System.SysUtils.FreeAndNil(Fdados[I]);
  System.SetLength(Fdados, 0);
  inherited Destroy;
end;

destructor AlvosResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fdados)-1 do
    System.SysUtils.FreeAndNil(Fdados[I]);
  System.SetLength(Fdados, 0);
  inherited Destroy;
end;

destructor EmbarcadorResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fdados)-1 do
    System.SysUtils.FreeAndNil(Fdados[I]);
  System.SetLength(Fdados, 0);
  inherited Destroy;
end;

destructor VeiculoTipoResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fdados)-1 do
    System.SysUtils.FreeAndNil(Fdados[I]);
  System.SetLength(Fdados, 0);
  inherited Destroy;
end;

destructor getSMResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fdados)-1 do
    System.SysUtils.FreeAndNil(Fdados[I]);
  System.SetLength(Fdados, 0);
  inherited Destroy;
end;

destructor parametrosSM.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FListaMercadoriasSM)-1 do
    System.SysUtils.FreeAndNil(FListaMercadoriasSM[I]);
  System.SetLength(FListaMercadoriasSM, 0);
  inherited Destroy;
end;

destructor VeiculoResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fdados)-1 do
    System.SysUtils.FreeAndNil(Fdados[I]);
  System.SetLength(Fdados, 0);
  inherited Destroy;
end;

destructor VinculoContratResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fdados)-1 do
    System.SysUtils.FreeAndNil(Fdados[I]);
  System.SetLength(Fdados, 0);
  inherited Destroy;
end;

destructor VeiculoModeloResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fdados)-1 do
    System.SysUtils.FreeAndNil(Fdados[I]);
  System.SetLength(Fdados, 0);
  inherited Destroy;
end;

destructor VeiculoMarcaResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fdados)-1 do
    System.SysUtils.FreeAndNil(Fdados[I]);
  System.SetLength(Fdados, 0);
  inherited Destroy;
end;

destructor VeiculoCorResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fdados)-1 do
    System.SysUtils.FreeAndNil(Fdados[I]);
  System.SetLength(Fdados, 0);
  inherited Destroy;
end;

destructor CidadesResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fdados)-1 do
    System.SysUtils.FreeAndNil(Fdados[I]);
  System.SetLength(Fdados, 0);
  inherited Destroy;
end;

destructor OperacaoResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fdados)-1 do
    System.SysUtils.FreeAndNil(Fdados[I]);
  System.SetLength(Fdados, 0);
  inherited Destroy;
end;

destructor RotasResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fdados)-1 do
    System.SysUtils.FreeAndNil(Fdados[I]);
  System.SetLength(Fdados, 0);
  inherited Destroy;
end;

destructor PgrResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fdados)-1 do
    System.SysUtils.FreeAndNil(Fdados[I]);
  System.SetLength(Fdados, 0);
  inherited Destroy;
end;

destructor MercadoriaResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fdados)-1 do
    System.SysUtils.FreeAndNil(Fdados[I]);
  System.SetLength(Fdados, 0);
  inherited Destroy;
end;

destructor MotoristaResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fdados)-1 do
    System.SysUtils.FreeAndNil(Fdados[I]);
  System.SetLength(Fdados, 0);
  inherited Destroy;
end;

destructor MoedaResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fdados)-1 do
    System.SysUtils.FreeAndNil(Fdados[I]);
  System.SetLength(Fdados, 0);
  inherited Destroy;
end;

initialization
  { AtlasPortType }
  InvRegistry.RegisterInterface(TypeInfo(AtlasPortType), 'http://connect.atlasgr.com.br/portalatlas/ui/V2/atlas.php', 'UTF-8');
  InvRegistry.RegisterAllSOAPActions(TypeInfo(AtlasPortType), '|http://connect.atlasgr.com.br/portalatlas/ui/V2/atlas.php#getLogradouros'
                                                             +'|http://connect.atlasgr.com.br/portalatlas/ui/V2/atlas.php#getCidades'
                                                             +'|http://connect.atlasgr.com.br/portalatlas/ui/V2/atlas.php#getAlvos'
                                                             +'|http://connect.atlasgr.com.br/portalatlas/ui/V2/atlas.php#getEmpresaConsulta'
                                                             +'|http://connect.atlasgr.com.br/portalatlas/ui/V2/atlas.php#getKM'
                                                             +'|http://connect.atlasgr.com.br/portalatlas/ui/V2/atlas.php#getMercadoria'
                                                             +'|http://connect.atlasgr.com.br/portalatlas/ui/V2/atlas.php#getMoeda'
                                                             +'|http://connect.atlasgr.com.br/portalatlas/ui/V2/atlas.php#getMotorista'
                                                             +'|http://connect.atlasgr.com.br/portalatlas/ui/V2/atlas.php#getOperacao'
                                                             +'|http://connect.atlasgr.com.br/portalatlas/ui/V2/atlas.php#getPgr'
                                                             +'|http://connect.atlasgr.com.br/portalatlas/ui/V2/atlas.php#getRotas'
                                                             +'|http://connect.atlasgr.com.br/portalatlas/ui/V2/atlas.php#getVeiculo'
                                                             +'|http://connect.atlasgr.com.br/portalatlas/ui/V2/atlas.php#getVinculoContrat'
                                                             +'|http://connect.atlasgr.com.br/portalatlas/ui/V2/atlas.php#getVeiculoCor'
                                                             +'|http://connect.atlasgr.com.br/portalatlas/ui/V2/atlas.php#getVeiculoMarca'
                                                             +'|http://connect.atlasgr.com.br/portalatlas/ui/V2/atlas.php#getVeiculoModelo'
                                                             +'|http://connect.atlasgr.com.br/portalatlas/ui/V2/atlas.php#getVeiculoTipo'
                                                             +'|http://connect.atlasgr.com.br/portalatlas/ui/V2/atlas.php#getEmbarcador'
                                                             +'|http://connect.atlasgr.com.br/portalatlas/ui/V2/atlas.php#sendMotorista'
                                                             +'|http://connect.atlasgr.com.br/portalatlas/ui/V2/atlas.php#sendVeiculo'
                                                             +'|http://connect.atlasgr.com.br/portalatlas/ui/V2/atlas.php#sendSm'
                                                             +'|http://connect.atlasgr.com.br/portalatlas/ui/V2/atlas.php#getSM'
                                                             +'|http://connect.atlasgr.com.br/portalatlas/ui/V2/atlas.php#cancelaSm'
                                                             );
  RemClassRegistry.RegisterXSInfo(TypeInfo(ListaVeiculoMarca), 'http://connect.atlasgr.com.br/soap/Atlas', 'ListaVeiculoMarca');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ListaVeiculoModelo), 'http://connect.atlasgr.com.br/soap/Atlas', 'ListaVeiculoModelo');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ListaVeiculoCor), 'http://connect.atlasgr.com.br/soap/Atlas', 'ListaVeiculoCor');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ListaVinculoContrat), 'http://connect.atlasgr.com.br/soap/Atlas', 'ListaVinculoContrat');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ListaVeiculo), 'http://connect.atlasgr.com.br/soap/Atlas', 'ListaVeiculo');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ListaMercadoriasSM), 'http://connect.atlasgr.com.br/soap/Atlas', 'ListaMercadoriasSM');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ListaSM), 'http://connect.atlasgr.com.br/soap/Atlas', 'ListaSM');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ListaVeiculoTipo), 'http://connect.atlasgr.com.br/soap/Atlas', 'ListaVeiculoTipo');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ListaEmbarcador), 'http://connect.atlasgr.com.br/soap/Atlas', 'ListaEmbarcador');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ListaEmpresaConsulta), 'http://connect.atlasgr.com.br/soap/Atlas', 'ListaEmpresaConsulta');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ListaAlvos), 'http://connect.atlasgr.com.br/soap/Atlas', 'ListaAlvos');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ListaKM), 'http://connect.atlasgr.com.br/soap/Atlas', 'ListaKM');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ListaLogradouros), 'http://connect.atlasgr.com.br/soap/Atlas', 'ListaLogradouros');
  RemClassRegistry.RegisterXSClass(Logradouro, 'http://connect.atlasgr.com.br/soap/Atlas', 'Logradouro');
  RemClassRegistry.RegisterXSClass(EmpresaConsulta, 'http://connect.atlasgr.com.br/soap/Atlas', 'EmpresaConsulta');
  RemClassRegistry.RegisterXSClass(VeiculoTipo, 'http://connect.atlasgr.com.br/soap/Atlas', 'VeiculoTipo');
  RemClassRegistry.RegisterXSClass(Embarcador, 'http://connect.atlasgr.com.br/soap/Atlas', 'Embarcador');
  RemClassRegistry.RegisterXSClass(MercadoriaSM, 'http://connect.atlasgr.com.br/soap/Atlas', 'MercadoriaSM');
  RemClassRegistry.RegisterXSClass(Veiculo, 'http://connect.atlasgr.com.br/soap/Atlas', 'Veiculo');
  RemClassRegistry.RegisterXSClass(VeiculoCor, 'http://connect.atlasgr.com.br/soap/Atlas', 'VeiculoCor');
  RemClassRegistry.RegisterXSClass(VinculoContrat, 'http://connect.atlasgr.com.br/soap/Atlas', 'VinculoContrat');
  RemClassRegistry.RegisterXSClass(VeiculoModelo, 'http://connect.atlasgr.com.br/soap/Atlas', 'VeiculoModelo');
  RemClassRegistry.RegisterXSClass(VeiculoMarca, 'http://connect.atlasgr.com.br/soap/Atlas', 'VeiculoMarca');
  RemClassRegistry.RegisterXSClass(LogradourosResponse, 'http://connect.atlasgr.com.br/soap/Atlas', 'LogradourosResponse');
  RemClassRegistry.RegisterXSClass(KM, 'http://connect.atlasgr.com.br/soap/Atlas', 'KM');
  RemClassRegistry.RegisterXSClass(getKMResponse, 'http://connect.atlasgr.com.br/soap/Atlas', 'getKMResponse');
  RemClassRegistry.RegisterXSClass(EmpresaConsultaResponse, 'http://connect.atlasgr.com.br/soap/Atlas', 'EmpresaConsultaResponse');
  RemClassRegistry.RegisterXSClass(AlvosResponse, 'http://connect.atlasgr.com.br/soap/Atlas', 'AlvosResponse');
  RemClassRegistry.RegisterXSClass(sendMotoristaResponse, 'http://connect.atlasgr.com.br/soap/Atlas', 'sendMotoristaResponse');
  RemClassRegistry.RegisterXSClass(EmbarcadorResponse, 'http://connect.atlasgr.com.br/soap/Atlas', 'EmbarcadorResponse');
  RemClassRegistry.RegisterXSClass(SendVeiculoResponse, 'http://connect.atlasgr.com.br/soap/Atlas', 'SendVeiculoResponse');
  RemClassRegistry.RegisterXSClass(parametrosMotorista, 'http://connect.atlasgr.com.br/soap/Atlas', 'parametrosMotorista');
  RemClassRegistry.RegisterXSClass(VeiculoTipoResponse, 'http://connect.atlasgr.com.br/soap/Atlas', 'VeiculoTipoResponse');
  RemClassRegistry.RegisterXSClass(SM, 'http://connect.atlasgr.com.br/soap/Atlas', 'SM');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(SM), 'ativo_', '[ExtName="ativo "]');
  RemClassRegistry.RegisterXSClass(cancelaSmResponse, 'http://connect.atlasgr.com.br/soap/Atlas', 'cancelaSmResponse');
  RemClassRegistry.RegisterXSClass(getSMResponse, 'http://connect.atlasgr.com.br/soap/Atlas', 'getSMResponse');
  RemClassRegistry.RegisterXSClass(parametrosSM, 'http://connect.atlasgr.com.br/soap/Atlas', 'parametrosSM');
  RemClassRegistry.RegisterXSClass(parametrosVeiculo, 'http://connect.atlasgr.com.br/soap/Atlas', 'parametrosVeiculo');
  RemClassRegistry.RegisterXSClass(SendSmResponse, 'http://connect.atlasgr.com.br/soap/Atlas', 'SendSmResponse');
  RemClassRegistry.RegisterXSClass(VeiculoResponse, 'http://connect.atlasgr.com.br/soap/Atlas', 'VeiculoResponse');
  RemClassRegistry.RegisterXSClass(VinculoContratResponse, 'http://connect.atlasgr.com.br/soap/Atlas', 'VinculoContratResponse');
  RemClassRegistry.RegisterXSClass(VeiculoModeloResponse, 'http://connect.atlasgr.com.br/soap/Atlas', 'VeiculoModeloResponse');
  RemClassRegistry.RegisterXSClass(VeiculoMarcaResponse, 'http://connect.atlasgr.com.br/soap/Atlas', 'VeiculoMarcaResponse');
  RemClassRegistry.RegisterXSClass(VeiculoCorResponse, 'http://connect.atlasgr.com.br/soap/Atlas', 'VeiculoCorResponse');
  RemClassRegistry.RegisterXSClass(Alvo, 'http://connect.atlasgr.com.br/soap/Atlas', 'Alvo');
  RemClassRegistry.RegisterXSClass(Cidade, 'http://connect.atlasgr.com.br/soap/Atlas', 'Cidade');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ListaCidades), 'http://connect.atlasgr.com.br/soap/Atlas', 'ListaCidades');
  RemClassRegistry.RegisterXSClass(CidadesResponse, 'http://connect.atlasgr.com.br/soap/Atlas', 'CidadesResponse');
  RemClassRegistry.RegisterXSClass(Pgr, 'http://connect.atlasgr.com.br/soap/Atlas', 'Pgr');
  RemClassRegistry.RegisterXSClass(Operacao, 'http://connect.atlasgr.com.br/soap/Atlas', 'Operacao');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ListaOperacao), 'http://connect.atlasgr.com.br/soap/Atlas', 'ListaOperacao');
  RemClassRegistry.RegisterXSClass(OperacaoResponse, 'http://connect.atlasgr.com.br/soap/Atlas', 'OperacaoResponse');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ListaPgr), 'http://connect.atlasgr.com.br/soap/Atlas', 'ListaPgr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ListaRotas), 'http://connect.atlasgr.com.br/soap/Atlas', 'ListaRotas');
  RemClassRegistry.RegisterXSClass(RotasResponse, 'http://connect.atlasgr.com.br/soap/Atlas', 'RotasResponse');
  RemClassRegistry.RegisterXSClass(PgrResponse, 'http://connect.atlasgr.com.br/soap/Atlas', 'PgrResponse');
  RemClassRegistry.RegisterXSClass(Rota, 'http://connect.atlasgr.com.br/soap/Atlas', 'Rota');
  RemClassRegistry.RegisterXSClass(Moeda, 'http://connect.atlasgr.com.br/soap/Atlas', 'Moeda');
  RemClassRegistry.RegisterXSClass(Mercadoria, 'http://connect.atlasgr.com.br/soap/Atlas', 'Mercadoria');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ListaMercadoria), 'http://connect.atlasgr.com.br/soap/Atlas', 'ListaMercadoria');
  RemClassRegistry.RegisterXSClass(MercadoriaResponse, 'http://connect.atlasgr.com.br/soap/Atlas', 'MercadoriaResponse');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ListaMoeda), 'http://connect.atlasgr.com.br/soap/Atlas', 'ListaMoeda');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ListaMotorista), 'http://connect.atlasgr.com.br/soap/Atlas', 'ListaMotorista');
  RemClassRegistry.RegisterXSClass(MotoristaResponse, 'http://connect.atlasgr.com.br/soap/Atlas', 'MotoristaResponse');
  RemClassRegistry.RegisterXSClass(MoedaResponse, 'http://connect.atlasgr.com.br/soap/Atlas', 'MoedaResponse');
  RemClassRegistry.RegisterXSClass(Motorista, 'http://connect.atlasgr.com.br/soap/Atlas', 'Motorista');

end.