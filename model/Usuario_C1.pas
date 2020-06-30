unit Usuario_C1;

interface

uses
  DB,TEntity,CAtribEntity,GenericDao,SysUtils,DateUtils,FireDac.Comp.client;

type
  [TableName('USUARIOS')]
  TUsuario = class(TGenericEntity)

  private
    Dao : TGenericDAO;
    FUsuario: String;
    FNome: String;
    FSenha: String;
    FidLivro: integer;
    Fpublicacao: TDate;
    procedure Setnome(const Value: String);
    procedure SetSenha(const Value: String);
  protected

  public
    constructor Create;
    destructor Destroy;

    [KeyField('USUARIO')]
    [FieldName('USUARIO')]
    property usuario : String read FUsuario write FUsuario;

    [FieldName('NOME')]
    property nome : String read Fnome write Setnome;

    [FieldName('SENHA')]
    property senha : String read FSenha write SetSenha;

    //Metodos Principais da Classe
    function Gravar(Usuario : TUsuario) : Boolean;
    function Excluir(Usuario : TUsuario) : Boolean;
    function BuscarUsuario(Usuario : TUsuario):TFDQuery;
    function BuscarUsuarios(Usuario : TUsuario):TFDQuery;



  end;
implementation

{ TUsuario_C1 }

function TUsuario.BuscarUsuario(Usuario: TUsuario): TFDQuery;
begin
  Result := TGenericDAO.GetById(Usuario);
end;

function TUsuario.BuscarUsuarios(Usuario: TUsuario): TFDQuery;
begin
  Result := TGenericDAO.GetAll(Usuario);
end;

constructor TUsuario.Create;
begin
  FUsuario := '';
  FNome  := '';
  FSenha := '';
end;

destructor TUsuario.Destroy;
begin

end;

function TUsuario.Excluir(Usuario: TUsuario): Boolean;
begin
  Result := TGenericDAO.Delete(Usuario);
end;

function TUsuario.Gravar(Usuario: TUsuario): Boolean;
begin
  try
    Result := TGenericDAO.Insert(Usuario);
  except
    on E:Exception do
    begin
      Result := TGenericDAO.Update(Usuario);
    end;
  end;
end;

procedure TUsuario.Setnome(const Value: String);
begin
  Fnome := Value;
end;

procedure TUsuario.SetSenha(const Value: String);
begin
  FSenha := Value;
end;

end.
