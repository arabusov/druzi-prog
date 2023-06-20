program rectangles_gcd;

uses graph;

var
    gd, gm: integer;

procedure gcd_rec(x, y, dx, dy: integer);
begin
    if (dx > 0) and (dy > 0) then
        if dx > dy then
        begin
            rectangle(x, y, x + dy, y + dy);
            readln;
            gcd_rec(x + dy, y, dx - dy, dy)
        end
        else
        begin
            rectangle(x, y, x + dx, y + dx);
            readln;
            gcd_rec(x, y + dx, dx, dy - dx);
        end
end;

procedure draw_gcd(u, v: integer);
var x0, y0: integer;
begin
    x0 := (getmaxx - u) div 2;
    y0 := (getmaxy - v) div 2;
    setcolor(7);
    rectangle(x0, y0, u+x0+1, v+y0+1);
    readln;
    setcolor(15);
    gcd_rec(x0, y0, u, v);
end;

begin
    initgraph(gd, gm, 'C:\TP\BGI');
    draw_gcd(324, 138);
    closegraph
end.
