unit unitoptions;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, ActnList, Menus,inifiles;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Button3: TButton;
    ShowPtouchprinterInfo: TAction;
    ListBox3: TListBox;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    PageControl1: TPageControl;
    PopupMenu1: TPopupMenu;
    ShowApplicationIni: TAction;
    ShowPrinterIni: TAction;
    ReadPrinterStandard: TAction;
    TabSheet1: TTabSheet;
    TabSheet3: TTabSheet;
    WritePrinterIni: TAction;
    ReadPrinterIni: TAction;
    WriteIniFile: TAction;
    ReadIniFile: TAction;
    ActionList1: TActionList;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    ComboBox2: TComboBox;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    LabeledEdit10: TLabeledEdit;
    LabeledEdit11: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    LabeledEdit8: TLabeledEdit;
    LabeledEdit9: TLabeledEdit;
    UpDown10: TUpDown;
    UpDown11: TUpDown;
    UpDown12: TUpDown;
    UpDown13: TUpDown;
    UpDown14: TUpDown;
    UpDown15: TUpDown;
    UpDown4: TUpDown;
    UpDown5: TUpDown;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure ReadIniFileExecute(Sender: TObject);
    procedure ReadPrinterIniExecute(Sender: TObject);
    procedure SelectWorkingDirectoryExecute(Sender: TObject);
    procedure ShowApplicationIniExecute(Sender: TObject);
    procedure ShowPtouchprinterInfoExecute(Sender: TObject);
    procedure WriteIniFileExecute(Sender: TObject);
    procedure WritePrinterIniExecute(Sender: TObject);
    procedure Select_FN_ImagemagickExecute(Sender: TObject);
    procedure Select_FN_PTouch_PrintExecute(Sender: TObject);

  public
    function ApplicationIniFilename: string;
    function PrinterIniFilename: string;

  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

uses unitmain;

procedure TForm2.ReadIniFileExecute(Sender: TObject);
begin
  with Tinifile.create(ApplicationIniFilename)do
    begin
      LabeledEdit7.text:=ReadString('Printer','Ptouch_Print', '');
      LabeledEdit8.text:=ReadString('Printer','imagemagick','');
      LabeledEdit9.text:=ReadString('Printer','WorkingDir',ExtractFilePath(paramstr(0))+'labels');
      combobox2.ItemIndex:=combobox2.items.indexof(ReadString('Printer','name',''));
      ReadPrinterIniExecute(self);
      end;
   ReadPrinterIniExecute(self);
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  form2.hide;
  form1.show;
  form1.IniAfterStartExecute(self);
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  form2.hide;
  form1.show;
end;

procedure TForm2.PageControl1Change(Sender: TObject);
begin
  case PageControl1.ActivePageIndex of
  0: ShowApplicationIniExecute(self);
  1: ShowPtouchprinterInfoExecute(self);
  end;
end;

procedure TForm2.WriteIniFileExecute(Sender: TObject);
begin
    with Tinifile.create(ApplicationIniFilename)do
    begin
      WriteString('Printer','Ptouch_Print',LabeledEdit7.text);
      WriteString('Printer','imagemagick',LabeledEdit8.text);
      WriteString('Printer','WorkingDir',LabeledEdit9.text);
      WriteString('Printer','name',combobox2.text);
      free;
      end;
    WritePrinterIniExecute(self);
end;

procedure TForm2.ReadPrinterIniExecute(Sender: TObject);
begin
  with Tinifile.create(ApplicationIniFilename) do // use PrinterIniFilename for separate printer.ini;
    begin
      combobox2.ItemIndex:=combobox2.items.IndexOf(ReadString('PrinterProperties','name',''));
      UpDown5.Position:=ReadInteger('PrinterProperties','DPI',180);
      UpDown4.Position:=ReadInteger('PrinterProperties','MaxLength_mm',270);
      updown10.Position :=ReadInteger('Tape_'+Checkbox10.caption,'Width', 16);
      checkbox10.Checked:=ReadBool('Tape_'+Checkbox10.caption,'Supported', false);
      updown11.Position :=ReadInteger('Tape_'+Checkbox11.caption,'Width', 32);
      checkbox11.Checked:=ReadBool('Tape_'+Checkbox11.caption,'Supported', false);
      updown12.Position :=ReadInteger('Tape_'+Checkbox12.caption,'Width', 48);
      checkbox12.Checked:=ReadBool('Tape_'+Checkbox12.caption,'Supported', false);
      updown13.Position :=ReadInteger('Tape_'+Checkbox13.caption,'Width', 68);
      checkbox13.Checked:=ReadBool('Tape_'+Checkbox13.caption,'Supported', false);
      updown14.Position :=ReadInteger('Tape_'+Checkbox14.caption,'Width', 112);
      checkbox14.Checked:=ReadBool('Tape_'+Checkbox14.caption,'Supported', false);
      updown15.Position :=ReadInteger('Tape_'+Checkbox15.caption,'Width', 128);
      checkbox15.Checked:=ReadBool('Tape_'+Checkbox15.caption,'Supported', false);
      free;
      end;
