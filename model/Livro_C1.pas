unit Livro_C1;

interface
uses
  DB,TEntity,CAtribEntity,GenericDao,SysUtils,DateUtils,FireDac.Comp.client;

  Type
    [TableName('LIVROS')]
    TLivro = Class(TGenericEntity)
    private
    Dao : TGenericDAO;
    Fresumo: String;
    Fpublicacao: TDate;
    Fnome: String;
    Feditora: String;
    FidLivro: integer;
    procedure Seteditora(const Value: String);
    procedure Setnome(const Value: String);
    procedure Setpublicacao(const Value: TDate);
    procedure Setresumo(const Value: String);
    procedure Setlivro(const Value: integer);

    public

    constructor Create;
    destructor Destroy;
    [KeyField('ID')]
    [FieldName('ID')]
    property idlivro : integer read FidLivro write FidLivro;

    [FieldName('NOME')]
    property nome : String read Fnome write Setnome;
    [FieldName('PUBLICACAO')]
    property publicacao : TDate read Fpublicacao write Setpublicacao;
    [FieldName('EDITORA')]
    property editora : String read Feditora write Seteditora;
    [FieldName('RESUMO')]
    property resumo : String read Fresumo write Setresumo;

    //Metodos Principais da Classe
    function Gravar(Livro : TLivro) : Boolean;
    function Excluir(Livro : TLivro) : Boolean;
    function BuscarLivros(Livro : TLivro):TFDQuery;
    function BuscarLivro(Livro : TLivro):TFDQuery;

  End;

implementation

{ TLivro }

constructor TLivro.Create;
begin
  Fresumo := '';
  Fpublicacao := NOW;
  Fnome := '';
  Feditora := '';
  FidLivro := 0;
end;

destructor TLivro.Destroy;
begin

end;

function TLivro.BuscarLivro(Livro : Tlivro):TFDQuery;
begin
  Result := TGenericDAO.GetById(Livro);
end;

function TLivro.BuscarLivros(Livro : TLivro): TFDQuery;
begin
  Result := TGenericDAO.GetAll(Livro);
end;

function TLivro.Excluir(Livro : TLivro): Boolean;
begin
  Result := TGenericDAO.Delete(Livro);
end;

function TLivro.Gravar(Livro: TLivro): Boolean;
begin
  if Livro.idlivro > 0 then
  begin
    Result := TGenericDAO.Update(Livro);
  end else
  begin
    Result := TGenericDAO.Insert(Livro);
  end;
end;

procedure TLivro.Seteditora(const Value: String);
begin
  Feditora := Value;
end;

procedure TLivro.Setlivro(const Value: integer);
begin
  FidLivro := Value;
end;

procedure TLivro.Setnome(const Value: String);
begin
  Fnome := Value;
end;

procedure TLivro.Setpublicacao(const Value: TDate);
begin
   Fpublicacao := Value;
end;

procedure TLivro.Setresumo(const Value: String);
begin
  Fresumo := Value;
end;



end.
