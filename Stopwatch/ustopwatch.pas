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
      function Now: Real; // Current time in s
      property isActive: Boolean read active;
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

function TStopwatch.Now: Real;
begin
  if active then begin
    result := (LCLIntf.GetTickCount - tStart) / 1000;
  end else begin
    result := 0;
  end;
end;

end.

