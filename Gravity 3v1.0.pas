uses Graph3D;

const G = 1e-4;
var WIDTH := Window.Width;
    HEIGHT := Window.Height;

var dt:= 0.02;//шаг вычисления
type Body = record
   X: real;
   Y: real;
   Z: real;
   VX: real;
   VY: real;
   VZ: real;
   R: real;
   M: real;
end;

var bodies : array of Body;

procedure Load();
   begin
     SetLength(bodies, 3);
     View3D.BackgroundColor:= Colors.Black;

     for var i:= 0 to bodies.Length - 1 do begin
      bodies[i].M:= random(1, 500);
      bodies[i].R:= random(1,10);
      bodies[i].VX:= 0;
      bodies[i].VY:= 0;
      bodies[i].VZ:= 0;
      bodies[i].X:= random(1,50);
      bodies[i].Y:= random(1,50);
      bodies[i].Z:= random(1,50);
    end;
end;
type Gravity3D = class
    a,ax,ay,dx,dy,r: real;
    planets: array of SphereT;
   ///Включена ли гравитация
   private _IsEnabledGravity: boolean;
   
   public procedure Draw();
      begin
        for var i:= 0 to bodies.length- 1 do begin
           bodies[i].X += bodies[i].VX * dt;
           bodies[i].Y += bodies[i].VY * dt;
           bodies[i].Z += bodies[i].VZ * dt;
           planets[i]:= Sphere(bodies[i].X,bodies[i].Y,bodies

[i].Z,bodies[i].R,Colors.Aqua);
           planets[i].Material:= ImageMaterial('H:\Images\Текстуры

\map_mercury.jpg');
        end;
     end;
     
   public procedure Gravity();
       begin
      View3d.ShowViewCube:= true;
      
         while true do begin
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
          Sleep(90);
      end;
end;

    public constructor Create();
      begin
        SetLength(planets, 3);
      end;

end;

var gr3: Gravity3D:= new Gravity3D();
begin
Load();
gr3.Gravity();
end.
