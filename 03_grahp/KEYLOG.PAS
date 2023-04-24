program keylogger;

uses crt;

var
    ch: char;
    exit_flag: boolean;

begin
    repeat
        if keypressed then
        begin
            ch := readkey;
            write(ord(ch));
            if ch = #27 then
                exit_flag := true;
            if ch = #0 then
            begin
                ch := readkey;
                write(' ', ord(ch))
            end;
            writeln
        end;
    until exit_flag;
    readln
end.