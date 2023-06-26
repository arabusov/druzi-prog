program fill_array;

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

procedure print_array;
var
    i: integer;
begin
    for i := 1 to N do
        writeln('a[', i, '] = ', a[i]);
end;

procedure write_array;
var
    i: integer;
begin
    for i := 1 to N do
        write(a[i]:3);
    writeln
end;

procedure hline(len: integer);
var
    i: integer;
begin
    for i := 1 to len do
        write('---');
    writeln
end;

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

procedure present_array;
begin
    write_header;
    write(' 1:');
    write_array
end;

procedure straight_insertion;
var
    i, j: integer;
    x: integer;
begin
    for i := 2 to N do
    begin
        x := a[i];
        a[0] := x;
        j := i - 1;
        while x < a[j] do
        begin
            a[j + 1] := a[j];
            j := j - 1;
        end;
        a[j + 1] := x;
        write(i:2, ':');
        write_array
    end
end;

begin
    randomize;
    init_array(8, 99);
    present_array;
    straight_insertion;
    hline(N + 1)
end.
