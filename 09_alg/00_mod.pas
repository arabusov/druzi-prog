program modulo_example;

var a, f: integer;

begin
    f := 7;
    for a := 1 to 10 do
        writeln('a = ', a, ', d = ', a div f, ', r = ', a mod f)
end.
