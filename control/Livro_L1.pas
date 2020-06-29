unit Livro_L1;

interface

uses
  Db, DBClient, GenericDao, Livro_C1, TEntity, CAtribEntity,
  Firedac.comp.client, Grids,
  SysUtils;

Type
  TLivro_Control = Class

  private

    FID: integer;
    FNOME: String;
    FPUBLICACAO: String;
    FEDITORA: String;
    FRESUMO: String;
    TBLivro: TFDMemTable;
    function GetId: integer;
    function GetNome: String;
    procedure SetEditora(const Value: String);
    procedure SetId(const Value: integer);
    procedure SetNome(const Value: String);
    procedure SetPublicacao(const Value: String);
    procedure SetResumo(const Value: String);
    function GetEditora: String;
    function GetPublicacao: String;
    function GetResumo: String;
    procedure PopulaCampos;
  public
    Grid: TStringGrid;
    // Gatters and Setters
    property ID: integer read GetId write SetId;
    property NOME: String read GetNome write SetNome;
    property PUBLICACAO: String read GetPublicacao write SetPublicacao;
    property EDITORA: String read GetEditora write SetEditora;
    property RESUMO: String read GetResumo write SetResumo;
    // Metodos Principais da Classe
    function Gravar: Boolean;
    function Excluir: Boolean;
    procedure BuscarLivros;
    function BuscarLivro(ID: integer): Boolean;

    constructor Create;
    destructor Destroy;

  End;

implementation

{ TLivro_Control }

function TLivro_Control.BuscarLivro(ID: integer): Boolean;
var
  Livro: TLivro;
begin
  try
    Result := False;

    Livro := TLivro.Create;
    Livro.idlivro := ID;

    // Busca livro e ja preenche table para tratamentos
    TBLivro.Close;
    TBLivro.AppendData(Livro.BuscarLivro(Livro));

    if TBLivro.RecordCount > 0 then
    begin
      PopulaCampos;
      Result := True;
    end;

  finally
    Livro.Free;
  end;
end;

procedure TLivro_Control.BuscarLivros;
var
  index: integer;
  Livro: TLivro;
begin
  try
    Livro := TLivro.Create;
    TBLivro.Close;
    TBLivro.AppendData(Livro.BuscarLivros(Livro));

    Index := 1;
    Grid.RowCount := TBLivro.RecordCount + 1;
    while not TBLivro.Eof do
    begin
      Grid.Cells[1, index] := TBLivro.FieldByName('id').AsString;
      Grid.Cells[2, index] := TBLivro.FieldByName('nome').AsString;;
      Grid.Cells[3, index] := TBLivro.FieldByName('publicacao').AsString;;
      Grid.Cells[4, index] := TBLivro.FieldByName('editora').AsString;
      Grid.Cells[5, index] := TBLivro.FieldByName('resumo').AsString;

      Inc(Index);
      TBLivro.Next;
    end;
  finally
    Livro.Free;
  end;
end;

constructor TLivro_Control.Create;
begin
  inherited;
  TBLivro := TFDMemTable.Create(nil);
end;

destructor TLivro_Control.Destroy;
begin
  TBLivro.Free;
end;

function TLivro_Control.Excluir: Boolean;
var
  LivroExcluir: TLivro;
begin
  try
    LivroExcluir := TLivro.Create;
    LivroExcluir.idlivro := ID;
    Result := LivroExcluir.Excluir(LivroExcluir);
  finally
    LivroExcluir.Free;
  end;
end;

function TLivro_Control.GetEditora: String;
begin
  Result := FEDITORA;
end;

function TLivro_Control.GetId: integer;
begin
  Result := FID;
end;

function TLivro_Control.GetNome: String;
begin
  Result := FNOME;
end;

function TLivro_Control.GetPublicacao: String;
begin
  Result := FPUBLICACAO;
end;

function TLivro_Control.GetResumo: String;
begin
  Result := FRESUMO;
end;

function TLivro_Control.Gravar: Boolean;
var
  LivroGravar: TLivro;
begin
  try
    LivroGravar := TLivro.Create;
    LivroGravar.idlivro := ID;
    LivroGravar.NOME := NOME;
    LivroGravar.PUBLICACAO := StrToDate(PUBLICACAO);
    LivroGravar.EDITORA := EDITORA;
    LivroGravar.RESUMO := RESUMO;

    Result := LivroGravar.Gravar(LivroGravar)

  finally
    LivroGravar.Free;
  end;
end;

procedure TLivro_Control.PopulaCampos;
begin
  ID := TBLivro.FieldByName('id').AsInteger;
  NOME := TBLivro.FieldByName('nome').AsString;
  PUBLICACAO := TBLivro.FieldByName('publicacao').AsString;
  EDITORA := TBLivro.FieldByName('editora').AsString;
  RESUMO := TBLivro.FieldByName('resumo').AsString;
end;

procedure TLivro_Control.SetEditora(const Value: String);
begin
  FEDITORA := Value;
end;

procedure TLivro_Control.SetId(const Value: integer);
begin
  FID := Value;
end;

procedure TLivro_Control.SetNome(const Value: String);
begin
  FNOME := Value;
end;

procedure TLivro_Control.SetPublicacao(const Value: String);
begin
  FPUBLICACAO := Value;
end;

procedure TLivro_Control.SetResumo(const Value: String);
begin
  FRESUMO := Value;
end;

end.
