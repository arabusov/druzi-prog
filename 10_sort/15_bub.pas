program buble_sort_example;

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

procedure draw_element(i: integer);
var
    x0, y0, x: word;
begin
    x0 := getmaxx div 2;
    y0 := getmaxy;
    x := x0 + (step * (4*i- 2*N - 5)) div 4;
    rectangle(x, y0, x + step, y0 - a[i])
end;

procedure present_array;
var
    i: integer;
begin
    setcolor(white);
    for i := 1 to N do
        draw_element(i)
end;

procedure draw_couple(i, j: integer; c: integer);
begin
    setcolor(c);
    draw_element(i);
    draw_element(j);
end;

{ Подпрограмма перестановки двух элементов массива "a"}
procedure swapa(i, j: integer);
var
    x: integer;
begin
    draw_couple(i, j, red);
    delay(400);
    draw_couple(i, j, black);
    x := a[i];
    a[i] := a[j];
    a[j] := x;
    draw_couple(i, j, red);
    delay(400);
    draw_couple(i, j, white)
end;

{ Подпрограмма сортировки массива "a" <<пузырьком>> }
procedure buble;
var
    i, j: integer;
begin
    for i := 2 to N do
    begin
        draw_couple(i - 1, i - 1, yellow);
        for j := N downto i do
        begin
            draw_couple(j - 1, j, green);
            delay(400);
            draw_couple(j - 1, j, white);
            if a[j - 1] > a[j] then
                swapa(j - 1, j)
            else
                draw_couple(i, j, white)
        end;
        draw_couple(i - 1, i - 1, white)
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
    buble;
    readln;
    closegraph
end.
