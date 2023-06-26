program simple_selection_sort;

{ Наибольшее число элементов в массиве }
const nmax = 16384;

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
    for i := 1 to N do
        writeln('a[', i, '] = ', a[i]);
end;

{ Подпрограмма печати массива на экран в расчёте на то что в массиве
    каждый элемент меньше сотни, тогда в строку поместится 24 элемента }
procedure write_array;
var
    i: integer;
begin
    for i := 1 to N do
        write(a[i]:3);
    { После вывода всех символов надо обозначить конец строки,
        иначе последующий вывод на экран испортится }
    writeln
end;

{ Подпрограмма, которая рисует горизонтальную линию, длина зависит
    от заданного параметра len; линия займёт 3*len символов }
procedure hline(len: integer);
var
    i: integer;
begin
    for i := 1 to len do
        write('---');
    { После вывода всех символов надо обозначить конец строки,
        иначе последующий вывод на экран испортится }
    writeln
end;

{ Подпрограмма, которая печатает заголовок таблицы на экран }
procedure write_header;
var
    i: integer;
begin
    write(' i ');
    for i := 1 to N do
        write(i:3);
    writeln;
    hline(N + 1)
end;

{ Подпрограмма печати начального массива }
procedure present_array;
begin
    write_header;
    write(' 1:');
    write_array
end;

{ Подпрограмма сортировки массива "a" простым выбором. 
  Сначала мы ищем минимальное значение в всём массиве и меняемся с
  первым элементом. Дальше мы ищем начиная со второго элемента в
  массиве, потом третьего, и так до тех пор пока весь массив не
  исчерпается. }
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
            if a[j] < x then
            begin
                k := j;
                x := a[j]
            end
        end;
        { k найден, теперь обмен }
        a[k] := a[i];
        a[i] := x;
        write((i + 1):2, ':');
        write_array
    end
end;

begin
    { Пусть каждый раз случайная последовательность будет новой }
    randomize;
    { Создадим массив из 8 элементов, каждый из которых не больше 99 }
    init_array(8, 99);
    { Выведем на экран оригинальный массив вместе с <<шапкой>> }
    present_array;
    { Запустим алгоритм }
    straight_selection;
    { Подведём черту под табличкой }
    hline(N + 1);
    readln
end.
