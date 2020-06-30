unit Login_F1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Pdr_Login_F1, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.ExtCtrls,
  Usuario_L1,Cad_Livro_F1;

type
  TFrm_Pdr_Login_F2 = class(TFrm_Pdr_Login_F1)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnEntrarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
  private
    { Private declarations }
    UsuarioConTrol : TUsuario_L1;
  public
    { Public declarations }
  end;

var
  Frm_Pdr_Login_F2: TFrm_Pdr_Login_F2;

implementation

{$R *.dfm}

procedure TFrm_Pdr_Login_F2.btnEntrarClick(Sender: TObject);
begin
  inherited;
  if EdtPdrUsuario.Text = '' then
  begin
    ShowMessage('O usuário precisa ser informado!');
    Exit;
  end;

  if EdtPdrPassword.Text = '' then
  begin
    ShowMessage('A Senha deve ser informada');
    Exit;
  end;

  if UsuarioConTrol.LoginUsuario(EdtPdrUsuario.Text,EdtPdrPassword.Text) then
  begin
    Self.Visible := False;
    Application.ProcessMessages;
    Application.CreateForm(TFrm_Cad_Livro_F1,Frm_Cad_Livro_F1);
  end
  else
    ShowMessage('Usuário ou senha inválidos. Verifique');

end;

procedure TFrm_Pdr_Login_F2.btnLimparClick(Sender: TObject);
begin
  inherited;
  EdtPdrUsuario.Clear;
  EdtPdrPassword.Clear;
end;

procedure TFrm_Pdr_Login_F2.btnSairClick(Sender: TObject);
begin
  inherited;
  Application.Terminate;
end;

procedure TFrm_Pdr_Login_F2.FormCreate(Sender: TObject);
begin
  inherited;
  UsuarioConTrol := TUsuario_L1.Create;
end;

procedure TFrm_Pdr_Login_F2.FormDestroy(Sender: TObject);
begin
  inherited;
  UsuarioConTrol.Free;
end;

end.
