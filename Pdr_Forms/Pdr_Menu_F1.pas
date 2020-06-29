unit Pdr_Menu_F1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.Menus, Vcl.Imaging.jpeg;

type
  TFrm_Pdr_Menu_F1 = class(TForm)
    MmenuSistema: TMainMenu;
    Cadastro1: TMenuItem;
    Relatrios1: TMenuItem;
    Sobre1: TMenuItem;
    Sair1: TMenuItem;
    TbrSistema: TToolBar;
    StsSistema: TStatusBar;
    ImgSistema: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Pdr_Menu_F1: TFrm_Pdr_Menu_F1;

implementation

{$R *.dfm}

end.
