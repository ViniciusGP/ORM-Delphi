program SweetLibrary;

uses
  Vcl.Forms,
  TEntity in 'FRAMEWORK\TEntity.pas',
  CAtribEntity in 'FRAMEWORK\CAtribEntity.pas',
  GenericDao in 'FRAMEWORK\GenericDao.pas',
  Pdr_Cadastro_F1 in 'Pdr_Forms\Pdr_Cadastro_F1.pas' {Frm_Pdr_Cadastro_F1} ,
  Pdr_Login_F1 in 'Pdr_Forms\Pdr_Login_F1.pas' {Frm_Pdr_Login_F1} ,
  Cad_Livro_F1 in 'view\Cad_Livro_F1.pas' {Frm_Cad_Livro_F1} ,
  Livro_L1 in 'control\Livro_L1.pas',
  Pdr_Busca_S1pas in 'Pdr_Forms\Pdr_Busca_S1pas.pas' {Frm_Pdr_Busca_S1} ,
  Pdr_Menu_F1 in 'Pdr_Forms\Pdr_Menu_F1.pas' {Frm_Pdr_Menu_F1} ,
  // TbAluno in 'model\TbAluno.pas',
  Livro_C1 in 'model\Livro_C1.pas',
  srvModBaseDados
    in 'FRAMEWORK\srvModBaseDados.pas' {TDSServerModuleBaseDados: TDataModule} ,
  Vcl.Themes,
  Vcl.Styles,
  Login_F1 in 'view\Login_F1.pas' {Frm_Pdr_Login_F2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrm_Cad_Livro_F1, Frm_Cad_Livro_F1);
  Application.CreateForm(TTDSServerModuleBaseDados, TDSServerModuleBaseDados);
  Application.Run;

end.