end;

procedure TForm2.WritePrinterIniExecute(Sender: TObject);
begin
  with Tinifile.create(ApplicationIniFilename) do // use PrinterIniFilename for separate printer.ini;
  begin
    Writestring('PrinterProperties','name',combobox2.text);
    WriteInteger('PrinterProperties','DPI',UpDown5.Position);
    WriteInteger('PrinterProperties','MaxLength_mm',UpDown4.Position);
    WriteInteger('Tape_'+Checkbox10.caption,'Width', updown10.Position);
    WriteBool('Tape_'+Checkbox10.caption,'Supported', checkbox10.Checked);
    WriteInteger('Tape_'+Checkbox11.caption,'Width', updown11.Position);
    WriteBool('Tape_'+Checkbox11.caption,'Supported',checkbox11.Checked);
    WriteInteger('Tape_'+Checkbox12.caption,'Width', updown12.Position);
    WriteBool('Tape_'+Checkbox12.caption,'Supported', checkbox12.Checked);
    WriteInteger('Tape_'+Checkbox13.caption,'Width', updown13.Position);
    WriteBool('Tape_'+Checkbox13.caption,'Supported', checkbox13.Checked);
    WriteInteger('Tape_'+Checkbox14.caption,'Width', updown14.Position);
    WriteBool('Tape_'+Checkbox14.caption,'Supported', checkbox14.Checked);
    WriteInteger('Tape_'+Checkbox15.caption,'Width', updown15.Position);
    WriteBool('Tape_'+Checkbox15.caption,'Supported', checkbox15.Checked);
    free;
    end;
end;


procedure TForm2.SelectWorkingDirectoryExecute(Sender: TObject);
var dir:string;
begin
  SelectDirectory('verzeichnis wählen:', Extractfilepath(Paramstr(0)),Dir);
  if DirectoryExists(dir)
    then LabeledEdit9.text:=dir
    else showmessage('Verzeichnis existiert nicht, bitte korrigieren!');
end;

procedure TForm2.ShowApplicationIniExecute(Sender: TObject);
begin
  if FileExists(ApplicationIniFilename) then Listbox3.items.Loadfromfile(ApplicationIniFilename);
end;


procedure TForm2.ShowPtouchprinterInfoExecute(Sender: TObject);
begin
  Form1.BPTPrinter.ShowVHSI;
end;

procedure TForm2.Select_FN_ImagemagickExecute(Sender: TObject);
begin
  with TOpenDialog.Create(self) do
   begin
   Options:=[ofPathMustExist,ofNoResolveLinks];
   InitialDir:='/usr/bin/';
   Filename:=LabeledEdit8.text;
    if Execute
      then if FileExists(FileName) and (ExtractFileName(filename)='convert')
             then LabeledEdit8.text:=FileName
             else begin
                    showmessage('Bitte Image-Magick installieren! Programmabbruch');
                    Form2.Close;
                   end;
   free;
   end;
end;

procedure TForm2.Select_FN_PTouch_PrintExecute(Sender: TObject);
begin
  with TOpenDialog.Create(self) do
   begin
   Options:=[ofPathMustExist,ofNoResolveLinks];
   InitialDir:='/usr/bin/';
   Filename:=LabeledEdit7.text;
   if Execute
     then if FileExists(FileName) and (ExtractFileName(filename)='ptouch-print')
           then LabeledEdit7.text:=FileName
           else begin
                 showmessage('Bitte ptouch-print installieren! Programmabbruch');
                 Form2.Close;
                 end;
   free;
   end;
end;

function TForm2.ApplicationIniFilename: string;
begin
  result:=ChangeFileExt(Paramstr(0),'.ini');
end;

function TForm2.PrinterIniFilename: string;
begin
  result :=ResourceDir+combobox2.text+'.ini';
end;

end.

