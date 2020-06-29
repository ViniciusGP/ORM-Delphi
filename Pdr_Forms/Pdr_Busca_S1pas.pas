unit Pdr_Busca_S1pas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids;

type
  TFrm_Pdr_Busca_S1 = class(TForm)
    PnlPdrFundo: TPanel;
    PnlPdrTitulo: TPanel;
    TlbPdrLogin: TToolBar;
    btnSelecionar: TToolButton;
    btnLimpar: TToolButton;
    btnSeparetor: TToolButton;
    btnSair: TToolButton;
    ImgPdrListaImagens: TImageList;
    grdLista: TStringGrid;
    pnlBusca: TPanel;
    lblBusca: TLabel;
    edtBuscaItem: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Pdr_Busca_S1: TFrm_Pdr_Busca_S1;

implementation

{$R *.dfm}

end.
