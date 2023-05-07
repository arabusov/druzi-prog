program vga256_test;

uses vga256, crt;

var
    i, j: integer;

procedure pentagram;
var i, j: integer;
    stp, l, ph: real;
begin
    stp := 72./180.*pi;
    l := getmaxy/3.;
    ph := 0.;
    j := 0;
    repeat
        for i := 1 to 5 do
        begin
            setcolor(i+j*5);
            line(round((2+cos(stp*i+ph))*l), round((2+sin(stp*i+ph))*l),
            round((2+cos(ph+stp*(i+2)))*l), round((2+sin(ph+stp*(i+2)))*l));
        end;
        delay(50);
        setcolor(0);
        for i := 1 to 5 do
        begin
            line(round((2+cos(stp*i+ph))*l), round((2+sin(stp*i+ph))*l),
            round((2+cos(ph+stp*(i+2)))*l), round((2+sin(ph+stp*(i+2)))*l));
        end;
        ph := ph + 0.2;
        j := (j + 1) mod 48;
    until keypressed
end;

var dx, cnt:  integer;

begin
    initgraph;
    cls(0);
    cnt := 1;
    i := (GetMaxY div 4) + 1;
    dx := 6;
    repeat
        setcolor(cnt);
        circle(i , GetMaxY div 2, GetMaxY div 4);
        circle(i , GetMaxY div 2, GetMaxY div 4 - 1);
        circle(i , GetMaxY div 2, GetMaxY div 4 - 2);
        delay(40);
        setcolor(cnt div 256);
        circle(i, GetMaxY div 2, GetMaxY div 4);
        circle(i, GetMaxY div 2, GetMaxY div 4 - 1);
        circle(i, GetMaxY div 2, GetMaxY div 4 - 2);
        if (i >= (GetMaxX - (GetMaxY div 4))) or
            (i <= (GetMaxY div 4)) then
            dx := -dx;
        i := i + dx;
        cnt := cnt + 1;
        if cnt > 248 then
        begin
            cnt := 1;
        end
    until keypressed;
    cls(0);
    for i := 0 to 239 do
            putpixel(i, i, i);
    readln;
    for i := 0 to 255 do
    begin
        setcolor(i);
        bar(i, 10, i, 110);
    end;
    readln;
    cls(15);
    for i := 0 to 255 do
    begin
        setcolor(i);
        rect(i div 5, i div 5, i div 3, i mod getmaxx);
    end;
    readln;
   
    cls(0);
    setcolor(45);
    line(0, 0, 10, 10);
    line(10, 0, 0, 10);
    line(30, 30, 20, 20);
    line(20, 30, 30, 20);
    readln;
    cls(0);
    pentagram;
    readln;
    closegraph;
end.
