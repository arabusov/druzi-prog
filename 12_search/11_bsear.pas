program binary_search_example;

uses oglgraph;

{ Наибольшее число элементов в массиве }
const
    nmax = 10180;
    step = 128;

var 
    { Массив из целых чисел }
    a: array [1..nmax] of integer;
    { Переменная, которая будет следить за размером массива }
    N, max_random: integer;

{ Подпрограмма, которая устанавливает начальные значения массива
    в случайном порядке и фиксирует размер массива }
procedure init_array(n_elements: integer; max_val: integer);
var
    i: integer;
begin
    N := n_elements;
    a[1] := random(max_val div 2) + 1;
    for i := 2 to N do
        if a[i - 1] < max_val then
        begin
            a[i] := (random((max_val - a[i - 1]) div 2)
                    + 1 + a[i - 1]);
            if a[i] >= max_val then
                a[i] := max_val
        end
        else
            a[i] := a[i - 1];
    max_random := max_val
end;

var
    n_comp: integer;

{ Подпрограмма двоичного поиска в массиве "a" }
function binary_search(x: integer): integer;
var
    i, j, k: integer;
begin
    n_comp := 0; { Каждый раз зануляем число сравнений }
    i := 1; { i указывает на начало диапазона }
    j := N; { j указывает на конец диапазона }
    repeat
        k := (i + j) div 2; { k указывает на элемент сравнения }
        n_comp := n_comp + 1;
        if x > a[k] then
            i := k + 1
        else
            j := k - 1;
        n_comp := n_comp + 1; { Условие в цикле --- тоже сравнение }
    until (a[k] = x) or (i > j); { условие выхода }
    n_comp := n_comp + 1; { Последнее сравнение }
    if a[k] = x then
        binary_search := k
    else
        binary_search := -1
end;


function test_search(size: integer): real;
var
    i, k: integer;
    av_comps: real;
begin
    { Пусть каждый раз случайная последовательность будет новой }
    randomize;
    { Создадим массив из 8 элементов, каждый из которых не больше 99 }
    init_array(size, nmax);
    av_comps := 0.;
    { Запустим алгоритм для каждого элемента массива }
    for i := 1 to N do
    begin
        k := binary_search(random(max_random));
        { Сохраняем статистику }
        av_comps := av_comps + n_comp;
    end;
    test_search := av_comps / N;
end;

{ Создадим глобальные массивы для того чтобы хранить статистику. }
var
    sizes, comps: array [1..(nmax div step)] of real;
    n_reports, size: integer;

function max_comps: real;
var
    tmp: real;
    i: integer;
begin
    tmp := 0;
    for i := 1 to n_reports do
        if tmp < comps[i] then
            tmp := comps[i];
    max_comps := tmp
end;

procedure print_reports;
var
    i: integer;
begin
    writeln('size':16, 'comp':16, 'move':16);
    for i := 1 to n_reports do
        writeln(sizes[i]:16:0, comps[i]:16:0);
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
    grid_step := getmaxx div (nmax div step);
    for x := 1 to (getmaxy div grid_step) do
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
    i: integer;
    plot_scale_x, plot_scale_y: real;
    x, y: real;
    sx, sy1: word;
    prev_sx, prev_sy1: word;
begin
    initgraph(gd, gm, 'C:\TP\BGI');
    prev_sx := scr_x(0);
    prev_sy1 := scr_y(0);
    plot_scale_y := max_comps;
    plot_scale_x := sizes[n_reports];
    plot_scale_x := plot_scale_x / (getmaxx * 0.7);
    plot_scale_y := plot_scale_y / (getmaxy * 0.8);
    grid(plot_scale_x, plot_scale_y);
    for i := 1 to n_reports do
    begin
        x := sizes[i]/plot_scale_x;
        y := comps[i]/plot_scale_y;
        sx := scr_x(x);
        sy1 := scr_y(y);
        setcolor(5);
        line(prev_sx, prev_sy1, sx, sy1);
        prev_sx := sx;
        prev_sy1 := sy1;
    end;
    readln;
    closegraph
end;

var
    i: integer;

begin
    { Пусть каждый раз случайная последовательность будет новой }
    randomize;
    n_reports := 0;
    write('Test: ');
    for i := 0 to (nmax div step) - 1 do
    begin
        size := i * step + 2;
        n_reports := n_reports + 1;
        sizes[n_reports] := size;
        comps[n_reports] := test_search(size);
        write(i, ', ')
    end;
    writeln;
    plot;
    print_reports;
    writeln('Press enter.');
    readln
end.
