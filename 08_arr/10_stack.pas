program stack_program;

const ssize = 128;
var
    stack: array [1..ssize] of integer;
    sp: integer;

procedure init_stack;
begin
    sp := 0;
end;

procedure push(x: integer);
begin
    if sp < ssize then
    begin
        sp := sp + 1;
        stack[sp] := x;
    end
    else
    begin
        writeln('Stack overflow');
        exit;
    end
end;

function pop: integer;
begin
    if sp >= 1 then
    begin
        pop := stack[sp];
        sp := sp - 1;
    end
    else
    begin
        writeln('Stack underflow');
        exit;
    end
end;

var
    i: integer;
    tmp: integer;
begin
    for i := 1 to 5 do begin
        tmp := random(100);
        writeln('push ', tmp, ' on stack');
        push(tmp);
    end;
    for i := 1 to 5 do begin
        writeln('pop  ', pop, ' from stack');
    end
end.

