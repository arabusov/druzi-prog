program div_mod_demo;

uses graph;

var gd, gm: integer;

const scale=8;

function scr_x(x: integer): word;
begin
    scr_x := (getmaxx - getmaxy) div 2 + scale*x;
end;

function scr_y(y: integer): word;
begin
    scr_y := getmaxy div 2 - scale*y;
end;

var x, y, sx, sy1, sy2: word;

var
    prev_sx, prev_sy1, prev_sy2: word;

const d = 7;

procedure grid;
var x, y, dY: integer;
const step=10;
begin
    setcolor(8);
    for x := 1 to (getmaxy div (scale*step)) do
    begin
        sx := scr_x(x*step);
        line(sx, 0, sx, getmaxy);
    end;
    dY := getmaxy div (scale*step);
    for y := -dY to dY do
    begin
        sy1 := scr_y(y*step);
        line (0, sy1, getmaxx, sy1);
    end;
    setcolor(15);
    sx := scr_x(0);
    line(sx, 0, sx, getmaxy);
    sy1 := scr_y(0);
    line(0, sy1, getmaxx, sy1);
end;

begin
    initgraph(gd, gm, 'C:\TP\BGI');
    grid;
    prev_sx := scr_x(0);
    prev_sy1 := scr_y(0);
    prev_sy2 := scr_y(0);
    for x := 1 to (getmaxy div scale) do
    begin
        y := x div d;
        sx := scr_x(x);
        sy1 := scr_y(y);
        setcolor(5);
        line(prev_sx, prev_sy1, sx, sy1);
        y := x mod d;
        sy2 := scr_y(y);
        setcolor(10);
        line(prev_sx, prev_sy2, sx, sy2);
        prev_sx := sx;
        prev_sy1 := sy1;
        prev_sy2 := sy2;
    end;
    readln;
    closegraph
end.
