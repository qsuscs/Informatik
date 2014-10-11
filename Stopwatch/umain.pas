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
  lResult.Caption := 'Running';
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
end;

procedure TMainForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  watch1.Free;
end;

procedure TMainForm.shResetMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  watch1.Reset;
  lResult.Caption := 'Stopped';
end;

end.

