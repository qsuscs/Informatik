unit uMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, uStopwatch;

type

  { TMainForm }

  TMainForm = class(TForm)
    lResult: TLabel;
    shStop: TShape;
    shReset: TShape;
    shStart: TShape;
    shBody: TShape;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure shResetMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure shStartMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure shStopMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { private declarations }
    watch1: TStopwatch;
    watch2: TStopwatch;
  public
    { public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.shStartMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  watch1.Start;
  while watch1.isActive do begin
    lResult.Caption := format('%4.3f', [watch1.Now]);
    Application.ProcessMessages;
  end;
end;

procedure TMainForm.shStopMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  watch1.Stop;
  lResult.Caption := FloatToStr(watch1.getRuntime);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  watch1 := TStopwatch.Create;
  watch2 := TStopwatch.Create;
  watch2.Start;
end;

procedure TMainForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  watch1.Free;
  watch2.Stop;
  showmessage(FloatToStr(watch2.GetRuntime));
  watch2.Free;
end;

procedure TMainForm.shResetMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  watch1.Reset;
  lResult.Caption := 'Stopped';
end;

end.

