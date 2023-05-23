program simplestar; uses graph; var gd, gm: integer;
procedure sstar(x, y, r, c: integer);
var
    r2: integer;
begin
    r2 := r div 2;
    c := c + 1;
    if r2 > 0 then
    begin
        setcolor(c);
        rectangle(x - r2, y - r2, x + r2, y + r2);
        sstar(x - r, y - r, r2, c);
        sstar(x + r, y - r, r2, c);
        sstar(x - r, y + r, r2, c);
        sstar(x + r, y + r, r2, c);
    end
end;

begin
    initgraph(gd, gm, 'C:\TP\BGI');
    setcolor(white);
    sstar(getmaxy div 2, getmaxy div 2, getmaxy div 4, 1);
    readln;
    closegraph
end.
