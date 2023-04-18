program snake;

uses crt;

const
     start_snlen = 3;
     max_snlen = 128;

var
   exit: boolean;
   xs, ys: array [1..max_snlen] of byte;
   snlen, score: integer;
   maxx, maxy: byte;
   dx, dy: integer;
   fx, fy: integer;
   ch: char;

procedure food; forward;
function eaten(x, y: byte): boolean; forward;

function crash(x, y: byte): boolean;
begin
     snlen := snlen - 1;
     crash := eaten(x, y);
     snlen := snlen + 1
end;

procedure beep;
begin
     sound(1760);
     delay(10);
     nosound
end;

procedure minor_tune;
begin
     sound(440);
     delay(100);
     sound(415);
     delay(100);
     sound(390);
     delay(100);
     nosound
end;

procedure move;
var
   x, y: integer;
   i: integer;
begin
     x := xs[snlen];
     y := ys[snlen];
     if (x = 1) and (dx < 0) then
        x := maxx
     else if (x = maxx) and (dx > 0) then
        x := 1
     else
        x := x + dx;
     if (y = 2) and (dy < 0) then
        y := maxy
     else if (y = maxy) and (dy > 0) then
        y := 2
     else
        y := y + dy;
     if (x = fx) and (y = fy) then
     begin
          beep;
          snlen := snlen + 1;
          if snlen >= max_snlen then
             exit := true
          else begin
            xs[snlen] := x;
            ys[snlen] := y
          end;
          food
     end else begin
         if crash(x, y) then
         begin
            exit := true;
            minor_tune
         end else begin
             for i := 1 to snlen-1 do
             begin
                  xs[i] := xs[i+1];
                  ys[i] := ys[i+1];
             end;
             xs[snlen] := x;
             ys[snlen] := y
         end
     end
end;

procedure init;
var
   i: integer;
begin
    clrscr;
    randomize;
    exit := false;
    maxx := lo(windmax);
    maxy := hi(windmax);
    dx := 1;
    dy := 0;
    score := 0;
    snlen := start_snlen;
    for i := 1 to snlen do
    begin
         xs[i] := maxx div 2 + i;
         ys[i] := maxy div 2;
    end
end;

procedure draw;
var
   i: integer;
begin
     for i := 1 to snlen do
     begin
          gotoxy(xs[i], ys[i]);
          write('S')
     end;
     gotoxy(fx, fy);
     write('F');
     gotoxy(1, 1);
     write('Score: ', score, '. Press ESC to quit.')
end;

function eaten(x, y: byte): boolean;
var
   i: integer;
begin
     eaten := false;
     for i := 1 to snlen do
     begin
         if (xs[i] = x) and (ys[i] = y) then
         begin
              eaten := true;
                    break;
         end
     end
end;

procedure food;
var
   no_snake: boolean;
begin
     no_snake := true;
     repeat
           fx := 1 + random(maxx);
           fy := 2 + random(maxy-1);
           no_snake := not eaten(fx, fy);
     until no_snake
end;

procedure ek;
begin
     sound(100);
     delay(40);
     nosound
end;

procedure gamover;
var
   cx, cy: byte;
begin
     clrscr;
     ek;
     cx := maxx div 2;
     cy := maxy div 2;
     gotoxy(cx - 6, cy);
     write('Game over...');
     gotoxy(cx - 6, cy + 1);
     write('Your score is ', score, '.');
     gotoxy(cx - 6, cy + 4);
     write('Press ENTER to quit.');
     readln;
     ek;
     clrscr;
end;

begin
    init;
    food;
    while not exit do
    begin
         draw;
         delay(200);
         if keypressed then
         begin
              ch := readkey;
              if ch = #27 then
                 exit := true;
              dx := 0;
              dy := 0;
              if ch = 'd' then
                 dx := 1;
              if ch = 'a' then
                 dx := -1;
              if ch = 's' then
                 dy := 1;
              if ch = 'w' then
                 dy := -1;
         end;
         gotoxy(xs[1], ys[1]); { wipe last char }
         write(' ');
         move;
         score := snlen - start_snlen
    end;
    gamover;
end.
