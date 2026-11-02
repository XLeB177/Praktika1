program LR22;
var
  text: string;
  i: integer;
  x_found, w_found: boolean;
begin
  write('Введите текст: ');
  readln(text);
  
  x_found := false;
  w_found := false;
  
  for i := 1 to Length(text) do
  begin
    if text[i] = 'x' then
    begin
      x_found := true;
      break;
    end
    else if text[i] = 'w' then
    begin
      w_found := true;
      break;
    end;
  end;
  
  if x_found then
    writeln('первым встречается x')
  else if w_found then
    writeln('первым встречается w');
end.