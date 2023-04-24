program ganim;

uses graph, crt;

var device, mode: integer;
    x, y: byte;

begin
    device := 0;
    initgraph(device, mode, 'C:\TP\BGI');
    x := 1;
    y := 1;
    repeat

        x := x + 1;
        y := y + 1;
        if x > 480 then
            x := 1;
        if y > 640 then
            y := 1;
        setcolor(9);
        circle(x, y, 100);
        delay(20);
        setcolor(0);
        circle(x, y, 100);
    until keypressed;
    readln;
    closegraph
end.
