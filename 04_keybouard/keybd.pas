program keylogger;

uses crt;

var
    ch: char;

begin
    repeat
        if keypressed then
        begin
            ch := readkey;
            write(ord(ch), ' ');
            if ch = #0 then
            begin
                ch := readkey;
                write(ord(ch));
            end;
            writeln;
        end
    until ch = #27
end.
