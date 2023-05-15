program RandomCircle;
uses crt, graph;

var
  gd, gm: integer;
  maxX, maxY: integer;
  circleX, circleY: integer;
  circleColor: word;

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

  DrawCircle;
  readln;
  closegraph;
end.
