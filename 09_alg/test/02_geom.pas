program in_circle;

var
    x, y, r: integer;
    answer: boolean;
begin
    x := 3;
    y := 4;
    r := 5;
    answer := (r*r >= x*x + y*y);
    writeln(answer)
end.

