program tree;

uses graph;

var
    gd, gm: integer;

procedure btree(x, y, xstep, level: integer);
var
    newy, new_step: integer;
begin
    newy := y + 64;
    if (newy < getmaxy) and (xstep > 0) then
    begin
        new_step := xstep div 2;
        setcolor(level + 1);
        line(x, y, x - xstep, newy);
        line(x, y, x + xstep, newy);
        btree(x - xstep, newy, new_step, level + 1);
        btree(x + xstep, newy, new_step, level + 1)
    end
end;

procedure btree_full;
begin
    btree(getmaxx div 2, 1, getmaxx div 4, 0);
end;

begin
    initgraph(gd, gm, 'C:\TP\BGI');
    btree_full;
    readln;
    closegraph
end.
