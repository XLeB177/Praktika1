procedure Fib(p, c, n: integer); // параметризация
begin
  Print(p + c);
  if n > 1 then //база рекурсии
    Fib(c, p + c, n - 1); //декомпозиция
end;

begin
  var a := 0;
  var b := 1;
  var c := 10;
  
  Fib(a, b, c);
end.