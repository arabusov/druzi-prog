program find_min;

var
    nums: array [1..24] of integer;
    i: integer;

procedure fill_random;
begin
    for i := 1 to 24 do
        nums[i] := random(100);
end;

procedure print_array;
begin
    for i := 1 to 24 do
        writeln('nums [', i, '] = ', nums[i])
end;

function minimum: integer;
var
    i, tmp: integer;
begin
    tmp := 100;
    for i := 1 to 24 do
        if tmp > nums[i] then
            tmp := nums[i];
    minimum := tmp;
end;

begin
    fill_random;
    print_array;
    writeln('max(nums) = ', minimum)
end.
