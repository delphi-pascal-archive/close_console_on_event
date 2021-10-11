program AppConsole;

{$APPTYPE CONSOLE}

uses
  Windows, SysUtils;

var
  CloseEvent: THandle;
  ShouldClose: Boolean;
  Tick: Cardinal;
begin
  {>> On récupère un handle sur l'évenement crée par le programme principal
  grâce à son nom (il faut évidemment mettre le meme dans les deux applis !!) }
  CloseEvent := OpenEvent(EVENT_ALL_ACCESS, False, 'APP_CONSOLE_CLOSE_EVENT');

  ShouldClose := False;

  Tick := GetTickCount;
  while not ShouldClose do
  begin
    Writeln(Format('Tourne depuis %d sec', [(GetTickCount - Tick) div 1000]));

    Sleep(1000);

    {>> Vérifie si l'évenement est signalé. Pour cela, on utilise la fonction
    d'attende de Windows avec un temps d'attente de zéro seconde.
    Si la fonction réussit, c'est qu'il faut terminer l'application car
    l'évenement est donc signalé }
    ShouldClose := WaitForSingleObject(CloseEvent, 0) = WAIT_OBJECT_0;
  end;

  CloseHandle(CloseEvent);
end.
