unit unit3;
{$mode objfpc}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs,
  Grids, StdCtrls, Menus, ExtCtrls, StrUtils, Windows;

const
  FileName = 'calls.dat';

type
  TCall = record
    CallDate: string[10];
    CallTime: string[8];
    CallerName: string[50];
    CalleeName: string[50];
    Topic: string[100];
    Duration: Integer;
  end;

  { TForm1 }
  TForm1 = class(TForm)
    edCallDate: TEdit;
    edCallTime: TEdit;
    edCaller: TEdit;
    edCallee: TEdit;
    edTopic: TEdit;
    edDuration: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    sgCalls: TStringGrid;
    procedure edCallDateChange(Sender: TObject);
    procedure edCallTimeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
  private
    procedure LoadFromFile;
  public
  end;

var
  Form1: TForm1;

implementation
{$R *.lfm}

{ TForm1 }

procedure TForm1.LoadFromFile;
var
  f: file of TCall;
  rec: TCall;
  row: Integer;
begin
  sgCalls.RowCount := 2;
  sgCalls.Rows[1].Clear;
  row := 1;

  if not FileExists(FileName) then Exit;

  try
    AssignFile(f, FileName);
    Reset(f);
    try
      while not Eof(f) do
      begin
        Read(f, rec);
        if row >= sgCalls.RowCount then
          sgCalls.RowCount := sgCalls.RowCount + 1;
        sgCalls.Cells[0, row] := rec.CallDate;
        sgCalls.Cells[1, row] := rec.CallTime;
        sgCalls.Cells[2, row] := rec.CallerName;
        sgCalls.Cells[3, row] := rec.CalleeName;
        sgCalls.Cells[4, row] := rec.Topic;
        sgCalls.Cells[5, row] := IntToStr(rec.Duration);
        Inc(row);
      end;
    finally
      CloseFile(f);
    end;
  except
    ShowMessage('Ошибка при чтении файла!');
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  SetCurrentDir(ExtractFilePath(Application.ExeName));

  sgCalls.Cells[0, 0] := 'Дата';
  sgCalls.Cells[1, 0] := 'Время';
  sgCalls.Cells[2, 0] := 'Кто звонил';
  sgCalls.Cells[3, 0] := 'Кому';
  sgCalls.Cells[4, 0] := 'Тема';
  sgCalls.Cells[5, 0] := 'Длит.(мин)';

  LoadFromFile;
end;

procedure TForm1.MenuItem10Click(Sender: TObject);
var
  f: file of TCall;
  rec: TCall;
  records: array of TCall;
  i, row, count: Integer;
begin
  // проверяем что строка выбрана
  row := sgCalls.Row;
  if row < 1 then
  begin
    ShowMessage('Выберите запись для редактирования!');
    Exit;
  end;

  // проверка что все поля заполнены
  if (edCallDate.Text = '') or (edCallTime.Text = '') or
     (edCaller.Text = '') or (edCallee.Text = '') or
     (edTopic.Text = '') or (edDuration.Text = '') then
  begin
    ShowMessage('Заполните все поля для редактирования!');
    Exit;
  end;

  // проверка что длительность — число
  if StrToIntDef(edDuration.Text, -1) < 0 then
  begin
    ShowMessage('Продолжительность должна быть числом!');
    Exit;
  end;

  // читаем все записи в массив
  count := 0;
  try
    AssignFile(f, FileName);
    Reset(f);
    SetLength(records, FileSize(f));
    while not Eof(f) do
    begin
      Read(f, rec);
      records[count] := rec;
      Inc(count);
    end;
    CloseFile(f);
  except
    ShowMessage('Ошибка при чтении файла!');
    Exit;
  end;

  // меняем нужную запись
  records[row - 1].CallDate := edCallDate.Text;
  records[row - 1].CallTime := edCallTime.Text;
  records[row - 1].CallerName := edCaller.Text;
  records[row - 1].CalleeName := edCallee.Text;
  records[row - 1].Topic := edTopic.Text;
  records[row - 1].Duration := StrToInt(edDuration.Text);

  // перезаписываем файл
  try
    AssignFile(f, FileName);
    Rewrite(f);
    for i := 0 to count - 1 do
      Write(f, records[i]);
    CloseFile(f);
  except
    ShowMessage('Ошибка при записи файла!');
    Exit;
  end;

  // очищаем поля и обновляем таблицу
  edCallDate.Text := '';
  edCallTime.Text := '';
  edCaller.Text := '';
  edCallee.Text := '';
  edTopic.Text := '';
  edDuration.Text := '';

  LoadFromFile;
