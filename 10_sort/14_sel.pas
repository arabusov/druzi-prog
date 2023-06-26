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
    delay(100);
    draw_couple(i, j, black);
    x := a[i];
    a[i] := a[j];
    a[j] := x;
    draw_couple(i, j, white)
end;

procedure straight_selection;
var
    i, j, k: integer;
    x: integer;
begin
    for i := 1 to N - 1 do
    begin
        { Берём начальный элемент под-массива, с которым мы будем
            сравнивать минимум }
        x := a[i];
        k := i; { k будет хранить индекс массива }
        { Начинаем сравнение с начальным элементом }
        for j := i + 1 to N do
        begin
            draw_couple(k, j, green);
            delay(400);
            draw_couple(k, j, white);
            draw_couple(i, i, yellow);
            if a[j] < x then
            begin
                k := j;
                x := a[j]
            end
        end;
        draw_couple(k, i, red);
        delay(800);
        draw_couple(k, i, black);
        { k найден, теперь обмен }
        a[k] := a[i];
        a[i] := x;
        draw_couple(k, i, white)
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
    straight_selection;
    readln;
    closegraph
end.
