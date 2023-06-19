program gcd_recursive_example;
var x, y: integer;

function gcd(u, v: integer): integer;
begin
    if v = 0 then
        gcd := u
    else
        gcd := gcd(v, u mod v);
end;

begin
    while not eof do
    begin
        readln(x, y);
        writeln(x, ' ', y, ' ', gcd(abs(x), abs(y)));
    end
end.