end;

procedure TForm1.MenuItem11Click(Sender: TObject);
var
  f: file of TCall;
  rec: TCall;
  records: array of TCall;
  i, row, count: Integer;
begin
  // проверяем что строка выбрана
  row := sgCalls.Row;
  if row < 1 then
  begin
    ShowMessage('Выберите запись для удаления!');
    Exit;
  end;

  if MessageDlg('Удалить запись?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;

  // читаем все записи из файла в массив
  count := 0;
  try
    AssignFile(f, FileName);
    Reset(f);
    SetLength(records, FileSize(f));
    while not Eof(f) do
    begin
      Read(f, rec);
      records[count] := rec;
      Inc(count);
    end;
    CloseFile(f);
  except
    ShowMessage('Ошибка при чтении файла!');
    Exit;
  end;

  // перезаписываем файл без удалённой строки
  try
    AssignFile(f, FileName);
    Rewrite(f);
    for i := 0 to count - 1 do
      if i <> row - 1 then
        Write(f, records[i]);
    CloseFile(f);
  except
    ShowMessage('Ошибка при записи файла!');
    Exit;
  end;

  // обновляем таблицу
  LoadFromFile;
end;

procedure TForm1.MenuItem13Click(Sender: TObject);
var
  searchStr: string;
  i: Integer;
  found: Boolean;
begin
  searchStr := InputBox('Поиск', 'Введите имя звонившего:', '');
  if searchStr = '' then Exit;

  found := False;
  for i := 1 to sgCalls.RowCount - 1 do
  begin
    if AnsiContainsText(sgCalls.Cells[2, i], searchStr) then
    begin
      sgCalls.Row := i;
      sgCalls.SetFocus;
      found := True;
      Break;
    end;
  end;

  if not found then
    ShowMessage('Запись не найдена!');
end;

procedure TForm1.MenuItem14Click(Sender: TObject);
begin
  edCallDate.Text := '';
  edCallTime.Text := '';
  edCaller.Text := '';
  edCallee.Text := '';
  edTopic.Text := '';
  edDuration.Text := '';
end;

procedure TForm1.MenuItem15Click(Sender: TObject);
var
  f: file of TCall;
  rec: TCall;
  records: array of TCall;
  i, j, count: Integer;
  temp: TCall;
begin
  if not FileExists(FileName) then Exit;

  // читаем все записи в массив
  count := 0;
  try
    AssignFile(f, FileName);
    Reset(f);
    SetLength(records, FileSize(f));
    while not Eof(f) do
    begin
      Read(f, rec);
      records[count] := rec;
      Inc(count);
    end;
    CloseFile(f);
  except
    ShowMessage('Ошибка при чтении файла!');
    Exit;
  end;

  // сортировка по дате по возрастанию (пузырьком)
  for i := 0 to count - 2 do
    for j := 0 to count - 2 - i do
      if records[j].CallDate > records[j+1].CallDate then
      begin
        temp := records[j];
        records[j] := records[j+1];
        records[j+1] := temp;
      end;

  // перезаписываем файл
  try
    AssignFile(f, FileName);
    Rewrite(f);
    for i := 0 to count - 1 do
      Write(f, records[i]);
    CloseFile(f);
  except
    ShowMessage('Ошибка при записи файла!');
    Exit;
  end;

  LoadFromFile;
end;

procedure TForm1.MenuItem16Click(Sender: TObject);
var
  f: file of TCall;
  rec: TCall;
  records: array of TCall;
  i, j, count: Integer;
  temp: TCall;
begin
  if not FileExists(FileName) then Exit;

  // читаем все записи в массив
  count := 0;
  try
    AssignFile(f, FileName);
    Reset(f);
    SetLength(records, FileSize(f));
    while not Eof(f) do
    begin
      Read(f, rec);
      records[count] := rec;
      Inc(count);
    end;
    CloseFile(f);
  except
    ShowMessage('Ошибка при чтении файла!');
    Exit;
  end;

  // сортировка по дате по убыванию (пузырьком)
  for i := 0 to count - 2 do
    for j := 0 to count - 2 - i do
      if records[j].CallDate < records[j+1].CallDate then
      begin
        temp := records[j];
        records[j] := records[j+1];
        records[j+1] := temp;
      end;

  // перезаписываем файл
  try
    AssignFile(f, FileName);
    Rewrite(f);
    for i := 0 to count - 1 do
      Write(f, records[i]);
    CloseFile(f);
  except
    ShowMessage('Ошибка при записи файла!');
    Exit;
  end;

  LoadFromFile;
end;

procedure TForm1.MenuItem2Click(Sender: TObject); // Создать
begin
  if MessageDlg('Создать новый файл? Текущие данные будут удалены!',
     mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;

  if FileExists(FileName) then
    DeleteFile(FileName);

  LoadFromFile;
end;

procedure TForm1.MenuItem3Click(Sender: TObject); // Открыть
var
  dlg: TOpenDialog;
  destPath: string;
begin
  dlg := TOpenDialog.Create(Self);
  try
    dlg.Filter := 'Файлы данных (*.dat)|*.dat';
    if dlg.Execute then
    begin
      if not FileExists(dlg.FileName) then
      begin
        ShowMessage('Файл не найден!');
        Exit;
      end;
      destPath := ExtractFilePath(Application.ExeName) + 'calls.dat';
      if FileExists(destPath) then
        SysUtils.DeleteFile(destPath); // это SysUtils.DeleteFile — принимает string
      CopyFile(PChar(dlg.FileName), PChar(destPath), False);
      LoadFromFile;
    end;
  finally
    dlg.Free;
  end;
end;

procedure TForm1.MenuItem4Click(Sender: TObject); // Сохранить как
var
  dlg: TSaveDialog;
  fSrc, fDst: file of TCall;
  rec: TCall;
begin
  dlg := TSaveDialog.Create(Self);
  try
    dlg.Filter := 'Файлы данных (*.dat)|*.dat';
    dlg.DefaultExt := 'dat';
    if dlg.Execute then
    begin
      try
        AssignFile(fSrc, FileName);
        AssignFile(fDst, dlg.FileName);
        Reset(fSrc);
        Rewrite(fDst);
        while not Eof(fSrc) do
        begin
          Read(fSrc, rec);
          Write(fDst, rec);
        end;
        CloseFile(fSrc);
        CloseFile(fDst);
        ShowMessage('Файл сохранён как ' + dlg.FileName);
      except
        ShowMessage('Ошибка при сохранении файла!');
      end;
    end;
  finally
    dlg.Free;
  end;
end;

procedure TForm1.MenuItem5Click(Sender: TObject); // Закрыть
begin
  if MessageDlg('Закрыть файл?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;

  sgCalls.RowCount := 2;
  sgCalls.Rows[1].Clear;
end;

procedure TForm1.MenuItem6Click(Sender: TObject); // Выход
begin
  if MessageDlg('Выйти из программы?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;
  Close;
end;

procedure TForm1.MenuItem7Click(Sender: TObject); // Сохранить
begin
  ShowMessage('Данные сохранены в ' + FileName);
end;

procedure TForm1.MenuItem9Click(Sender: TObject);
var
  f: file of TCall;
  rec: TCall;
begin
  // проверка что все поля заполнены
  if (edCallDate.Text = '') or (edCallTime.Text = '') or
     (edCaller.Text = '') or (edCallee.Text = '') or
     (edTopic.Text = '') or (edDuration.Text = '') then
  begin
    ShowMessage('Заполните все поля!');
    Exit;
  end;

  // проверка что длительность — число
  if StrToIntDef(edDuration.Text, -1) < 0 then
  begin
    ShowMessage('Продолжительность должна быть числом!');
    Exit;
  end;

  // заполняем запись
  rec.CallDate := edCallDate.Text;
  rec.CallTime := edCallTime.Text;
  rec.CallerName := edCaller.Text;
  rec.CalleeName := edCallee.Text;
  rec.Topic := edTopic.Text;
  rec.Duration := StrToInt(edDuration.Text);

  // записываем в файл
  try
    AssignFile(f, FileName);
    if FileExists(FileName) then
      Reset(f)
    else
      Rewrite(f);
    Seek(f, FileSize(f));
    Write(f, rec);
    CloseFile(f);
  except
    ShowMessage('Ошибка при записи в файл!');
    Exit;
  end;

  // очищаем поля
  edCallDate.Text := '';
  edCallTime.Text := '';
  edCaller.Text := '';
  edCallee.Text := '';
  edTopic.Text := '';
  edDuration.Text := '';

  // обновляем таблицу
  LoadFromFile;
end;

procedure TForm1.edCallDateChange(Sender: TObject);
begin
end;

procedure TForm1.edCallTimeChange(Sender: TObject);
begin
end;

end.
