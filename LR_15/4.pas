procedure LoopFor(i, n: integer);//параметризация 
begin
  println('Привет', i);
  if i = n then //база рекурсии
    exit
  else 
    LoopFor(i+1, n);//Декомпозиция
end;
begin
  LoopFor(1,10);                    
end.