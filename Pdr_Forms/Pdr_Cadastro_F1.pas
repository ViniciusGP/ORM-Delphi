unit Pdr_Cadastro_F1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.ToolWin, Vcl.Grids, Vcl.StdCtrls;

type
  TFrm_Pdr_Cadastro_F1 = class(TForm)
    stbCadPadrao: TStatusBar;
    TlbCadBotoesPadrao: TToolBar;
    PnlFundoCadPadrao: TPanel;
    TlbPdrCadNovo: TToolButton;
    TlbPdrCadGravar: TToolButton;
    TlbPdrCadExcluir: TToolButton;
    TlbPdrCadSeparator: TToolButton;
    TlbPdrCadSair: TToolButton;
    ImgPdrListaImagens: TImageList;
    PnlPdrTitulo: TPanel;
    pgCadastro: TPageControl;
    tbsIndividual: TTabSheet;
    tbsLista: TTabSheet;
    pnlBusca: TPanel;
    lblBusca: TLabel;
    edtBuscaItem: TEdit;
    grdLista: TStringGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Pdr_Cadastro_F1: TFrm_Pdr_Cadastro_F1;

implementation

{$R *.dfm}

end.
