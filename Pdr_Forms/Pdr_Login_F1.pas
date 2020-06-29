unit Pdr_Login_F1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin, Vcl.ExtCtrls;

type
  TFrm_Pdr_Login_F1 = class(TForm)
    PnlPdrFundo: TPanel;
    TlbPdrLogin: TToolBar;
    PnlPdrTitulo: TPanel;
    LblPdrUsuario: TLabel;
    EdtPdrUsuario: TEdit;
    LbrPdrPassword: TLabel;
    EdtPdrPassword: TEdit;
    ImgPdrListaImagens: TImageList;
    btnEntrar: TToolButton;
    btnLimpar: TToolButton;
    btnSair: TToolButton;
    btnSeparetor: TToolButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Pdr_Login_F1: TFrm_Pdr_Login_F1;

implementation

{$R *.dfm}

end.
