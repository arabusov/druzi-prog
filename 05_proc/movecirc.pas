program MovingCircle;

uses crt, graph;

var
  gd, gm: integer;
  maxX, maxY: integer;
  circleX, circleY: integer;
  circleColor: word;
  ch: char;

procedure DrawCircle;
begin
  setfillstyle(SolidFill, circleColor);
  fillellipse(circleX, circleY, 20, 20);
end;

begin
  gd := DETECT;
  initgraph(gd, gm, 'C:\TP\BGI');

  maxX := getmaxx;
  maxY := getmaxy;

  randomize;
  circleX := random(maxX);
  circleY := random(maxY);
  circleColor := random(MaxColors);

  { New code: Main loop to handle keyboard input }
  repeat
    cleardevice;
    DrawCircle;

    if keypressed then
    begin
      ch := readkey;

      { New code: Move the circle using arrow keys }
      case ch of
        #0:
          begin
            ch := readkey;
            case ch of
              #72: if circleY > 20 then circleY := circleY - 5;      { Up arrow }
              #80: if circleY < maxY - 20 then circleY := circleY + 5; { Down arrow }
              #75: if circleX > 20 then circleX := circleX - 5;      { Left arrow }
              #77: if circleX < maxX - 20 then circleX := circleX + 5; { Right arrow }
            end;
          end;
      end;
    end;

    delay(50);
  until ch = #27; { Exit when ESC key is pressed }

  closegraph;
end.
