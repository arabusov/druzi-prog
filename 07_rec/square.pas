program square;

uses graph;

procedure square2(x, y, a: integer);
begin
    line(x-a, y-a, x+a, y-a);
    line(x-a, y-a, x-a, y+a);
    line(x+a, y+a, x+a, y-a);
    line(x+a, y+a, x-a, y+a);
end;

var
    gd, gm: integer;
begin
    initgraph(gd, gm, 'C:\TP\BGI');
    square2(getmaxy div 2,getmaxy div 2,100);
    readln;
    closegraph
end.
