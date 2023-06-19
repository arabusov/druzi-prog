program sqrt_demo;

uses graph;

var gd, gm: integer;

const scale=8;

function scr_x(x: real): word;
begin
    scr_x := (getmaxx - getmaxy) div 2 + round(scale*x);
end;

function scr_y(y: real): word;
begin
    scr_y := getmaxy div 2 - round(scale*y);
end;

var
    sx, sy1: word;
    prev_sx, prev_sy1: word;

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

var x, y: real;

begin
    initgraph(gd, gm, 'C:\TP\BGI');
    grid;
    prev_sx := scr_x(0);
    prev_sy1 := scr_y(0);
    x := 0.;
    while x < (getmaxy div scale) do
    begin
        y := 3.*sqrt(x);
        sx := scr_x(x);
        sy1 := scr_y(y);
        setcolor(5);
        line(prev_sx, prev_sy1, sx, sy1);
        prev_sx := sx;
        prev_sy1 := sy1;
        x := x + 1;
    end;
    readln;
    closegraph
end.
