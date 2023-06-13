program sort;

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

var
    nperm: integer;

procedure perm(i, j: integer);
var
    tmp: integer;
begin
    tmp := nums[i];
    nums[i] := nums[j];
    nums[j] := tmp;
    nperm := nperm + 1;
end;

procedure buble;
var
    i, j: integer;
begin
    nperm := 0;
    for i := 1 to 24 do
        for j := i + 1 to 24 do
            if nums[j] < nums[i] then
                perm(i, j);
end;

begin
    fill_random;
    print_array;
    write('Press ENTER to sort array');
    readln;
    buble;
    print_array;
    writeln('# permutations = ', nperm)
end.
