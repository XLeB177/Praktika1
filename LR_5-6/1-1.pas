program LR11;
var
  mass: array[1..20] of integer;
  i, n: integer;
begin
  n := 20;
  
  for i := 1 to n do
  begin
    write('Введите ', i, ' элемент массива: ');
    readln(mass[i]);
  end;
  
  for i := 1 to n do
  begin
    if mass[i] > 0 then
      mass[i] := 0
    else
      mass[i] := sqr(mass[i]);
  end;
  
  write('Результат: ');
  for i := 1 to n do
  begin
    write(mass[i]);
    if i < n then write(' ');
  end;
  writeln;
end.