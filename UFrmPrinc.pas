unit UFrmPrinc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ShellApi;

type
  TFrmPrinc = class(TForm)
    Button1: TButton;
    BtnClose: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
  private
    FEvent: THandle;
  end;

var
  FrmPrinc: TFrmPrinc;

implementation

{$R *.dfm}

procedure TFrmPrinc.FormCreate(Sender: TObject);
begin
  {>> Au démarrage de l'appli principale, on crée un event avec
  un identificateur unique }
  FEvent := CreateEvent(nil, True, False, 'APP_CONSOLE_CLOSE_EVENT');
end;

procedure TFrmPrinc.FormDestroy(Sender: TObject);
begin
  {>> A la fermeture, on n'oublie pas de le libérer }
  CloseHandle(FEvent);
end;

procedure TFrmPrinc.Button1Click(Sender: TObject);
begin
  {>> Démarrage de l'app console (on peut aussi utiliser CreateProcess,
  ça ne change rien au principe de fermeture }
  ShellExecute(0, nil, 'AppConsole.exe', nil, nil, SW_SHOW);
end;

procedure TFrmPrinc.BtnCloseClick(Sender: TObject);
begin
  {>> Pour fermer l'application, on lui signale qu'elle doit finir }
  SetEvent(FEvent);
end;

end.
