program arkanoid;

uses graph, crt;

const
    r = 6;

var device, mode: integer;
    maxx, maxy: integer;
    x, y: integer;
    c: byte;
    dx, dy: integer;

procedure draw_ball;
begin
    setcolor(c);
    circle(x, y, r)
end;

procedure clear_ball;
begin
    setcolor(0);
    circle(x, y, r)
end;

procedure check_wall;
begin
    if (x > maxx) or (x <= 1) then
        dx := -dx;
    if (y > maxy) or (y <= 1) then
        dy := -dy
end;

procedure init_ball;
begin
    x := maxx div 2;
    y := maxy - 2 * r;
    dy := -1;
    dx := 1;
    c := 5
end;

procedure fly_ball;
begin
    x := x + dx;
    y := y + dy
end;

begin
    device := 0;
    initgraph(device, mode, 'C:\TP\BGI');
    maxx := getmaxx;
    maxy := getmaxy;
    init_ball;
    repeat
        fly_ball;
        check_wall;
        draw_ball; 
        delay(10);
        clear_ball
    until keypressed;
    closegraph
end.
