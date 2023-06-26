program binary_search_example;

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

{ Подпрограмма двоичного поиска в массиве "a" }
function binary_search(x: integer): integer;
var
    i, j, k: integer;
begin
    i := 1; { i указывает на начало диапазона }
    j := N; { j указывает на конец диапазона }
    repeat
        k := (i + j) div 2; { k есть длина диапазона }
        if x > a[k] then
            i := k + 1
        else
            j := k - 1;
    until (a[k] = x) or (i > j); { условие выхода }
    if a[k] = x then
        binary_search := k
    else
        binary_search := -1
end;

var
    i, k: integer;
    fail_flag: boolean;
begin
    { Пусть каждый раз случайная последовательность будет новой }
    randomize;
    { Создадим массив из 8 элементов, каждый из которых не больше 99 }
    init_array(8, 99);
    { Выведем на экран оригинальный массив вместе с <<шапкой>> }
    present_array;
    { Подведём черту под табличкой }
    hline(N + 1);
    { Запустим алгоритм для каждого элемента массива }
    fail_flag := false;
    for i := 1 to N do
    begin
        k := binary_search(a[i]);
        { Проверим если алгоритм нашёл ключ }
        if k = -1 then
        begin
            fail_flag := true;
            writeln('a[', i, ']=', a[i], 'was not found')
        end
        { И если нашёл, то не наврал }
        else if a[i] <> a[k] then
        begin
            fail_flag := true;
            writeln('a[', i, ']=', a[i], ', a[', k, ']=', a[k])
        end
    end;
    { Поздравим с успехом если он есть }
    if not fail_flag then
        writeln('Positive cases are passed');
    readln
end.
