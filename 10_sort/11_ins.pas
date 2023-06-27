program simple_selection_sort;

uses oglgraph, crt;

{ Наибольшее число элементов в массиве }
const nmax = 16384;
const step = 40;

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

procedure draw_element(i: integer; c: integer);
var
    x0, y0, x: word;
begin
    setcolor(c);
    x0 := getmaxx div 2;
    y0 := getmaxy;
    x := x0 + (step * (4*i- 2*N - 3)) div 4;
    rectangle(x, y0, x + step, y0 - a[i])
end;

procedure present_array;
var
    i, c: integer;
begin
    c := getcolor;
    for i := 1 to N do
        draw_element(i, c)
end;

procedure draw_couple(i, j: integer; c: integer);
begin
    draw_element(i, c);
    draw_element(j, c);
end;

procedure straight_insertion;
var
    i, j: integer;
    x: integer;
begin
    for i := 2 to N do
    begin
        x := a[i];
        j := i - 1;
        if j > 0 then
            draw_element(j, yellow);
        draw_element(i, green);
        setcolor(magenta);
        line(0, getmaxy - x, getmaxx, getmaxy - x);
        delay(2000);
        repeat
            draw_element(j, black);
            draw_element(j + 1, black);
            draw_element(j + 2, white);
            a[j + 1] := a[j];
            draw_element(j + 1, white);
            j := j - 1;
            if j > 0 then
            begin
                draw_element(j, yellow);
                delay(400);
            end
        until not ((x < a[j]) and (j >= 1));
        setcolor(black);
        line(0, getmaxy - x, getmaxx, getmaxy - x);
        draw_element(i, black);
        a[j + 1] := x;
        if j > 0 then
        begin
            draw_element(j, white);
            draw_element(j + 1, white)
        end;
        draw_element(1, white)
    end
end;

var
    gd, gm: smallint;

begin
    initgraph(gd, gm, 'C:\TP\BGI');
    { Пусть каждый раз случайная последовательность будет новой }
    randomize;
    { Создадим массив из 8 элементов, каждый из которых не больше 99 }
    init_array(getmaxx div step, getmaxy - 1);
    { Выведем на экран оригинальный массив вместе с <<шапкой>> }
    present_array;
    readln;
    { Запустим алгоритм }
    straight_insertion;
    readln;
    closegraph
end.
