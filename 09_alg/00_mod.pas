program modulo_example;

var a, f: integer;

begin
    writeln('This program demonstrates what is reminder');
    writeln('Assume we want to divide a by f, both a and f > 0.');
    writeln('Then, one can write');
    writeln('   a = f*d + r,');
    writeln('where 0 <= r < f, r is called a reminder');
    writeln('If a is divisable by f, r = 0');
    writeln('Let us check it experimentaly:');
    f := 7;
    writeln('f = ', f);
    writeln('Let us vary a from one to 100');
    for a := 1 to 100 do
        writeln('a = ', a, ', d = ', a div f, ', r = ', a mod f)
end.
