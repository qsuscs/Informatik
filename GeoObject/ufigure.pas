unit uFigure;

interface

uses Graphics, Types, Math;

type
  TGeoObject = class(TObject)
    protected
      Canvas: TCanvas;
      xP, yP: Integer;
      procedure setP(new: TPoint);
      function getP: TPoint;
    public
      color: TColor;
      constructor create(iCanvas: TCanvas; iColor: TColor; ixP, iyP: Integer);
  end;

  TFigure = class(TGeoObject)
    protected
      d: Integer; // Don’t make d public, else d < 0 would be possible
      procedure setD(new: Integer);
    public
      constructor create(iCanvas: TCanvas; iColor: TColor;
        ixP, iyP, iD: Integer);
      property Center: TPoint read getP write setP;
  end;

  TCircle = class(TFigure)
    protected
      procedure construct;
    public
      procedure draw;
      procedure delete;
      procedure move(dX, dY: Integer);
      property Radius: Integer read d write setD;
  end;

  TSquare = class(TFigure)
    protected
      procedure construct;
    public
      procedure draw;
      procedure delete;
      procedure move(dX, dY: Integer);
      property Length: Integer read d write setD;
  end;

  TLine = class(TObject)
    protected
      Canvas: TCanvas;
      xP, yP, xQ, yQ: Integer;
      procedure setP(new: TPoint);
      function getP: TPoint;
      procedure setQ(new: TPoint);
      function getQ: TPoint;
      procedure construct;
    public
      color: TColor;
      constructor create(iCanvas: TCanvas; iColor: TColor;
        ixP, iyP, ixQ, iyQ: Integer);
      procedure draw;
      procedure delete;
      procedure move(dX, dY: Integer);
      property Origin: TPoint read getP write setP;
      property Terminus: TPoint read getQ write setQ;
      function Length: Real;
  end;


implementation

//TLine
constructor TLine.create(iCanvas: TCanvas; iColor: TColor;
  ixP, iyP, ixQ, iyQ: Integer);
begin
  inherited create;
  // Initialization
  Canvas := iCanvas;
  color := iColor;
  xP := ixP;
  yP := iyP;
  xQ := ixQ;
  yQ := iyQ;
end;

procedure TLine.setP(new: TPoint);
begin
  xP := new.X;
  yP := new.Y;
end;

procedure TLine.setQ(new: TPoint);
begin
  xQ := new.X;
  yQ := new.Y;
end;

function TLine.getP: TPoint;
begin
  result := point(xP, yP);
end;

function TLine.getQ: TPoint;
begin
  result := point(xQ, yQ);
end;

procedure TLine.construct;
begin
  Canvas.MoveTo(xP, yP);
  Canvas.LineTo(xQ, yQ);
end;

procedure TLine.draw;
begin
  Canvas.Pen.Color := color;
  Canvas.Brush.Color := color;
  construct;
end;

procedure TLine.delete;
begin
  Canvas.Pen.Color := clBackground;
  Canvas.Brush.Color := clBackground;
  construct;
end;

procedure TLine.move(dX, dY: Integer);
begin
  delete;
  xP += dX;
  yP += dY;
  xQ += dX;
  yQ += dY;
  draw;
end;

function TLine.Length: Real;
begin
  Result := sqrt(sqr(xQ - xP) + sqr(yQ - yP));
end;

// TSquare
procedure TSquare.construct;
begin
  Canvas.Rectangle(xP - d div 2, yP - d div 2, xP + d div 2, yP + d div 2);
end;

procedure TSquare.draw;
begin
  Canvas.Brush.Color := color;
  Canvas.Pen.Color := color;
  construct;
end;

procedure TSquare.delete;
begin
  Canvas.Brush.Color := clBackground;
  Canvas.Pen.Color := clBackground;
  construct;
end;

procedure TSquare.move(dX, dY: Integer);
begin
  delete;
  xP += dX;
  yP += dY;
  draw;
end;


// TCircle
procedure TCircle.construct;
begin
  Canvas.EllipseC(xP, yP, d, d);
end;

procedure TCircle.draw;
begin
  Canvas.Brush.Color := color;
  Canvas.Pen.Color := color;
  construct;
end;

procedure TCircle.delete;
begin
  Canvas.Brush.Color := clBackground;
  Canvas.Pen.Color := clBackground;
  construct;
end;

procedure TCircle.move(dX,dY: Integer);
begin
  delete;
  xP += dX;
  yP += dY;
  draw;
end;


// TFigure
constructor TFigure.create(iCanvas: TCanvas; iColor: TColor;
  ixP, iyP, iD: Integer);
begin
  inherited create(iCanvas, iColor, ixP, iyP);
  d := max(iD, 0); // no negative values
end;

procedure TFigure.setD(new: Integer);
begin
  if new > 0 then begin
    d := new;
  end else begin
    d := 0;
  end;
end;

// TGeoObject
constructor TGeoObject.create(iCanvas: TCanvas; iColor: TColor;
  ixP, iyP: Integer);
begin
  inherited create;
  Canvas := iCanvas;
  color := iColor;
  xP := ixP;
  yP := iyP;
end;

procedure TGeoObject.setP(new: TPoint);
begin
  xP := new.X;
  yP := new.Y;
end;

function TGeoObject.getP: TPoint;
begin
  Result := point(xP, yP);
end;

end.
