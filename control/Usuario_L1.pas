unit Usuario_L1;

interface

uses
  Db, DBClient, GenericDao, Usuario_C1, TEntity, CAtribEntity,
  Firedac.comp.client, Grids,
  SysUtils;

type
  TUsuario_L1 = class

  private
    FUSUARIO: String;
    FNOME: String;
    FSENHA: String;
    TBUsuario: TFDMemTable;
    function GetNome: String;
    function GetSenha: String;
    function GetUsuario: String;
    procedure SetNome(const Value: String);
    procedure SetSenha(const Value: String);
    procedure SetUsuario(const Value: String);

    procedure PopulaCampos;
  protected

  public
    Grid: TStringGrid;
    // Gatters and Setters
    property USUARIO: String read GetUsuario write SetUsuario;
    property NOME: String read GetNome write SetNome;
    property SENHA: String read GetSenha write SetSenha;

    // Metodos Principais da Classe
    function Gravar: Boolean;
    function Excluir: Boolean;
    procedure BuscarUsuarios;
    function BuscarUsuario(Usuario: String): Boolean;

    constructor Create;
    destructor Destroy;
  end;

implementation

{ TUsuario_L1 }

function TUsuario_L1.BuscarUsuario(Usuario: String): Boolean;
var
  vltUsuario: TUsuario;
begin
  try
    Result := False;

    vltUsuario := TUsuario.Create;
    vltUsuario.usuario := USUARIO;

    // Busca livro e ja preenche table para tratamentos
    TBUsuario.Close;
    TBUsuario.AppendData(vltUsuario.BuscarUsuario(vltUsuario));

    if TBUsuario.RecordCount > 0 then
    begin
      PopulaCampos;
      Result := True;
    end;

  finally
    vltUsuario.Free;
  end;

end;

procedure TUsuario_L1.BuscarUsuarios;
var
  Index: integer;
  Usuario: TUsuario;
begin
  try
    Usuario := TUsuario.Create;
    TBUsuario.Close;
    TBUsuario.AppendData(Usuario.BuscarUsuarios(Usuario));

    Index := 1;
    Grid.RowCount := TBUsuario.RecordCount + 1;
    while not TBUsuario.Eof do
    begin
      Grid.Cells[1, index] := TBUsuario.FieldByName('usuario').AsString;
      Grid.Cells[2, index] := TBUsuario.FieldByName('nome').AsString;;
      Inc(Index);
      TBUsuario.Next;
    end;
  finally
    Usuario.Free;
  end;
end;

constructor TUsuario_L1.Create;
begin
  TBUsuario := TFDMemTable.Create(nil);
end;

destructor TUsuario_L1.Destroy;
begin
 TBUsuario.Free;
end;

function TUsuario_L1.Excluir: Boolean;
var
  UsuarioExcluir: TUsuario;
begin
  try
    UsuarioExcluir := TUsuario.Create;
    UsuarioExcluir.usuario := USUARIO;
    Result := UsuarioExcluir.Excluir(UsuarioExcluir);
  finally
    UsuarioExcluir.Free;
  end;
end;

function TUsuario_L1.GetNome: String;
begin
  Result := FNOME;
end;

function TUsuario_L1.GetSenha: String;
begin
  Result := FSENHA;
end;

function TUsuario_L1.GetUsuario: String;
begin
  Result := FUSUARIO;
end;

function TUsuario_L1.Gravar: Boolean;
var
  UsuarioGravar: TUsuario;
begin
  try
    UsuarioGravar := TUsuario.Create;
    UsuarioGravar.usuario := USUARIO;
    UsuarioGravar.nome := NOME;
    UsuarioGravar.senha := SENHA;
    Result := UsuarioGravar.Gravar(UsuarioGravar)

  finally
    UsuarioGravar.Free;
  end;

end;

procedure TUsuario_L1.PopulaCampos;
begin
  USUARIO := TBUsuario.FieldByName('usuario').AsString;
  NOME    := TBUsuario.FieldByName('nome').AsString;
end;

procedure TUsuario_L1.SetNome(const Value: String);
begin
  FNOME := Value;
end;

procedure TUsuario_L1.SetSenha(const Value: String);
begin
  FSENHA := Value;
end;

procedure TUsuario_L1.SetUsuario(const Value: String);
begin
  FUSUARIO := Value;
end;

end.
