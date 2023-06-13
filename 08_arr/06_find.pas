program find_linear;

var
    nums: array [1..24] of integer;
    ncomp: integer;

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

function find(a: integer): integer;
var
    i: integer;
begin
    find := -1;
    ncomp := 0;
    for i := 1 to 24 do
    begin
        ncomp := ncomp + 1;
        if a = nums[i] then
        begin
            find := i;
            break
        end
    end 
end;

var
    a, found: integer;
begin
    fill_random;
    print_array;
    write('What number to find? (0..100): ');
    readln(a);
    if (a < 0) and (a > 100) then
    begin
        writeln('The number is out of range');
        exit;
    end;
    found := find(a);
    if found = -1 then
        writeln('Number ', a, ' is not found in the nums array')
    else
        writeln('Number ', a, ' is found at the ', found, 'th position');
    writeln('Number of comparisons = ', ncomp)
end.
