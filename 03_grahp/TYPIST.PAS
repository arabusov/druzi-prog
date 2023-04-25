program typist;

uses dos;

const msg = 'hello';

var str: string;
    cnt: integer;
    dt: integer;
    h: word;
    m_1, s_1, s100_1: word;
    m_2, s_2, s100_2: word;

begin
     cnt := 0;
     writeln('Press enter to test your typing skills');
     readln;
     gettime(h, m_1, s_1, s100_1);
     repeat
     write(msg, ': ');
     readln(str);
     gettime(h, m_2, s_2, s100_2);
     cnt := cnt + 1;
     until msg = str;
     dt := ((m_2 - m_1)*60 + (s_2 - s_1))*100 + (s100_2 - s100_1);
     writeln('Attempts: ', cnt, ', time: ', dt);
     readln
end.