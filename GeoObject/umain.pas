unit uMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, uFigure;

type

  { TfBalloon }

  TfBalloon = class(TForm)
    btStart: TButton;
    btReset: TButton;
    btStop: TButton;
    Pbox: TPaintBox;
    tm: TTimer;
    procedure btResetClick(Sender: TObject);
    procedure btStartClick(Sender: TObject);
    procedure btStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tmTimer(Sender: TObject);
  private
    { private declarations }
    Basket: TSquare;
    Balloon: TCircle;
    Rope1, Rope2: TLine;
  public
    { public declarations }
  end;

var
  fBalloon: TfBalloon;

implementation

{$R *.lfm}

{ TfBalloon }

procedure TfBalloon.FormCreate(Sender: TObject);
begin
  Basket := TSquare.create(Pbox.Canvas, clMaroon, 40, 390, 20);
  Rope1 := TLine.create(Pbox.Canvas, clMaroon, 30, 380, 30, 370);
  Rope2 := TLine.create(Pbox.Canvas, clMaroon, 49, 380, 49, 370);
  Balloon := TCircle.create(Pbox.Canvas, clRed, 40, 350, 20);
end;

procedure TfBalloon.tmTimer(Sender: TObject);
begin
  if Balloon.Radius < 50 then begin
    Balloon.Center := Point(Balloon.Center.X, Balloon.Center.Y - 1);
    Balloon.Radius := Balloon.Radius + 1;
    Balloon.draw;
  end else begin
    Balloon.move(2, -2);
    Rope1.move(2, -2);
    Rope2.move(2, -2);
    Basket.move(2, -2);
  end;

end;

procedure TfBalloon.btStartClick(Sender: TObject);
begin
  Basket.draw;
  Rope1.draw;
  Rope2.draw;
  Balloon.draw;
  tm.Enabled := True;
end;

procedure TfBalloon.btResetClick(Sender: TObject);
begin
  tm.Enabled := False;

  Basket.delete;
  Balloon.delete;
  Rope1.delete;
  Rope2.delete;

  Balloon.Center := point(40, 350);
  Balloon.Radius := 20;
  Basket.Center := point(40, 390);
  Rope1.Origin := point(30, 380);
  Rope1.Terminus := point(30, 370);
  Rope2.Origin := point(49, 380);
  Rope2.Terminus := point(49, 370);

  Basket.draw;
  Balloon.draw;
  Rope1.draw;
  Rope2.draw;
end;

procedure TfBalloon.btStopClick(Sender: TObject);
begin
  tm.Enabled := False;
end;

end.

