program LR22;
var
  numbers: array[1..100] of integer;
  i, j, n, schet, max_schet: integer;
  chastoechislo: integer;
begin
  write('Сколько чисел? ');
  readln(n);
  
  // Ввод чисел
  for i := 1 to n do
  begin
    write('Введите число ', i, ': ');
    readln(numbers[i]);
  end;
  
  // Поиск самого частого числа
  chastoechislo := numbers[1];
  max_schet := 0;
  
  for i := 1 to n do
  begin
    schet := 0;
    for j := 1 to n do
    begin
      if numbers[j] = numbers[i] then
        schet := schet + 1;
    end;
    
    if schet > max_schet then
    begin
      max_schet := schet;
      chastoechislo := numbers[i];
    end;
  end;
  
  writeln('Самое частое число: ', chastoechislo);
  writeln('Оно встречается ', max_schet, ' раз');
end.