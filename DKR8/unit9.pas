unit unit9;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    bCalc: TButton;
    cbFigure: TComboBox;
    eA: TEdit;
    eB: TEdit;
    eH: TEdit;
    eResult: TEdit;
    Image1: TImage;
    lFigure1: TLabel;
    lFigure2: TLabel;
    lFigure3: TLabel;
    lResult: TLabel;
    lFigure: TLabel;

    procedure cbFigureChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bCalcClick(Sender: TObject);
    procedure lFigure1Click(Sender: TObject);

  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  cbFigure.Items.Add('Квадрат');
  cbFigure.Items.Add('Прямоугольник');
  cbFigure.Items.Add('Круг');
  cbFigure.Items.Add('Треугольник');

  cbFigure.ItemIndex := -1;

  eResult.ReadOnly := True;
end;

procedure TForm1.cbFigureChange(Sender: TObject);
begin

end;

procedure TForm1.bCalcClick(Sender: TObject);
var
  a, b, h, s: Double;
begin
  if cbFigure.ItemIndex = -1 then
  begin
    ShowMessage('Выберите фигуру!');
    Exit;
  end;

  a := StrToFloatDef(eA.Text, 0);
  b := StrToFloatDef(eB.Text, 0);
  h := StrToFloatDef(eH.Text, 0);

  case cbFigure.ItemIndex of
    0: s := Sqr(a);           // квадрат
    1: s := a * b;           // прямоугольник
    2: s := Pi * Sqr(a);     // круг
    3: s := (a * h) / 2;     // треугольник
  else
    Exit;
  end;

  eResult.Text := FloatToStr(s);
end;

procedure TForm1.lFigure1Click(Sender: TObject);
begin

end;

end.
