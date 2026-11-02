program LR11;
var
  text, new_text: string;
  position: integer;
begin
  text := 'Nikolay пошёл в магазин за молоком';
  new_text := '';
  
  position := 1;
  while position <= Length(text) do
  begin
    // Проверяем, есть ли в текущей позиции слово "Nikolay"
    if Copy(text, position, Length('Nikolay')) = 'Nikolay' then
    begin
      new_text := new_text + 'Oleg';
      position := position + Length('Nikolay');
    end
    else
    begin
      new_text := new_text + text[position];
      position := position + 1;
    end;
  end;
  
  writeln('Измененный текст:');
  writeln(new_text);
end.