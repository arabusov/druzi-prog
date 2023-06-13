program fill_random;

var
    nums: array [1..24] of integer;
    i: integer;

begin
    for i := 1 to 24 do
        nums[i] := random(100);
    for i := 1 to 24 do
        writeln('nums [', i, '] = ', nums[i])
end.
