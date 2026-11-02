program LR34;
var
  text, new_text: string;
  i: integer;
begin
  write('Введите текст: ');
  readln(text);
  
  new_text := '';
  i := 1;
  
  while i <= Length(text) do
  begin
    if Copy(text, i, 4) = 'word' then
    begin
      new_text := new_text + 'letter';
      i := i + 4; 
    end
    else
    begin
      new_text := new_text + text[i];
      i := i + 1;
    end;
  end;
  
  writeln('Измененный текст:');
  writeln(new_text);
end.