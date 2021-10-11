program DemoFermetureApp;

uses
  Forms,
  UFrmPrinc in 'UFrmPrinc.pas' {FrmPrinc};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrinc, FrmPrinc);
  Application.Run;
end.
