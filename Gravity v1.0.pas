uses GraphABC;
 
const
  G = 0.01;
  clrFone = clWhite;
  dXY = 0.1;
  traceLen = 10000;
 
type
  tObject = class
    x, y, vx, vy, r, m : Real;
    clr : Color;
    traceL := 0;
    traceP := 0;
    traceX : array of Integer;
    traceY : array of Integer;
    
    constructor (x_, y_, r_, m_ : Real; clr_ : Color);
    begin
      x := x_; y := y_; r := r_; m := m_; clr := clr_; vx := 0; vy := 0;
      SetLength(traceX, traceLen); SetLength(traceY, traceLen);
    end;
    
    procedure Show;
    begin
      Pen.Color := clGray; Brush.Color := clr;
      if (x+r>0) and (x-r<Window.Width) and (y+r>0) and (y-r<Window.Height) then
        begin
          Circle(Round(x), Round(y), Round(r));
          if traceL < traceLen then
            begin
              traceX[traceL] := Round(x);
              traceY[traceL] := Round(y);
              for var i := 0 to traceL do PutPixel(traceX[i], traceY[i], clGray);
              traceL += 1;
            end
          else
            begin
              traceX[traceP] := Round(x);
              traceY[traceP] := Round(y);
              for var i := 0 to traceLen do PutPixel(traceX[i], traceY[i], clGray);
              traceP += 1;
              if traceP = traceLen then traceP := 0;
            end;
        end;
    end;
    
    procedure Gravity(o : tObject);
    begin
      var f := G*o.m / ((x-o.x)*(x-o.x)+(y-o.y)*(y-o.y));
      vx += (o.x-x)*f/m;
      vy += (o.y-y)*f/m;
      if (x-o.x)*(x-o.x)+(y-o.y)*(y-o.y)<(r+o.r)*(r+o.r) then
        (vx,vy):=(0,0);
      x += vx;
      y += vy;
    end;
  end;
 
var sun, player : tObject;
 
procedure Key(k : Integer);
begin
  case k of
    VK_D : player.vx += dXY;
    VK_A : player.vx -= dXY;
    VK_S : player.vy += dXY;
    VK_W : player.vy -= dXY;
  end;
end;
 
begin
  SetWindowSize(1000,800);
  Window.CenterOnScreen;
  LockDrawing;
  Window.Clear(clrFone);
  sun := New tObject(Window.Center.X, Window.Center.Y, 20, 1000, clYellow);
  player := New tObject(Window.Center.X, Window.Center.Y+300, 5, 1, clBlack);
  sun.Show; player.Show;
  Redraw;
  
  OnKeyDown := Key;
  repeat
    Sleep(5);
    player.Gravity(sun);
    Window.Clear; sun.Show; player.Show;
    Window.Caption := player.x.ToString + ' ' + player.y;
    Redraw;
  until False;
end.
