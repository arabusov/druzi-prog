program array_example;
var
    nums: array [1..3] of integer;
    i, m: integer;
begin
    m := -32768;
    for i := 3 downto 1 do
        nums[i] := - 3*i;
    for i := 1 to 3 do
        if m < nums[i] then
            m := nums[i];
    writeln(m)
end.
