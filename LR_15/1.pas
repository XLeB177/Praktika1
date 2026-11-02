
procedure printN(n :integer); //параметризация 
begin 
  print(n);
  if (n = 0) or (n = 1) then exit //база рекурсии
  else
    printN(n - 2); //Декомпозиция
end;
begin
  printN(25);
end.