
function stepen (a,b: integer):integer;//параметризация 
begin
  if (b = 0) then stepen := 1//база рекурсии
  else 
    begin
    stepen := a * stepen(a, b-1);//Декомпозиция
  end;
end;
begin
  var x:=ReadInteger('Число?');
  var y:=ReadInteger('Степень?');
  print(stepen(x,y));
end.