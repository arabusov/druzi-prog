program vga256_test;

uses vga256;

var
    i, j: integer;

procedure pentagram;
var i: integer;
    stp, l: real;
begin
    stp := 72./180.*pi;
    l := getmaxy /4.;
    for i := 1 to 5 do
    begin
        setcolor(i);
        writeln(round((2+cos(stp*i))*l), ' ',round((2+sin(stp*i))*l), ' ',
        round((2+cos(stp*(i+1)))*l), ' ', round((2+sin(stp*(i+1)))*l));
        line(round((2+cos(stp*i))*l), round((2+sin(stp*i))*l),
        round((2+cos(stp*(i+1)))*l), round((2+sin(stp*(i+1)))*l));
        readln;
    end
end;

begin
    initgraph;
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
