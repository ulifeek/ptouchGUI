unit unitHistory;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm3 }

  TForm3 = class(TForm)
    ListBox1: TListBox;
    procedure FormShow(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
  private

  public

  end;

var
  Form3: TForm3;

implementation

{$R *.lfm}
uses unitmain;
{ TForm3 }


procedure TForm3.FormShow(Sender: TObject);
begin
  Form3.left:=Form1.left + Form1.width - Form3.width;
  Form3.top:= Form1.Top+  Form1.height +20;
end;

procedure TForm3.ListBox1DblClick(Sender: TObject);
begin
  Form1.ListBox1DblClick(self);
end;

end.

