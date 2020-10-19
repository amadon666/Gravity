uses  GraphABC, Timers;
const G = 0.1;
      WIDTH = WindowWidth;
      HEIGHT = WindowHeight;
var dt:= 0.02;//шаг вычисления
type Body = record
   X: real;
   Y: real;
   VX: real;
   VY: real;
   R: real;
   M: real;
end;

var bodies : array of Body;

procedure Load();
   begin
     SetLength(bodies, 3);

     for var i:= 0 to bodies.Length - 1 do begin
      bodies[i].M:= random(1, 500);
      bodies[i].R:= random(1,30);
      bodies[i].VX:= 0;
      bodies[i].VY:= 0;
      bodies[i].X:= random() * WIDTH;
      bodies[i].Y:= random() * HEIGHT;
    end;
end;
///Гравитация
type Gravity2D = class
   a,ax,ay,dx,dy,r: real;
   ///Включена ли гравитация
   private _IsEnabledGravity: boolean;
   
   public procedure Draw();
      begin
        for var i:= 0 to bodies.length- 1 do begin
           bodies[i].X += bodies[i].VX * dt;
           bodies[i].Y += bodies[i].VY * dt;
           SetBrushColor(clBlue);
           Circle(Round(bodies[i].X),Round(bodies[i].Y),Round(bodies[i].R));
        end;
     end;
   
   public procedure Gravity();
       begin
         while true do begin
            ClearWindow;
            LockDrawing; 
               for var i:=0 to bodies.length- 1 do begin
                   for var j:=0 to bodies.Length - 1 do begin
                     if (i = j)then continue;
            
                     dx:= bodies[j].X - bodies[i].X;
                     dy:= bodies[j].Y - bodies[i].Y;
            
                     r:= dx * dx + dy * dy;
            
                     if (r < 0.1)then r:= 0.1;
            
                     a:= G * bodies[j].M / r;
            
                     r:= sqrt(r);
            
                     ax:= a * dx / r;
                     ay:= a * dy / r;
            
                     bodies[i].VX += ax * dt;
                     bodies[i].VY += ay * dt;
                     dt+= 0.1;
             end;
          end;
  
          Draw();
          Sleep(500);
          Redraw;
      end;
       
end;
       
   public constructor Create(IsEnabledGravity: boolean);
      begin
        _IsEnabledGravity:= IsEnabledGravity;
        
        if _IsEnabledGravity then Gravity()
        else Draw();
        
      end;
   
end;

var gr: Gravity2D;
begin
Load();
gr:= new Gravity2D(true);
end.
