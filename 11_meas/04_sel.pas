program sel_sort_study;

uses oglgraph;

{ Наибольшее число элементов в массиве }
const nmax = 64;

var 
    { Массив из целых чисел }
    a: array [1..nmax] of integer;
    { Переменная, которая будет следить за размером массива }
    N: integer;

{ Подпрограмма, которая устанавливает начальные значения массива
    в случайном порядке и фиксирует размер массива }
procedure init_array(n_elements: integer; max_val: integer);
var
    i: integer;
begin
    N := n_elements;
    for i := 1 to N do
        { Заполним массив случайными числами от 1 до N в цикле }
        a[i] := random(max_val) + 1
end;

{ Простая подпрограмма печати массива на экран, целая строчка тратится
    на одиин элемент }
procedure print_array;
var
    i: integer;
begin
    write('a[] = { ');
    for i := 1 to N do
        write(a[i]:6);
    writeln(' }')
end;

{ Определим глобальные переменные для того чтобы считать статистику }
var
    n_comp, n_move: real;
    verbose_level: integer;

procedure straight_selection;
var
    i, j, k: integer;
    x: integer;
begin
    n_move := 0;
    n_comp := 0;
    for i := 1 to N - 1 do
    begin
        { Берём начальный элемент под-массива, с которым мы будем
            сравнивать минимум }
        x := a[i];
        k := i; { k будет хранить индекс массива }
        { Начинаем сравнение с начальным элементом }
        for j := i + 1 to N do
        begin
            n_comp := n_comp + 1;
            if a[j] < x then
            begin
                k := j;
                x := a[j]
            end
        end;
        { k найден, теперь обмен }
        a[k] := a[i];
        a[i] := x;
        n_move := n_move + 2
    end
end;

procedure sort_array;
begin
    straight_selection
end;

procedure print_stat;
begin
    if verbose_level > 0 then
    begin
        writeln('n_comp = ', n_comp:16:0);
        writeln('n_move = ', n_move:16:0)
    end
end;

procedure test_sort(size: integer);
begin
    init_array(size, nmax);
    if verbose_level > 0 then
    begin
        writeln('n_elements = ', size:16);
        print_array
    end;
    sort_array;
    if verbose_level > 0 then
        print_array;
    print_stat
end;

const
    step = 2;

{ Создадим глобальные массивы для того чтобы хранить статистику. }
var
    sizes, comps, moves: array [1..(nmax div step)] of real;
    n_reports, size: integer;
procedure print_reports;
var
    i: integer;
begin
    writeln('size':16, 'comp':16, 'move':16);
    for i := 1 to n_reports do
        writeln(sizes[i]:16:0, comps[i]:16:0, moves[i]:16:0);
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
    dY: integer;
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
    sx, sy1, sy2: word;
    prev_sx, prev_sy1, prev_sy2: word;
begin
    initgraph(gd, gm, 'C:\TP\BGI');
    prev_sx := scr_x(0);
    prev_sy1 := scr_y(0);
    prev_sy2 := scr_y(0);
    plot_scale_y := comps[n_reports];
    plot_scale_x := sizes[n_reports];
    if moves[n_reports] > plot_scale_y then
        plot_scale_y := moves[n_reports];
    plot_scale_x := plot_scale_x / (getmaxx * 0.7);
    plot_scale_y := plot_scale_y / (getmaxy * 0.9);
    grid(plot_scale_x, plot_scale_y);
    for i := 1 to n_reports do
    begin
        x := sizes[i]/plot_scale_x;
        y := comps[i]/plot_scale_y;
        sx := scr_x(x);
        sy1 := scr_y(y);
        setcolor(5);
        line(prev_sx, prev_sy1, sx, sy1);
        y := moves[i]/plot_scale_y;
        sy2 := scr_y(y);
        setcolor(10);
        line(prev_sx, prev_sy2, sx, sy2);
        prev_sx := sx;
        prev_sy1 := sy1;
        prev_sy2 := sy2;
    end;
    readln;
    closegraph
end;

var
    i: integer;

begin
    { Пусть каждый раз случайная последовательность будет новой }
    randomize;
    write('Verbose level?> ');
    readln(verbose_level);
    n_reports := 0;
    for i := 0 to (nmax div step) - 1 do
    begin
        size := i * step + 2;
        n_reports := n_reports + 1;
        sizes[n_reports] := size;
        test_sort(size);
        comps[n_reports] := n_comp;
        moves[n_reports] := n_move;
    end;
    plot;
    print_reports;
    writeln('Press enter.');
    readln
end.
