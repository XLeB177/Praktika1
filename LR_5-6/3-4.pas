program LR34;
var
  arr: array[1..20] of integer;
  i, first_positive, min_index: integer;
begin
  for i := 1 to 20 do
  begin
    write('Введите ', i, ' элемент: ');
    readln(arr[i]);
  end;
  
  first_positive := 0;
  for i := 1 to 20 do
  begin
    if arr[i] > 0 then
    begin
      first_positive := i;
      break;
    end;
  end;
  
  min_index := 1;
  for i := 2 to 20 do
  begin
    if arr[i] < arr[min_index] then
      min_index := i;
  end;
  for i := 1 to 20 do
  begin
    if (i <> first_positive) and (i <> min_index) then
      write(arr[i], ' ');
  end;
end.