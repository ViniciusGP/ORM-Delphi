unit srvModBaseDados;

interface

uses
  System.SysUtils, System.Classes, Data.DBXMySql, Data.FMTBcd, Data.DB,
  Data.SqlExpr, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG, FireDAC.Phys.PGDef,
  FireDAC.Comp.Client, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Phys.SQLiteVDataSet, ZAbstractConnection, ZConnection,Vcl.dialogs;

type
  TTDSServerModuleBaseDados = class(TDataModule)
    LSCONEXAO: TSQLConnection;
    FDConexao: TFDConnection;
    ZConexao: TZConnection;
    SQLDSSERVIDOR: TSQLDataSet;
    FDQuery: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    //Funcoes para o banco de dados
    function Conectar:Boolean;
    function Desconectar:Boolean;
    //funcoes para manipular as entidades
    function getDataSet(strQry:String):TFDQuery;
    function execSql(strQry:String):Boolean;
  end;

var
  TDSServerModuleBaseDados: TTDSServerModuleBaseDados;

implementation
 {$R *.dfm}

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TTDSServerModuleBaseDados }

function TTDSServerModuleBaseDados.Conectar: Boolean;
begin
  try
    FDConexao.Connected := True;
    Result := True;
  except
    Result := False;
  end;
end;

function TTDSServerModuleBaseDados.Desconectar: Boolean;
begin
  try
    FDConexao.Connected := False;
    Result := False;
  except
    Result := False;
  end;
end;

function TTDSServerModuleBaseDados.execSql(strQry: String): Boolean;
begin
  result := false;
  FDQuery.Close;
  FDQuery.Params.Clear;
  FDQuery.Sql.Text := strQry;
  try
    FDQuery.ExecSQL;
    result := true;
  except
    on e: Exception do
    begin
      raise Exception.Create(e.Message)
    end;
  end;
end;

function TTDSServerModuleBaseDados.getDataSet(strQry: String): TFDQuery;
begin
  try
    FDQuery.Close;
    FDQuery.Params.Clear;
    FDQuery.SQL.Text :=  strQry;
    FDQuery.Open;
    Result := FDQuery;

  Except
    on E:Exception do
    ShowMessage(E.Message);
  end;

end;

end.
