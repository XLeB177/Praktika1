function NOD(a, b: integer): integer; // параметризация
begin
  if b = 0 then //база рекурсии
    NOD := a
  else
    NOD := NOD(b, a mod b);//декомпозиция
end;

begin
  var x := ReadInteger('Введите первое число:');
  var y := ReadInteger('Введите второе число:');
  Print('НОД(', x, ',', y, ') = ', NOD(x, y));
end.