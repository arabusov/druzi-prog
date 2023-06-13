program boundaries;

var
    i: integer;
    x: integer;
    nums: array [1..10] of integer;
begin
{   nums[-34] := -32; }
    i := 0;
    x := 16;
    writeln('x = ', x);
    { now we do not touch variable j }
    nums[i] := -32;
    writeln('x = ', x);
    readln
end.
