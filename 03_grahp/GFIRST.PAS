program gfirst;

uses graph;

var device, mode: integer;

begin
    device := 0;
    initgraph(device, mode, 'C:\TP\BGI');
    circle(100, 80, 50);
    readln;
    closegraph
end.
