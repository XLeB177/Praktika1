program ArrayProcessing;

var
  mass: array of array of integer; 
  result: array of integer; 
  i, j, has_pair, N: integer;

begin
  randomize;
  N := 8;
  

  SetLength(mass, N);
  for i := 0 to N - 1 do
    SetLength(mass[i], N);
  SetLength(result, N);

  for i := 0 to N - 1 do
    for j := 0 to N - 1 do
      mass[i, j] := random(11);
  

  writeln('Двумерный массив 8x8:');
  for i := 0 to N - 1 do
  begin
    for j := 0 to N - 1 do
      write(mass[i, j]:3);
    writeln;
  end;
  writeln;
  

  for i := 0 to N - 1 do
  begin
    has_pair := -1;
    
    for j := 0 to N - 2 do
    begin
      if mass[i, j] + mass[i, j + 1] = 7 then
      begin
        has_pair := 1;
        break;
      end;
    end;
    
    result[i] := has_pair;
  end;
  
  writeln('Результат:');
  for i := 0 to N - 1 do
    write(result[i], ' ');
  writeln;
end.