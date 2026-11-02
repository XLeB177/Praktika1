
function SumTo(n :integer): integer; //параметризация 
begin 
  
  if (n = 0) then //база рекурсии
  else
    n+= (SumTo(n-1)); //Декомпозиция
  SumTo:=n
end;
begin
  var x:= ReadInteger('Введите число:');
  println('Сумма чисел от 1 до ' + x + ' = ' + SumTo(x));
end.