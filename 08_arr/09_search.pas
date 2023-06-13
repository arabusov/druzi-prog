program binary_search;

const
    asize = 24;

var
    nums: array [1..asize] of integer;
    inds: array [1..asize] of integer;
    nums_orig: array [1..asize] of integer;

procedure fill_random;
var
    i: integer;
begin
    for i := 1 to asize do
    begin
        nums[i] := random(100);
        inds[i] := i;
    end
end;

procedure print_array;
var
    i: integer;
begin
    for i := 1 to asize do
        writeln('nums [', i, '] = ', nums[i])
end;

procedure backup;
var
    i: integer;
begin
    for i := 1 to asize do
        nums_orig [i] := nums[i];
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

    tmp := inds[i];
    inds[i] := inds[j];
    inds[j] := tmp;

    nperm := nperm + 1;
end;

procedure buble;
var
    i, j: integer;
begin
    nperm := 0;
    for i := 1 to asize do
        for j := i + 1 to asize do
            if nums[j] < nums[i] then
                perm(i, j);
end;

var
    ncomp: integer;

function search(a: integer): integer;
label end_search;
var
    curr, step, ostep: integer;
    left, right: integer;
begin
    ncomp := 0;
    search := -1;
    curr := asize div 2;
    step := curr;
    repeat
        if nums[curr] = a then
        begin
            search := inds[curr];
            goto end_search
        end
        else
            if a < nums[curr] then
            begin
                curr := curr - step;
                if curr < 1 then
                    curr := 1;
            end
            else
            begin
                curr := curr + step;
                if curr > asize then
                    curr := asize;
            end;
        ostep := step;
        step := step div 2;
    until step <= 1;
    left := curr - ostep;
    if left < 1 then
        left := 1;
    right := curr + ostep;
    if right > asize then
        right := asize;
    for curr := left to right do
        if a = nums[curr] then
            search := inds[curr];
end_search: ;
end;

var
    i, found: integer;
begin
    fill_random;
    backup;
    print_array;
    buble;
    for i := 1 to asize do
    begin
        found := search(nums[i]);
        writeln('nums[', inds[i], ']=', nums[i], ' (found ', found index, ')');
        if found = -1 then
            writeln('Fail (not found)')
        else
            if nums_orig[found] = nums[i] then
                writeln('Ok.')
            else
                writeln('Fail.')
    end
end.
