unit Cad_Usuarios_F1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Pdr_Cadastro_F1, System.ImageList,
  Vcl.ImgList, Vcl.Grids, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.ToolWin,
  System.Hash,Usuario_L1;

type
  TFrm_Cad_Usuarios_F1 = class(TFrm_Pdr_Cadastro_F1)
    LblId: TLabel;
    edtUsuario: TEdit;
    EdtNome: TEdit;
    lblNomeUsuario: TLabel;
    lblSenha: TLabel;
    edtSenha: TEdit;
    procedure TlbPdrCadGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pgCadastroChange(Sender: TObject);
    procedure TlbPdrCadNovoClick(Sender: TObject);
    procedure TlbPdrCadExcluirClick(Sender: TObject);
    procedure edtUsuarioExit(Sender: TObject);
    procedure EdtNomeExit(Sender: TObject);
    procedure edtSenhaExit(Sender: TObject);
    procedure TlbPdrCadSairClick(Sender: TObject);
  private
    { Private declarations }
    UsuarioControl : TUsuario_L1;

    procedure MontaCabecalhoGrid(grid: TStringGrid);
    procedure PopulaCampos;
    procedure LimpaCampos;
    procedure CarregaUsuarios;
    procedure SetaFoco;

  public
    { Public declarations }
  end;

var
  Frm_Cad_Usuarios_F1: TFrm_Cad_Usuarios_F1;

implementation

{$R *.dfm}

procedure TFrm_Cad_Usuarios_F1.CarregaUsuarios;
begin
  MontaCabecalhoGrid(grdLista);
  UsuarioControl.BuscarUsuarios;
end;

procedure TFrm_Cad_Usuarios_F1.EdtNomeExit(Sender: TObject);
begin
  inherited;
  UsuarioControl.NOME := EdtNome.Text;
end;

procedure TFrm_Cad_Usuarios_F1.edtSenhaExit(Sender: TObject);
var
  Crypto : THashSHA1;
begin
  inherited;
  if edtSenha.Text <> '' then
  begin
    UsuarioControl.SENHA := Crypto.GetHashString(edtSenha.Text);
  end;
end;

procedure TFrm_Cad_Usuarios_F1.edtUsuarioExit(Sender: TObject);
begin
  inherited;
  if Trim(edtUsuario.Text) <> '' then
  begin
    UsuarioControl.USUARIO := edtUsuario.Text;
    if UsuarioControl.BuscarUsuario(edtUsuario.Text) then
    begin
      PopulaCampos;
    end;
  end;
end;

procedure TFrm_Cad_Usuarios_F1.FormCreate(Sender: TObject);
begin
  inherited;
  UsuarioControl := TUsuario_L1.Create;
  UsuarioControl.grid := grdLista;

end;

procedure TFrm_Cad_Usuarios_F1.LimpaCampos;
begin
  edtUsuario.Clear;
  EdtNome.Clear;
  edtSenha.Clear;
  edtUsuario.SetFocus;
end;

procedure TFrm_Cad_Usuarios_F1.MontaCabecalhoGrid(grid: TStringGrid);
begin
  grid.ColWidths[0] := 10;
  grid.ColWidths[1] := 50;
  grid.ColWidths[2] := 200;

  grid.Cells[0, 0] := '';
  grid.Cells[1, 0] := 'Usuário';
  grid.Cells[2, 0] := 'Nome';

end;

procedure TFrm_Cad_Usuarios_F1.pgCadastroChange(Sender: TObject);
begin
  inherited;
  if pgCadastro.ActivePage = tbsLista then
  begin
    CarregaUsuarios;
  end;
end;

procedure TFrm_Cad_Usuarios_F1.PopulaCampos;
begin
  EdtUsuario.Text := UsuarioControl.USUARIO;
  EdtNome.Text    := UsuarioControl.NOME;
end;

procedure TFrm_Cad_Usuarios_F1.SetaFoco;
var
  Ctrl: TWinControl;
begin
  Ctrl := ActiveControl;
  ActiveControl := nil;
  PostMessage(TWinControl(Ctrl).Handle, WM_SETFOCUS, 0, 0);
  TWinControl(Ctrl).SetFocus;
end;

procedure TFrm_Cad_Usuarios_F1.TlbPdrCadExcluirClick(Sender: TObject);
begin
  inherited;
   if Trim(edtUsuario.Text) = '' then
  begin
    ShowMessage('Para excluir um Usuario preencha o código do usuario  ');
    Exit;
  end;

  if MessageDlg('Deseja realmente exclír este usuário?', mtConfirmation, mbYesNo,
    0) = mrYes then
  begin
    if UsuarioControl.Excluir then
    begin
      ShowMessage('Usuário excluído do sistema');
      LimpaCampos;
    end;
  end;
end;

procedure TFrm_Cad_Usuarios_F1.TlbPdrCadGravarClick(Sender: TObject);
var
  rash : THashSHA1;
begin
  inherited;
  SetaFoco;
  if Trim(edtUsuario.Text) = '' then
  begin
    ShowMessage('Informe o usuario do sistema');
    Exit;
  end;
  try
    if UsuarioControl.Gravar then
      ShowMessage('Registro gravado com sucesso');
  finally
    LimpaCampos;
    pgCadastro.ActivePage := tbsLista;
    CarregaUsuarios;
  end;

end;

procedure TFrm_Cad_Usuarios_F1.TlbPdrCadNovoClick(Sender: TObject);
begin
  inherited;
  LimpaCampos;
end;

procedure TFrm_Cad_Usuarios_F1.TlbPdrCadSairClick(Sender: TObject);
begin
  inherited;
  Application.Terminate;
end;

end.
