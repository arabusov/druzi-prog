program arr;
{ This program shows what is an array and how to use it. }
var
    i: integer;
{ An array is a sequence of variables of the same type. }
{ An array of integers can be defined like that: }
var
    numbers: array [1..10] of integer;
{ Here, we defined a sequence of 10 integer variables. }
{ Now the question is how to use these 10 variables. }
begin
    { We can access every variable with it's index in the sequence, }
    { For example, we want to assign the first variable the value 10: }
    numbers [1] := 10;
    writeln('numbers [1] = ', numbers [1]);
    { We can do operations with this variable as it is a usual integer
    variable: }
    numbers [2] := numbers [1] + 2;
    writeln('numbers [2] = ', numbers [2]);
    { But what is a benifit of using an array over the standard variables? }
    { We can use a for loop to acces every element of the array: }
    for i := 1 to 10 do
        numbers [i] := 2 * i;
    { And print the result in descending order: }
    for i := 10 downto 1 do
        writeln('[', i, '] = ', numbers[i]);
end.
