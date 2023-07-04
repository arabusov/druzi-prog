program anim;


uses graph, crt;

var
   info_boatVelo, info_appWindVelo, info_appWindAngle,
   info_boatAngle, info_realWindVelo, info_realWindAngle: string;

var
   v, phi, x, y, dx, dy: real;
   theta, u: real; { wind direction and velo }

function angle(vx, vy: real): real;
begin
     if vx > 0 then
         angle := arctan(vy/vx)
     else
         if vx < 0 then
         angle := pi+arctan(vy/vx)
         else if vy > 0 then
            angle := pi/2.0
         else
             angle := -pi/2.0;
end;

var
   sco_x, sco_y: array [1..3] of real;

const
     sh = 64;
     sw = 16;

procedure rotate_ship(a: real);
var
   i: integer;
   tmp: real;
begin
     for i:= 1 to 3 do
     begin
          tmp := sco_x[i];
          sco_x[i] := sco_x[i] * cos(a) - sco_y[i] * sin(a);
          sco_y[i] := tmp * sin(a) + sco_y[i] * cos(a);
     end;
end;

procedure shift_ship(x0, y0: real);
var
   i: integer;
begin
     for i:= 1 to 3 do
     begin
          sco_x[i] := sco_x[i] + x0;
          sco_y[i] := sco_y[i] + y0;
     end;
end;

procedure rline(x1, y1, x2, y2: real);
begin
     line(round(x1),getmaxy-round(y1),round(x2),getmaxy-round(y2));
end;

procedure draw_ship(color: integer);
var
   i: integer;
begin
     sco_x[1] := -sh;
     sco_x[2] := 0;
     sco_x[3] := -sh;
     sco_y[1] := -sw;
     sco_y[2] := 0;
     sco_y[3] :=  sw;
     rotate_ship(phi);
     shift_ship(x, y);
     setcolor(color);
     rline(sco_x[1], sco_y[1], sco_x[2], sco_y[2]);
     rline(sco_x[1], sco_y[1], sco_x[3], sco_y[3]);
     rline(sco_x[3], sco_y[3], sco_x[2], sco_y[2]);
end;

procedure draw_wind;
var
   x0, y0: real;
begin
     x0 := 60;
     y0 := getmaxy-60;
     rline(x0, y0, x0+u*cos(theta), y0+u*sin(theta));
     circle(round(x0), getmaxy-round(y0), round(u));
end;
procedure write_info;
begin
     outtextxy(getmaxx div 2, 10, info_boatVelo);
     outtextxy(getmaxx div 2, 40, info_realWindVelo);
     outtextxy(getmaxx div 2, 70, info_appWindVelo);
     outtextxy(getmaxx div 2, 100, info_boatAngle);
     outtextxy(getmaxx div 2, 130, info_realWindAngle);
     outtextxy(getmaxx div 2, 160, info_appWindAngle);
end;

procedure write_labels;
begin
     outtextxy(getmaxx div 2-100, 10, 'boatVelo');
     outtextxy(getmaxx div 2-100, 40, 'realWindVelo');
     outtextxy(getmaxx div 2-100, 70, 'appWindVelo');
     outtextxy(getmaxx div 2-100, 100, 'boatAngle');
     outtextxy(getmaxx div 2-100, 130, 'realWindAngle');
     outtextxy(getmaxx div 2-100, 160, 'appWindAngle');


end;

procedure draw_scene;
begin
     draw_ship(white);
     draw_wind;
     setcolor(white);
     write_info;
     delay(30);
     draw_ship(black);
     setcolor(black);
     write_info;
end;

procedure phys_ship;
begin
     x := x + dx;
     y := y + dy;
     if x > (getmaxx-sh) then
        x := x - getmaxx + sh + 1;
     if x < sh then
        x := x + getmaxx - sh - 1;
     if y > (getmaxy-sh) then
        y := y - getmaxy + sh + 1;
     if y < sh then
        y := y + getmaxy - sh - 1;
     v := sqrt(dx*dx + dy*dy);
     dx := v*cos(phi);
     dy := v*sin(phi);
end;

const
     wfa: real = 2.0;
     dfa: real = 0.02;


procedure phys_wind;
var
   wx, wy: real;
   wF, dragF: real;
   xi: real;
begin
     wx := u*cos(theta)-dx;
     wy := u*sin(theta)-dy;
     xi := angle(wx, wy);
     str(sqrt(dx*dx+dy*dy):0:1, info_boatVelo);
     str(sqrt(wx*wx+wy*wy):0:1, info_appWindVelo);
     str(phi*180/pi:0:1, info_boatAngle);
     str(xi*180/pi:0:1, info_appWindAngle);
     wF := wfa*sin(abs(xi-phi));
     dragF := dfa*(dx*dx + dy*dy);
     dx := dx + (wF - dragF)*cos(phi);
     dy := dy + (wF - dragF)*sin(phi)
end;

procedure phys;
begin
     phys_ship;
     phys_wind
end;

procedure init;
begin
     x := getmaxx div 2;
     y := getmaxy div 2;
     v := 1;
     phi := -pi*random(360)/180.0;
     dx := v*cos(phi);
     dy := v*sin(phi);
     u := 7;
     theta := -20.0/180.0*pi;
     str(u:0:1,info_realWindVelo);
     str(theta*180/pi:0:1,info_realWindAngle);
end;

var
   gd, gm: integer;
   ch: char;
const
   exitf: boolean = false;
begin
     randomize;
     gd := 0; {7;}
     gm := 0;
     initgraph(gd, gm, 'C:\TURBOP\BGI');
     settextstyle(defaultfont,horizdir, 1);
     rectangle(20,20,getmaxx, getmaxy);
     write_labels;
     init;
     repeat
           draw_scene;
           if keypressed then
           begin
              ch := readkey;
              if ord(ch) = 27 then
                 exitf := true;
              if ord(ch) = 0 then
              begin
                   ch := readkey;
                   if ord(ch) = 77 then
                      phi := phi - 0.05;
                   if ord(ch) = 75 then
                      phi := phi + 0.05;
                   if phi > pi then
                      phi := phi - 2*pi;
                   if phi < - pi then
                      phi := phi + 2*pi;
              end;
           end;
           phys;
     until exitf;
     draw_ship(white);
     closegraph
end.