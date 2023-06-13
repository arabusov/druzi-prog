program permutation;

var
    nums: array [1..24] of integer;

procedure fill_random;
var
    i: integer;
begin
    for i := 1 to 24 do
        nums[i] := random(100);
end;

procedure print_array;
var
    i: integer;
begin
    for i := 1 to 24 do
        writeln('nums [', i, '] = ', nums[i])
end;

procedure perm(i, j: integer);
var
    tmp: integer;
begin
    tmp := nums[i];
    nums[i] := nums[j];
    nums[j] := tmp;
end;

var
    i: integer;
begin
    fill_random;
    print_array;
    writeln('Permute 23rd and 24th elements:');
    perm(23, 24);
    for i := 23 to 24 do
        writeln('nums [', i, '] = ', nums[i])
end.
