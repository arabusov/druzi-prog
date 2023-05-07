unit vga256;

interface

procedure InitGraph;
procedure Bar(x1, y1, x2, y2: integer);
procedure rect(x1, y1, x2, y2: integer);
procedure PutPixel(x, y : integer; color : byte);
procedure ClS(color : byte);
procedure CloseGraph;
procedure SetColor(clr: byte);
procedure Line(x0, y0, x1, y1: integer);
function GetColor: byte;
procedure circle(x0, y0, r: integer);

const
    GetNX = 320;
    GetNY = 200;
    GetMaxX = GetNX - 1;
    GetMaxY = GetNY - 1;
    GetMaxColor = 255;

implementation

const base = $a000;

var color: byte;

procedure InitGraph;
begin
    color := 15;
    asm
    mov ax,0013h    { 13h is graphics mode, hence the name 13h :) }
    int 10h
    end
end;

procedure PutPixel(x, y : integer; color : byte);
begin
  mem[base:x+y*GetNX] := color;
end; 

procedure Bar (x1, y1, x2, y2: integer);
var i, j: integer;
begin
    for i := x1 to x2 do
        for j := y1 to y2 do
            mem[base:i+j*GetNX] := color;
end;

procedure CloseGraph; assembler;
asm
    mov ax,0003h       { mode 03h is text (25 line mode) }
    int 10h
end;

procedure ClS(color : byte);
begin
    FillChar(mem[base:0000], GetNX*GetNY, color);
end;

procedure rect(x1, y1, x2, y2: integer);
var i: integer;
begin
    for i := x1 to x2 do
        mem[base:i + (y1*GetNX)] := color;
    for i := x1 to x2 do
        mem[base:i + (y2*GetNX)] := color;
    for i := y1 to y2 do
        mem[base:x1 + (i*GetNX)] := color;
    for i := y1 to y2 do
        mem[base:x2 + (i*GetNX)] := color;
end;

procedure SetColor(clr: byte);
begin
    color := clr;
end;

function GetColor: byte;
begin
    GetColor := color;
end;

procedure line(x0, y0, x1, y1: integer);
var dx, sx, dy, sy, error, e2: integer;
begin
    dx := abs(x1 - x0);
    sx := 1;
    if x0 >= x1 then
        sx := -1;
    dy := -abs(y1 - y0);
    sy := 1;
    if y0 >= y1 then
        sy := -1;
    error := dx + dy;
    
    while true do
    begin
        mem[base:x0 + y0*GetNX] := color;
        if (x0 = x1) and (y0 = y1) then
            break;
        e2 := 2 * error;
        if e2 >= dy then
        begin
            if x0 = x1 then
                break;
            error := error + dy;
            x0 := x0 + sx;
        end;
        if e2 <= dx then
        begin
            if y0 = y1 then
                break;
            error := error + dx;
            y0 := y0 + sy;
        end
    end
end;

procedure circle(x0, y0, r: integer);
var t1, t2: integer;
    x, y: integer;
begin
    t1 := r div 16;
    x := r;
    y := 0;
    repeat
        mem[base:(x0+x)+(y0+y)*GetNX] := color;
        mem[base:(x0-x)+(y0+y)*GetNX] := color;
        mem[base:(x0+x)+(y0-y)*GetNX] := color;
        mem[base:(x0-x)+(y0-y)*GetNX] := color;
        mem[base:(x0+y)+(y0+x)*GetNX] := color;
        mem[base:(x0-y)+(y0+x)*GetNX] := color;
        mem[base:(x0+y)+(y0-x)*GetNX] := color;
        mem[base:(x0-y)+(y0-x)*GetNX] := color;
        y := y + 1;
        t1 := t1 + y;
        t2 := t1 - x;
        if t2 >= 0 then
        begin
            t1 := t2;
            x := x - 1
        end;
    until x < y
end;

end.
