unit uStopwatch;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LCLIntf;

type
  TStopwatch = class(TObject)
    protected
      tStart, tStop: LongInt;
      active: Boolean;
    public
      constructor Create;
      procedure Start;
      procedure Stop;
      procedure Reset;
      function GetRuntime: Real; // Time in s between start and stop
  end;

implementation

constructor TStopwatch.Create;
begin
  inherited create;
  // Initialization
  tStart := 0;
  tStop := 0;
  active := false;
end;

procedure TStopwatch.Start;
begin
  if not active then begin
    tStart := LCLIntf.GetTickCount;
    active := true;
  end;
end;

procedure TStopwatch.Stop;
begin
  if active then begin
    tStop := LCLIntf.GetTickCount;
    active := false;
  end;
end;

procedure TStopwatch.reset;
begin
  if not active then begin
    tStart := 0;
    tStop := 0;
  end;
end;

function TStopwatch.GetRuntime: Real;
begin
  result := (tStop - tStart) / 1000;
end;

end.

