program arkanoid;

uses vga256, crt;

const
    r = 6;
    nlength = 30;
    av = 9;

var device, mode: integer;
    maxx, maxy: integer;
    x, y: integer;
    c, ac: byte;
    dx, dy: integer;
    ax, alength, a_dx: integer;
    moved_arkanoid: boolean;
    exit_flag: boolean;

procedure draw_ball;
begin
    setcolor(c);
    circle(x, y, r)
end;

procedure draw_arkanoid_color(ark_color: byte);
begin
    setcolor(ark_color);
    bar(ax - alength, maxy - r-2, ax + alength, maxy-2)
end;

procedure minor_tune;
begin
     sound(440);
     delay(150);
     sound(415);
     delay(200);
     sound(390);
     delay(300);
     nosound
end;

procedure hit_tune;
begin
    sound(220);
    delay(200);
    sound(880);
    delay(60);
    nosound
end;

procedure check_arkanoid;
begin
    if (y+2*r >= maxy - 3) and (y < maxy-3)
       and (x >= ax - alength) and (x <= ax + alength) then
    begin
        dy := -dy;
        hit_tune
    end
end;

procedure draw_arkanoid;
begin
    draw_arkanoid_color(ac)
end;

procedure clear_arkanoid;
begin
    draw_arkanoid_color(0)
end;

procedure clear_ball;
begin
    setcolor(0);
    circle(x, y, r)
end;

procedure check_wall;
begin
    if (x >= maxx - r - 3) or (x <= r + 3) then
        dx := -dx;
    if y <= 3 + r then
        dy := -dy;
    if y >= maxx - r - 3 then
    begin
        exit_flag := true;
        minor_tune
    end
end;

procedure init_ball;
begin
    x := maxx div 2;
    y := maxy - 2 * r - 4;
    dy := -1;
    dx := 1;
    c := 47;
end;

procedure init_arkanoid;
begin
    ax := maxx div 2;
    ac := 87;
    alength := nlength;
end;

procedure fly_ball;
begin
    x := x + dx;
    y := y + dy
end;

procedure move_arkanoid;
begin
    ax := ax + a_dx;
    if ax >= (maxx-alength) then
        ax := maxx - alength;
    if ax <= alength then
        ax := alength
end;

procedure check_input;
var
    ch: char;
begin
    moved_arkanoid := false;
    if keypressed then
    begin
        ch := readkey;
        if ch = #27 then
            exit_flag := true;
        if ch = #0 then
        begin
            ch := readkey;
            if ch = #75 then
            begin
                moved_arkanoid := true;
                a_dx := -av
            end;
            if ch = #77 then
            begin
                moved_arkanoid := true;
                a_dx := av
            end
        end
    end
end;

procedure conf_keyboard;
begin
    asm
    mov ax, 0305h
    mov bx, 0
    int 16h
    end
end;

procedure reset_keyboard;
begin
    asm
    mov ax, 0300h
    int 16h
    end
end;

procedure game_over;
begin
    cls(0);
    setcolor(15);
    reset_keyboard;
    closegraph;
    writeln('Game over.');
    repeat
    until keypressed;
    readkey;
end;

begin
    initgraph;
    maxx := getmaxx;
    maxy := getmaxy;
    rect(0, 0, maxx, maxy);
    init_ball;
    init_arkanoid;
    draw_arkanoid;
    exit_flag := false;
    conf_keyboard;
    repeat
        check_input;
        fly_ball;
        check_wall;
        if exit_flag then
           break;
        check_arkanoid;
        draw_ball;
        delay(15);
        clear_ball;
        if moved_arkanoid then
        begin
            clear_arkanoid;
            move_arkanoid;
            draw_arkanoid
        end
    until exit_flag;
    game_over
end.
