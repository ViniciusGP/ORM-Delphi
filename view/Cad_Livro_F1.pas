unit Cad_Livro_F1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList,
  Vcl.ImgList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.Mask,
  Data.DB, Vcl.Grids, Vcl.DBGrids, IPPeerClient, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, REST.Authenticator.Basic, REST.Json,
  Contnrs, Generics.collections, Pdr_Cadastro_F1, Livro_L1, GenericDao,
  Livro_C1,
  Datasnap.DBClient, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrm_Cad_Livro_F1 = class(TFrm_Pdr_Cadastro_F1)
    PnlIndividual: TPanel;
    LblComents: TLabel;
    LblEditora: TLabel;
    LblId: TLabel;
    LblPublicacao: TLabel;
    EdtEditora: TEdit;
    EdtId: TEdit;
    EdtNome: TEdit;
    MmoComents: TMemo;
    edtPublicacao: TDateTimePicker;
    procedure FormCreate(Sender: TObject);
    procedure EdtIdExit(Sender: TObject);
    procedure TlbPdrCadGravarClick(Sender: TObject);
    procedure TlbPdrCadSairClick(Sender: TObject);
    procedure TlbPdrCadNovoClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pgCadastroChange(Sender: TObject);
    procedure grdListaDblClick(Sender: TObject);
    procedure EdtNomeExit(Sender: TObject);
    procedure edtPublicacaoExit(Sender: TObject);
    procedure EdtEditoraExit(Sender: TObject);
    procedure MmoComentsExit(Sender: TObject);
    procedure TlbPdrCadExcluirClick(Sender: TObject);
  private
    { Private declarations }
    LivroControl: TLivro_Control;
    procedure MontaCabecalhoGrid(grid: TStringGrid);
    procedure PopulaCampos;
    procedure LimpaCampos;
    procedure CarregaLivros;

    // Esta funcao serve para forcar o foco em componentes que por padrao nao
    // recebem foco, como os TollButtons, BitButton e ect.
    procedure SetaFoco;

  public
    { Public declarations }
  end;

var
  Frm_Cad_Livro_F1: TFrm_Cad_Livro_F1;

implementation

{$R *.dfm}

procedure TFrm_Cad_Livro_F1.CarregaLivros;
begin
  MontaCabecalhoGrid(grdLista);
  LivroControl.BuscarLivros;
end;

procedure TFrm_Cad_Livro_F1.EdtEditoraExit(Sender: TObject);
begin
  inherited;
  LivroControl.EDITORA := EdtEditora.Text;
end;

procedure TFrm_Cad_Livro_F1.EdtIdExit(Sender: TObject);
begin
  inherited;
  if Trim(EdtId.Text) <> '' then
  begin
    if LivroControl.BuscarLivro(StrToIntDef(EdtId.Text, 0)) then
    begin
      PopulaCampos;
    end
    else
    begin
      ShowMessage('O livro pesquisado nao foi encontrado');
      LimpaCampos;
    end;
  end;
end;

procedure TFrm_Cad_Livro_F1.EdtNomeExit(Sender: TObject);
begin
  inherited;
  LivroControl.NOME := EdtNome.Text;
end;

procedure TFrm_Cad_Livro_F1.edtPublicacaoExit(Sender: TObject);
begin
  inherited;
  LivroControl.PUBLICACAO := DateToStr(edtPublicacao.Date);
end;

procedure TFrm_Cad_Livro_F1.FormCreate(Sender: TObject);
begin
  inherited;
  LivroControl := TLivro_Control.Create;
  LivroControl.grid := grdLista;

end;

procedure TFrm_Cad_Livro_F1.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(LivroControl);
end;

procedure TFrm_Cad_Livro_F1.grdListaDblClick(Sender: TObject);
begin
  inherited;
  EdtId.Text := grdLista.Cells[grdLista.Col, grdLista.Row];
  EdtIdExit(Sender);
  pgCadastro.ActivePageIndex := 0;
end;

procedure TFrm_Cad_Livro_F1.LimpaCampos;
Var
  IdComponente: Integer;
begin
  for IdComponente := 0 to Pred(ComponentCount)do
  begin
    if (Components[IdComponente] is TEdit) or (Components[IdComponente] is TMaskEdit) or
      (Components[IdComponente] is TMemo) then
    begin
      TEdit(Components[IdComponente]).Clear;
    end;
  end;
end;

procedure TFrm_Cad_Livro_F1.MmoComentsExit(Sender: TObject);
begin
  inherited;
  LivroControl.RESUMO := MmoComents.Text;
end;

procedure TFrm_Cad_Livro_F1.MontaCabecalhoGrid(grid: TStringGrid);
begin
  grid.ColWidths[0] := 10;
  grid.ColWidths[1] := 50;
  grid.ColWidths[2] := 200;
  grid.ColWidths[3] := 100;
  grid.ColWidths[4] := 200;
  grid.ColWidths[5] := 250;

  grid.Cells[0, 0] := '';
  grid.Cells[1, 0] := 'Id';
  grid.Cells[2, 0] := 'Nome';
  grid.Cells[3, 0] := 'Publicação';
  grid.Cells[4, 0] := 'Editora';
  grid.Cells[5, 0] := 'Resumo';
end;

procedure TFrm_Cad_Livro_F1.pgCadastroChange(Sender: TObject);
begin
  inherited;
  if pgCadastro.ActivePage = tbsLista then
  begin
    CarregaLivros;
  end;

end;

procedure TFrm_Cad_Livro_F1.PopulaCampos;
begin
  EdtId.Text := IntToStr(LivroControl.ID);
  EdtNome.Text := LivroControl.NOME;
  edtPublicacao.Date := StrToDate(LivroControl.PUBLICACAO);
  MmoComents.Text := LivroControl.RESUMO;
  EdtEditora.Text := LivroControl.EDITORA;
end;

procedure TFrm_Cad_Livro_F1.SetaFoco;
var
  Ctrl: TWinControl;
begin
  Ctrl := ActiveControl;
  ActiveControl := nil;
  PostMessage(TWinControl(Ctrl).Handle, WM_SETFOCUS, 0, 0);
  TWinControl(Ctrl).SetFocus;
end;

procedure TFrm_Cad_Livro_F1.TlbPdrCadExcluirClick(Sender: TObject);
begin
  inherited;
  if Trim(EdtId.Text) = '' then
  begin
    ShowMessage('Para excluir um livro preencha o ID');
    Exit;
  end;

  if MessageDlg('Deseja realmente exclír este livro?', mtConfirmation, mbYesNo,
    0) = mrYes then
  begin
    if LivroControl.Excluir then
    begin
      ShowMessage('Livro excluído do sistema');
      LimpaCampos;
    end;
  end;

end;

procedure TFrm_Cad_Livro_F1.TlbPdrCadGravarClick(Sender: TObject);
begin
  inherited;
  SetaFoco;
  if Trim(EdtNome.Text) = '' then
  begin
    ShowMessage('Informe o nome do livro');
    Exit;
  end;
  try
    if LivroControl.Gravar then
      ShowMessage('Registro gravado com sucesso');
  finally
    LimpaCampos;
    pgCadastro.ActivePage := tbsLista;
    CarregaLivros;
  end;

end;

procedure TFrm_Cad_Livro_F1.TlbPdrCadNovoClick(Sender: TObject);
begin
  inherited;
  pgCadastro.ActivePage := tbsIndividual;
  LimpaCampos;
  EdtNome.SetFocus;
end;

procedure TFrm_Cad_Livro_F1.TlbPdrCadSairClick(Sender: TObject);
begin
  inherited;
  Application.Terminate;
end;

end.
