{ Программа для отображения графиков из .dat файлов }
program plot_data;

uses oglgraph;

const
    max_plots = 5;
    max_points = 1024;

{ Создадим глобальные массивы  }
var
    xx: array [1..max_points] of real;
    data: array [1..max_plots, 1..max_points] of real;
    n_points: integer;
    n_plots: integer;

function absmaxx: real;
var
    max: real;
    i: integer;
begin
    max := 0;
    for i := 1 to n_points do
        if max < abs(xx[i]) then
            max := abs(xx[i]);
    absmaxx := max
end;

function absmaxy: real;
var
    max: real;
    i, j: integer;
begin
    max := 0;
    for i := 1 to n_plots do
        for j := 1 to n_points do
            if max < abs(data[i,j]) then
                max := abs(data[i,j]);
    absmaxy := max
end;
   
var gd, gm: smallint;

function scr_x(x: real): word;
begin
    scr_x := round((getmaxx - getmaxy) div 2 + x);
end;

function scr_y(y: real): word;
begin
    scr_y := round(getmaxy*0.9 - y);
end;

procedure grid(plot_scale_x, plot_scale_y: real);
var
    x, y, sx, sy1: word;
    grid_step: word;
begin
    setcolor(8);
    grid_step := round(getmaxx / plot_scale_x / 10.0);
    for x := 1 to 9 do
    begin
        sx := scr_x(x*grid_step);
        line(sx, 0, sx, getmaxy);
    end;
    for y := 1 to 9 do
    begin
        sy1 := scr_y(y*getmaxy/10.0);
        line (0, sy1, getmaxx, sy1);
    end;
    setcolor(15);
    sx := scr_x(0);
    line(sx, 0, sx, getmaxy);
    sy1 := scr_y(0);
    line(0, sy1, getmaxx, sy1);
end;

procedure plot;
var
    i, j: integer;
    plot_scale_x, plot_scale_y: real;
    x, y: real;
    sx, prev_sx: word;
    sy, prev_sy: array [1..max_plots] of word;
begin
    initgraph(gd, gm, 'C:\TP\BGI');
    prev_sx := scr_x(0);
    for j := 1 to n_plots do
        prev_sy[j] := scr_y(0);
    plot_scale_x := absmaxx / getmaxy;
    plot_scale_y := absmaxy / getmaxy;
    grid(plot_scale_x, plot_scale_y);
    for i := 1 to n_points do
    begin
        for j := 1 to n_plots do
        begin
            x := xx[i]/plot_scale_x;
            y := data[j, i]/plot_scale_y;
            sx := scr_x(x);
            sy[j] := scr_y(y);
            setcolor(j + 1);
            line(prev_sx, prev_sy[j], sx, sy[j]);
            prev_sx := sx;
            prev_sy[j] := sy[j];
        end
    end;
    readln;
    closegraph
end;

var
    fname: string;
    f: text;
    i: integer;
begin
    write('File name?> ');
    readln(fname);
    assign(f, fname);
    reset(f);
    read(f, n_plots);
    writeln('N plots: ', n_plots);
    if (n_plots < 1) and (n_plots > max_plots) then
    begin
        writeln('Number of plots not supported: ', n_plots);
        writeln('Stop program');
        exit;
    end;
    n_points := 0;
    if eof(f) then
        exit;
    repeat
        n_points := n_points + 1;
        if n_points > max_points then
        begin
            writeln('Number of points exeeds the maximum ', max_points);
        end;
        read(f, xx[n_points]);
        if eof(f) then
        begin
            n_points := n_points - 1;
            break;
        end;
        for i := 1 to n_plots do
        begin
            read(f, data[i, n_points]);
        end;
    until eof(f);
    writeln('# points: ', n_points);
    plot
end.
