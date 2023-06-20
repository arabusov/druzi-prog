program conditional_statement;
var
    x, y: integer;
begin
    x := 3;
    y := 4;
    if (x = -3) then
        write('x');
    if (y = 5) then
        write('y');
    if (x <> -3) and (y <> 5) then
        write('no');
    writeln(' match')
end.

