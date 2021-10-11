program AppConsole;

{$APPTYPE CONSOLE}

uses
  Windows, SysUtils;

var
  CloseEvent: THandle;
  ShouldClose: Boolean;
  Tick: Cardinal;
begin
  {>> On r�cup�re un handle sur l'�venement cr�e par le programme principal
  gr�ce � son nom (il faut �videmment mettre le meme dans les deux applis !!) }
  CloseEvent := OpenEvent(EVENT_ALL_ACCESS, False, 'APP_CONSOLE_CLOSE_EVENT');

  ShouldClose := False;

  Tick := GetTickCount;
  while not ShouldClose do
  begin
    Writeln(Format('Tourne depuis %d sec', [(GetTickCount - Tick) div 1000]));

    Sleep(1000);

    {>> V�rifie si l'�venement est signal�. Pour cela, on utilise la fonction
    d'attende de Windows avec un temps d'attente de z�ro seconde.
    Si la fonction r�ussit, c'est qu'il faut terminer l'application car
    l'�venement est donc signal� }
    ShouldClose := WaitForSingleObject(CloseEvent, 0) = WAIT_OBJECT_0;
  end;

  CloseHandle(CloseEvent);
end.
