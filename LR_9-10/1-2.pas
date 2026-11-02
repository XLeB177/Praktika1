program laba910;

var
  mass: array of integer; // динамический массив
  i: integer; // глобальная

procedure MinNum1(a: array of integer);
var
  m: integer;//локальная
  i: integer;//локальная
begin
  m := abs(a[0]);
  for i := 1 to High(a) do
  begin
    if abs(a[i]) < m then
      m := abs(a[i]);
  end;
  writeln('Минимальное по модулю: ', m);
end;

procedure MinNum2(a: array of integer);
var
  m: integer;//локальная
  i: integer;//локальная
  found: boolean;//локальная
begin
  m := 101;
  found := false;
  for i := 0 to High(a) do
  begin
    if (a[i] < m) and (a[i] < 0) then
    begin
      m := a[i];
      found := true;
    end;
  end;
  if found then
    writeln('Максимальное отрицательное: ', m)
  else
    writeln('Отрицательных чисел нет');
end;

begin
  randomize;
  SetLength(mass, 10);
  
  for i := 0 to 9 do 
  begin
    mass[i] := random(201) - 100;
  end;
  
  writeln('Массив:');
  for i := 0 to 9 do
  begin
    write(mass[i], ' ');
  end;
  writeln;

  MinNum1(mass);
  MinNum2(mass);
end.