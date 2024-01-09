unit unitmain;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ActnList, ComCtrls, Menus, MaskEdit, ExtDlgs, FileUtil, unittape,
  unitbrotherpt, inifiles,fileinfo, unitoptions, unitHistory
  ;

type

  { TForm1 }

  TForm1 = class(TForm)
    AbortWithInfo: TAction;
    UpdateStatusPanel: TAction;
    ToggleHistory: TAction;
    HideHistory: TAction;
    ShowHistory: TAction;
    MenuItem11: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem6: TMenuItem;
    StaticText3: TStaticText;
    Autoconfigure: TAction;
    CalculatePixelWidth: TAction;
    ShowPrinterConfigFile: TAction;
    WritePrinterConfiguration: TAction;
    ReadPrinterConfiguration: TAction;
    MenuItem53: TMenuItem;
    MenuItem54: TMenuItem;
    CreateTestGraphicCustomwidth: TAction;
    HistoryDeleteSelected: TAction;
    HistoryDeleteItem: TAction;
    HistoryDeleteAll: TAction;
    MenuItem3: TMenuItem;
    MenuItem33: TMenuItem;
    MenuItem34: TMenuItem;
    MenuItem35: TMenuItem;
    MenuItem40: TMenuItem;
    MenuItem43: TMenuItem;
    MenuItem44: TMenuItem;
    MenuItem45: TMenuItem;
    MenuItem46: TMenuItem;
    MenuItem47: TMenuItem;
    MenuItem52: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    SaveRTF: TAction;
    LoadRTF: TAction;
    MenuItem32: TMenuItem;
    SaveGraphicTemplate: TAction;
    LoadPictureStretched: TAction;
    LoadPictureStandard: TAction;
    ClearBatchAll: TAction;
    ClearBatchTape: TAction;
    Button1: TButton;
    Button3: TButton;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    GroupBox5: TGroupBox;
    LabeledEdit6: TLabeledEdit;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem31: TMenuItem;
    OpenPictureDialog1: TOpenPictureDialog;
    PrintBatch: TAction;
    MenuItem30: TMenuItem;
    Label1: TLabel;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
    MenuItem10: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    RadioGroup1: TRadioGroup;
    ScrollBox2: TScrollBox;
    Separator10: TMenuItem;
    Separator11: TMenuItem;
    Separator13: TMenuItem;
    Separator7: TMenuItem;
    Separator9: TMenuItem;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StatusBar1: TStatusBar;
    ToggleBox3: TToggleBox;
    ToggleBox4: TToggleBox;
    ToggleBox5: TToggleBox;
    UpdateTapeLength: TAction;
    ComboBox1: TComboBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    LabeledEdit2: TLabeledEdit;
    ShowHelpText: TAction;
    ShowInfo: TAction;
    ShowSupported: TAction;
    ShowVersion: TAction;
    ToggleBox1: TToggleBox;
    ToggleBox2: TToggleBox;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    UpDown3: TUpDown;
    WriteHistoryToFile: TAction;
    ReadHistoryFromFile: TAction;
    WriteTextToHistory: TAction;
    Separator3: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem29: TMenuItem;
    WriteInifile: TAction;
    ReadInifile: TAction;
    MenuItem1: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MainMenu1: TMainMenu;
    SelectFont: TAction;
    UpdateAll: TAction;
    UpdateTapeType: TAction;
    UpdatePreview: TAction;
    IniAfterStart: TAction;
    CreateTestGraphic: TAction;
    CreateTestText: TAction;
    Print: TAction;
    UpdatePanelSize: TAction;
    ActionList1: TActionList;
    FontDialog1: TFontDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    Timer1: TTimer;
    procedure Button2Click(Sender: TObject);
    procedure CalculatePixelWidthExecute(Sender: TObject);
    procedure ClearBatchAllExecute(Sender: TObject);
    procedure ClearBatchTapeExecute(Sender: TObject);
    procedure HideHistoryExecute(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem52Click(Sender: TObject);
    procedure MenuItem54Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure HistoryDeleteAllExecute(Sender: TObject);
    procedure HistoryDeleteItemExecute(Sender: TObject);
    procedure HistoryDeleteSelectedExecute(Sender: TObject);
    procedure IniAfterStartExecute(Sender: TObject);
    procedure LabeledEdit2Change(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure LoadPictureStandardExecute(Sender: TObject);
    procedure LoadPictureStretchedExecute(Sender: TObject);
    procedure LoadRTFExecute(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem28Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem47Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure PrintBatchExecute(Sender: TObject);
    procedure CreateTestGraphicCustomwidthExecute(Sender: TObject);
    procedure CreateTestGraphicExecute(Sender: TObject);
    procedure ReadHistoryFromFileExecute(Sender: TObject);
    procedure ReadInifileExecute(Sender: TObject);
    procedure PrintExecute(Sender: TObject);
    procedure CreateTestTextExecute(Sender: TObject);
    procedure RadioGroup1SelectionChanged(Sender: TObject);
    procedure MenuItem42Click(Sender: TObject);
    procedure SaveGraphicTemplateExecute(Sender: TObject);
    procedure SaveRTFExecute(Sender: TObject);
    procedure ShowHistoryExecute(Sender: TObject);
    procedure ToggleBox1Change(Sender: TObject);
    procedure ToggleBox2Change(Sender: TObject);
    procedure ToggleBox3Click(Sender: TObject);
    procedure ToggleBox4Click(Sender: TObject);
    procedure ToggleBox5Click(Sender: TObject);
    procedure ToggleHistoryExecute(Sender: TObject);
    procedure UpdateStatusPanelExecute(Sender: TObject);
    procedure UpdateTapeLengthExecute(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown2Click(Sender: TObject; Button: TUDBtnType);
    procedure WriteHistoryToFileExecute(Sender: TObject);
    procedure WriteInifileExecute(Sender: TObject);
    procedure SelectFontExecute(Sender: TObject);
    procedure UpdateAllExecute(Sender: TObject);
    procedure UpdatePanelSizeExecute(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure UpdatePreviewExecute(Sender: TObject);
    procedure UpdateTapeTypeExecute(Sender: TObject);
    procedure WriteTextToHistoryExecute(Sender: TObject);
  private
    procedure ComputeTestGraphic(testwidth: integer);

  public
    Tape: TTape;
    BPTPrinter:TBrotherPTPrinter;

  end;

var
  Form1: TForm1;
  WorkDir,TempDir,ResourceDir: String;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  Application.CreateForm(TForm3, Form3);
  ResourceDir:=ExtractFilePath(Application.Params[0])+'res/';
  WorkDir:=ExtractFilePath(Application.Params[0])+'labels/';
  TempDir:=WorkDir + 'temp/';
  if not DirectoryExists(ResourceDir) then CreateDir(ResourceDir);
  if not DirectoryExists(WorkDir) then CreateDir(WorkDir);
  if not DirectoryExists(TempDir) then CreateDir(TempDir);
  panel1.caption:='';
  Tape:=TTape.create(self);
  Tape.Parent:=Panel2;
  tape.left :=0;
  tape.OnContentChanged:=@UpdatePreviewExecute;
  BPTPrinter:=TBrotherPTPrinter.create(self);
  BPTPrinter.Align:=alleft;

  form1.clientwidth:=tape.width;
  RadioGroup1.itemindex:=0;
  scrollbox2.BorderSpacing.Around:=tape.BorderSpacing.around;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  WriteinifileExecute(self);
end;

procedure TForm1.HistoryDeleteAllExecute(Sender: TObject);
begin
  Form3.Listbox1.clear;
end;

procedure TForm1.HistoryDeleteItemExecute(Sender: TObject);
begin
  if Form3.listbox1.ItemIndex>=0 then
    Form3.listbox1.items.Delete(Form3.listbox1.ItemIndex);
end;

procedure TForm1.HistoryDeleteSelectedExecute(Sender: TObject);
begin
  if Form3.Listbox1.SelCount > 0 then Form3.listbox1.DeleteSelected;
end;

procedure TForm1.IniAfterStartExecute(Sender: TObject);
var
  tti: Integer;
begin
  BPTPrinter.Parent:=Form2.TabSheet3;
  ReadInifileExecute(self);
  // Existenz externer Programme testen
  if not FileExists(BPTPrinter.FN_Imagemagick) or not  FileExists(BPTPrinter.FN_Ptouch_Print)
    then begin
           form1.hide;
           form2.Show;
           exit;
         end;

  if not BPTPrinter.IsPrinterConnected
    then begin
           showmessage('Kein Drucker erkannt. Ist ein Drucker angeschlossen? - Programmabbruch');
           close;
           exit;
         end;
  tape.LoadPrinterConfig(Form2.ApplicationIniFilename); //for distinct printer.ini use:(ResourceDir+BPTPrinter.GetPrinternameFromPrinter+'.ini');
  tti:=BPTPrinter.GetTapetypeIndexFromPrinter; //tapetypeindex
  if tti>0 then  tape.TapeType:=tapetypes[tti];
  tape.tapemode:=tmSingle;
  tape.UpdateTape;
  self.ActiveControl:=tape;
  UpDown2Click(self,btprev);
  UpdatePanelSizeExecute(self);
  UpdateTapeLengthExecute(self);
  UpdateTapeTypeExecute(self);
  UpdatePreviewExecute(self);
  timer1.Enabled:=menuitem28.Checked;
end;

procedure TForm1.LabeledEdit2Change(Sender: TObject);
begin
UpdatePreviewExecute(self);
end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
begin
  case tape.tapemode of
    tmSingle:  tape.edit.text:=Form3.listbox1.items[Form3.ListBox1.ItemIndex];
    tmMulti:   tape.memo.lines.Add(Form3.listbox1.items[Form3.ListBox1.ItemIndex]);
    tmRTF:     Tape.rtf.Lines.Add(Form3.listbox1.items[Form3.ListBox1.ItemIndex]);
  end;
end;

procedure TForm1.LoadPictureStandardExecute(Sender: TObject);
var pic: TPicture;
begin
 RadioGroup1.itemindex:=3;     //grafikmodus
 With OpenPictureDialog1 do
  begin
  InitialDir:=WorkDir;
  if Execute then
    begin
      pic:=Tpicture.create;
      pic.LoadFromFile(OpenPictureDialog1.filename);
      tape.tapeCustomLength_px:=pic.Width;
      with tape.image.Picture.Bitmap do
        begin
          height:=tape.TapeType.width;
          width:=pic.Graphic.Width;
          Canvas.Draw(0,0,pic.Graphic);
//          savetofile('testtapeassign.bmp'); /debugging
        end;
      pic.free;
    end;
  end;
 UpdatePreviewExecute(self);
 tape.image.Invalidate;
end;

procedure TForm1.LoadPictureStretchedExecute(Sender: TObject);
var pic: TPicture;
begin
  RadioGroup1.itemindex:=3;     //grafikmodus
  With OpenPictureDialog1 do
  begin
  InitialDir:=WorkDir;
  if Execute then
    begin
      pic:=Tpicture.create;
      pic.LoadFromFile(OpenPictureDialog1.filename);
      with tape.image.Picture.Bitmap do
        begin
        height:=tape.TapeType.width;
        width:=pic.graphic.Width*height div pic.Graphic.height;
        Canvas.stretchDraw(rect(0,0,width,height),pic.Graphic);
//        tape.image.Picture.Bitmap.savetofile('testtapestretch.bmp'); //debugging
        end;
      pic.free;
    end;
  end;
 UpdatePreviewExecute(self);
 tape.image.Invalidate;
end;

procedure TForm1.LoadRTFExecute(Sender: TObject);
var fs: TFileStream;
begin
 with opendialog1 do
  begin
  InitialDir:=WorkDir;
  DefaultExt:='.rtf';
   if execute then
     begin
       fs:=TFileStream.Create(filename,fmOpenRead);
       tape.rtf.LoadRichText(fs);
       fs.free
     end;
  end;
end;

procedure TForm1.MenuItem10Click(Sender: TObject);
begin
  togglebox2.Checked:=menuitem10.Checked;
end;

procedure TForm1.MenuItem28Click(Sender: TObject);
begin
  Timer1.enabled:=MenuItem28.checked;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
var
  FileVerInfo: TFileVersionInfo;
  s: String;
  p: integer;
begin
  FileVerInfo := TFileVersionInfo.Create(nil);
  FileVerInfo.ReadFileInfo;
  s:=FileVerInfo.VersionStrings[3];
  p:=pos('=',s,1)+1;
  showmessage('ptouchGUI Version: ' + Copy(s,p,100)); // 100 ist zu lang, wird automatisch gekürzt
  FileVerInfo.Free;
end;

procedure TForm1.MenuItem47Click(Sender: TObject);
begin
 Form2.Show;
 Form2.PageControl1.ActivePageIndex:=2;
 BPTPrinter.ShowVHSI;
end;

procedure TForm1.MenuItem8Click(Sender: TObject);
begin
  Scrollbox2.visible:=MenuItem8.checked;
end;

procedure TForm1.MenuItem9Click(Sender: TObject);
begin
  togglebox1.Checked:= menuitem9.Checked;
end;

procedure TForm1.Panel1Click(Sender: TObject);
begin
  BPTPrinter.ShowInfo;
end;

procedure TForm1.PrintBatchExecute(Sender: TObject);
begin
  BPTPrinter.PrintToFile:=checkbox2.checked;
  BPTPrinter.padvalue:=UpDown3.position;
  BPTPrinter.PrintCutmark:=checkbox4.checked;
  BPTPrinter.PrintBatchedFiles;
end;

procedure TForm1.CreateTestGraphicCustomwidthExecute(Sender: TObject);
var s: string;
    n: integer;
begin
  s:=InputBox('TestGrafik', 'Gewünschte Breite in Pixeln (16-128)', inttostr(Tape.TapeType.width));
    try n:=strtoint(s);
    except showmessage('Eingabe ungültig, Zahl erforderlich!');
    end;
  if (n<16) or (n>128) then begin showmessage('Wert muß zwischen 16 und 128 liegen'); exit; end;
  ComputeTestGraphic(n);
end;

procedure TForm1.CreateTestGraphicExecute(Sender: TObject);
begin
 ComputeTestGraphic(Tape.TapeType.width);
end;


procedure TForm1.ComputeTestGraphic(testwidth:integer);
var bm1,bm2:TBitmap;
     w, i: integer;
     fn_bm, fn_png: String;
begin
  bm1:=TBitmap.create;
  bm1.PixelFormat:=pf8bit;
  bm1.height:=128; //Tape.TapeType.reportedwidth;
  w:=bm1.height-1;
  bm1.width:=280;
  bm1.canvas.brush.color:=clwhite;
  bm1.canvas.brush.style:=bssolid;
  bm1.canvas.FillRect(rect(0,0,bm1.Width, bm1.height));
  bm1.Canvas.pen.Color:=clBlack;
  bm1.canvas.pen.Style:=pssolid;
  bm1.canvas.pen.Width:=1;
  bm1.Canvas.line(0,0,w*2+2,w);    //Diagonale
  bm1.Canvas.line(0,0,0,w);      //vorne vertikal
  bm1.Canvas.line(0,testwidth-1,w*2+2,testwidth-1);  //unten horizontal
  bm1.canvas.Font.Height:=10;
  bm1.canvas.Pen.EndCap:=pecFlat;
  for i:=0 to 32 do
    begin
      if i < 4
        then begin
               bm1.Canvas.Line(i*4*2,0,i*4*2,i*4)
             end
        else if i mod 4 = 0
               then begin
                      bm1.Canvas.Line(i*4*2,0,i*4*2,i*4);
                      bm1.canvas.TextOut(i*4*2+1,0,inttostr(i*4));
                    end
               else bm1.Canvas.Line(i*4*2,16,i*4*2,i*4);
    end;
  bm2:=Tbitmap.create;
  bm2.PixelFormat:=bm1.PixelFormat;
  bm2.Width:=bm1.width;
  bm2.Height:=testwidth;  //Tape.TapeType.width;
  bm2.canvas.Draw(0,0,bm1);
  bm1.free;

  fn_bm:=TempDir +'tmp.bmp';
  //fn_png:=ResourceDir+'TestGraphic128.png';        /128er testgrafik als standardausdruck entbehrlich
  //bm1.SaveToFile(fn_bm);
  //BPTPrinter.ConvertGraphicToPNGmono(fn_bm,fn_png);
  //DeleteFile(fn_bm);
  fn_png:=ResourceDir+'TestGraphic' + inttostr(bm2.height)+'.png';
  bm2.SaveToFile(fn_bm);
  BPTPrinter.ConvertGraphicToPNGmono(fn_bm,fn_png);
  DeleteFile(fn_bm);
  showmessage('Datei gespeichert unter: ' + fn_png);

  //tape.image.Picture.bitmap.Height:=testwidth;//Tape.TapeType.width;  //Anzeige im Fenster ausgeschaltet
  //tape.image.Picture.Bitmap.Assign(bm2);
  //tape.image.Invalidate;
  //tape.TapeUsedLength_px:=bm2.width;
  //radiogroup1.ItemIndex:=3;
  //UpdatePreviewExecute(self);
  //tape.tapemode:=tmImage;

  bm2.free;
end;

procedure TForm1.ReadHistoryFromFileExecute(Sender: TObject);
var i,c:integer;
begin
  with Tinifile.create(ChangeFileExt(Paramstr(0),'.ini')) do
    begin
      c:=ReadInteger('History','Count',0);
      if c>0 then
        for i:=1 to c do
          Form3.ListBox1.items.add(ReadString('History','Item_'+ inttostr(i),''));
      free;
    end;
end;

procedure TForm1.ReadInifileExecute(Sender: TObject);
var fs:TFilestream;
begin
  with Tinifile.create(form2.ApplicationIniFilename) do
    begin
    tape.tapefont.Name:=readstring('Tape','Fontname','');
    BPTPrinter.FN_Imagemagick:=ReadString('Printer','imagemagick','');
    BPTPrinter.FN_Ptouch_Print:=ReadString('Printer','Ptouch_Print', '');
    checkbox3.checked:=ReadBool('Printer','PrinttoBatch', true);
    checkbox2.checked:=ReadBool('Printer','PrinttoFile', false);
    checkbox4.checked:=ReadBool('Printer','PrintCutmark', true);
    updown3.Position:=Readinteger('Printer','pad', 30);
    Menuitem8.checked:=readbool('General','PrintPreview',true);
    Menuitem9.checked:=readbool('General','AutoTapeRecognition',true);
    Menuitem10.checked:=readbool('General','AutoLength',true);
    menuitem28.Checked:=readbool('General','AutoUpdate',true);
    free;
    end;

  ReadHistoryFromFileExecute(self);

  //load Edit
  if FileExists(ExtractFilePath(ParamStr(0))+'tapeedit.txt') then
    begin
    fs:=TFileStream.create(ExtractFilePath(ParamStr(0))+'tapeedit.txt', fmOpenRead);
    tape.edit.text:=fs.ReadAnsiString;
    fs.free;
    end;
  tape.EditChange(self);

  //load memo
  if FileExists(ExtractFilePath(ParamStr(0))+'tapememo.txt') then
    begin
    tape.memo.lines.LoadFromFile(ExtractFilePath(ParamStr(0))+'tapememo.txt');
    tape.MemoChange(self);
    end;

  //load RTF
  if FileExists(ExtractFilePath(ParamStr(0))+'tapertf.rtf') then
    begin
    fs:=TFileStream.create(ExtractFilePath(ParamStr(0))+'tapertf.rtf', fmOpenRead);
    tape.rtf.LoadRichText(fs);
    fs.free;
    end;
end;

procedure TForm1.WriteInifileExecute(Sender: TObject);
var fs:TFilestream;
begin
//  tape.SavePrinterConfig('2420pc.ini');
  with Tinifile.create(ChangeFileExt(Paramstr(0),'.ini')) do
    begin
    Writestring('Tape','Fontname',tape.tapefont.Name);
    WriteBool('Printer','PrinttoBatch', checkbox3.checked);
    WriteBool('Printer','PrinttoFile', checkbox2.checked);
    WriteBool('Printer','PrintCutmark', checkbox4.checked);
    Writeinteger('Printer','pad', updown3.Position);
    Writebool('General','AutoUpdate',timer1.enabled);
    Writebool('General','PrintPreview',Menuitem8.checked);
    Writebool('General','AutoTapeRecognition',Menuitem9.checked);
    Writebool('General','AutoLength',Menuitem10.checked);
    free;
    end;

  //save Edit
  fs:=TFileStream.create(ExtractFilePath(ParamStr(0))+'tapeedit.txt', fmcreate);
  fs.WriteAnsiString(tape.edit.text);
  fs.free;

  //save memo
  tape.memo.lines.SaveToFile(ExtractFilePath(ParamStr(0))+'tapememo.txt');

  //save RTF
  fs:=TFileStream.create(ExtractFilePath(ParamStr(0))+'tapertf.rtf', fmcreate);
  tape.rtf.SaveRichText(fs);
  fs.free;
end;


procedure TForm1.PrintExecute(Sender: TObject);
begin
  BPTPrinter.PrintToFile:=checkbox2.checked;
  BPTPrinter.PrintToBatch:=checkbox3.checked;
  tape.UpdateBitmap;
  BPTPrinter.Print(tape.bm);
  if MenuItem40.checked then WriteTextToHistoryExecute(self);
end;

procedure TForm1.CreateTestTextExecute(Sender: TObject);
begin
  tape.edit.text:=testtext;
  Application.ProcessMessages;
  //PrintExecute(self);  //better manual printing
end;

procedure TForm1.RadioGroup1SelectionChanged(Sender: TObject);
begin
  case radiogroup1.ItemIndex of
    0: tape.tapemode:=tmSingle;
    1: tape.tapemode:=tmMulti;
    2: tape.tapemode:=tmRTF;
    3: tape.tapemode:=tmImage;
  end;
  UpdatePreviewExecute(self);
end;



procedure TForm1.MenuItem42Click(Sender: TObject);
begin
  BPTPrinter.ShowHelp;
end;

procedure TForm1.SaveGraphicTemplateExecute(Sender: TObject);
var png: TPortableNetworkGraphic;
begin
  png:=TPortableNetworkGraphic.create;
  with png do
   begin
   PixelFormat:=pf1bit;
   Monochrome:=true;
   height:=tape.TapeType.width;
   width:=tape.PrinterType.maxlength_px;
   canvas.brush.color:=clwhite;
   canvas.brush.Style:=bsSolid;
   canvas.Rectangle(0,0,width,height);
   savetofile(WorkDir + 'Template_'+tape.TapeType.name+'.png');
   free;
   end;
end;

procedure TForm1.SaveRTFExecute(Sender: TObject);
var fs: TFileStream;
begin
 with savedialog1 do
  begin
   InitialDir:=WorkDir;
   DefaultExt:='.rtf';
   if execute then
     begin
       fs:=TFileStream.Create(filename,fmcreate);
       tape.rtf.SaveRichText(fs);
       fs.free
     end;
  end;
end;

procedure TForm1.ShowHistoryExecute(Sender: TObject);
begin
  Form3.visible:=true;
  Menuitem52.checked:=true;
end;

procedure TForm1.ToggleBox1Change(Sender: TObject);
begin
  with ToggleBox1 do
   if checked
     then begin
            caption := 'Auto';
            state:=cbChecked;
            ComboBox1.itemindex:=tape.TapeType.index;
            combobox1.Enabled:=False;
            end
     else begin
            caption := 'Auswahl:';
            state := cbUnchecked;
            combobox1.Enabled:=True;
          end;
   menuitem9.Checked:=togglebox1.checked;
end;

procedure TForm1.ToggleBox2Change(Sender: TObject);
begin
  with ToggleBox2 do
   if checked
     then begin
            caption := 'Auto';
            state:=cbChecked;
            tape.tapeUseCustomLength:=false;
            end
     else begin
            caption := 'Auswahl:';
            state := cbUnchecked;
            Edit2.Enabled:=True;
            tape.tapeUseCustomLength:=true;
          end;
  menuitem10.Checked:=togglebox2.Checked;
  UpdatePreviewExecute(self);
end;

procedure TForm1.ToggleBox3Click(Sender: TObject);
begin
  tape.SetTapeFontStyle(fsBold,ToggleBox3.checked);
  UpdatePreviewExecute(self);
end;

procedure TForm1.ToggleBox4Click(Sender: TObject);
begin
  tape.SetTapeFontStyle(fsItalic,ToggleBox4.checked);
  UpdatePreviewExecute(self);
end;

procedure TForm1.ToggleBox5Click(Sender: TObject);
begin
  tape.SetTapeFontStyle(fsUnderline,ToggleBox5.checked);
  UpdatePreviewExecute(self);
end;

procedure TForm1.ToggleHistoryExecute(Sender: TObject);
begin
  if form3.Visible then HideHistoryExecute(self) else ShowHistoryExecute(self);
end;

procedure TForm1.UpdateStatusPanelExecute(Sender: TObject);
var
  dir: String;
  sl: TStringList;
  i: Integer;
begin
  sl:=TStringlist.create;
  for i:=0 to 5 do
    begin
      sl.Clear;
      dir := IncludeTrailingPathDelimiter(WorkDir)+ tapetypes[i].name;
      FindAllFiles(sl,dir,'*.png',false);
      statusbar1.Panels[i*2 +7].Text:= inttostr(sl.count);
    end;
  sl.free;
  StatusBar1.Panels[1].Text:= Combobox1.Text;
  StatusBar1.Panels[3].Text:= Edit2.text;
  StatusBar1.Panels[19].Text:= FormatDateTime('dd.mm.yy hh.nn',now);
end;

procedure TForm1.UpdateTapeLengthExecute(Sender: TObject);
begin
  Edit2.text:=inttostr(tape.TapeUsedLength_mm);
end;

procedure TForm1.UpDown1Click(Sender: TObject; Button: TUDBtnType);
var cl:integer;
begin
  cl:=tape.mm2px(UpDown1.Position);
  tape.tapeCustomLength_px := cl;
  tape.rtfPanel.width:=cl;
  if UpDown1.Position >= tape.PrinterType.maxlength_mm
    then begin
         Groupbox2.Color:=clred;
         end
    else begin
         Groupbox2.Color:=clDefault;
         end;
  UpdatePreviewExecute(self);
end;


procedure TForm1.UpDown2Click(Sender: TObject; Button: TUDBtnType);
begin
  case tape.tapemode of
    tmSingle, tmMulti: tape.Fontsizefactor:=UpDown2.Position;
    tmRTF:    tape.rtf.ZoomFactor:=UpDown2.Position / 100;
  end;
  UpdatePreviewExecute(self);
  UpdateTapeLengthExecute(self);
end;


procedure TForm1.WriteHistoryToFileExecute(Sender: TObject);
var
  i: Integer;
begin
  with Tinifile.create(ChangeFileExt(Paramstr(0),'.ini')) do
    begin
      EraseSection('History');
      WriteInteger('History','Count',Form3.ListBox1.items.count);
      for i:=1 to Form3.Listbox1.items.count do
         if Form3.listbox1.Items[i-1]<>'' then  WriteString('History','Item_'+ inttostr(i),Form3.ListBox1.items[i-1]);
      free;
    end;
end;

procedure TForm1.UpdateAllExecute(Sender: TObject);
begin
  UpdateTapeTypeExecute(self);
  UpdatePreviewExecute(self);
  UpdatePanelSizeExecute(self);
  UpdateStatusPanelExecute(self);
end;

procedure TForm1.UpdatePanelSizeExecute(Sender: TObject);
begin
  Scrollbox2.visible:=menuitem8.checked;
  self.AutoSize:=false;
  self.AutoSize:=true;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  UpdateAllExecute(self);
end;

procedure TForm1.UpdatePreviewExecute(Sender: TObject);
begin
  tape.UpdateBitmap;
  image1.Picture.bitmap.assign(tape.bm);
  image1.Width:=image1.picture.bitmap.width;
  image1.height:=image1.picture.Bitmap.height;
  image1.invalidate;

  if fsBold in tape.tapefont.Style then togglebox3.checked:=true else togglebox3.checked:=false;
  if fsItalic in tape.tapefont.Style then togglebox4.checked:=true else togglebox4.checked:=false;

  LabeledEdit2.text:=Tape.tapefont.Name;
  if tape.TapeUsedLength_px > tape.printertype.maxlength_px
    then begin
           StaticText2.Show;
           Groupbox2.Color:=clred;
         end
    else begin
           StaticText2.hide;
           Groupbox2.Color:=clDefault;
         end;
  if not tape.tapeUseCustomLength then UpdateTapeLengthExecute(self);
end;

procedure TForm1.UpdateTapeTypeExecute(Sender: TObject);
var tti: integer;
begin
  tti:=BPTPrinter.GetTapetypeIndexFromPrinter;
  if Togglebox1.Checked and (tti>-1)
    then begin
           tape.TapeType:=tapetypes[tti];
           combobox1.ItemIndex:=tape.TapeType.index;
         end
    else tape.TapeType:=tapetypes[combobox1.itemindex];

  if togglebox2.checked
  then  begin
          UpdateTapeLengthExecute(self);
          Edit2.Enabled:=False;
        end;
  UpdatePreviewExecute(self);
end;

procedure TForm1.WriteTextToHistoryExecute(Sender: TObject);
begin
  case tape.tapemode of
    tmSingle: Form3.listbox1.items.add(tape.edit.text);
    tmMulti:  Form3.listbox1.items.AddStrings(tape.memo.lines);
    tmRTF:    Form3.listbox1.items.AddStrings(tape.rtf.Lines);
  end;
  WriteHistoryToFileExecute(self);
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  UpdatePreviewExecute(self);
  Edit2.text:=inttostr(tape.TapeUsedLength_mm);
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  WriteInifileExecute(self);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  UpdatePreviewExecute(self);
end;

procedure TForm1.CalculatePixelWidthExecute(Sender: TObject);
var w,i, step, pw: integer;
    bm1:TBitmap;
begin
  pw := 1 shl 7 ;
  for i:=6 downto 0 do
    begin
     step:= 1 shl i;
//     printtestbild
     bm1:=TBitmap.create;
     bm1.PixelFormat:=pf8bit;
     bm1.height:=pw;
     w:=bm1.height-1;
     bm1.width:=40;
     bm1.canvas.brush.color:=clwhite;
     bm1.canvas.brush.style:=bssolid;
     bm1.canvas.FillRect(rect(0,0,bm1.Width, bm1.height));
     bm1.Canvas.pen.Color:=clBlack;
     bm1.canvas.pen.Style:=pssolid;
     bm1.canvas.pen.Width:=1;
     bm1.canvas.Pen.EndCap:=pecFlat;
     bm1.Canvas.line(0,0,bm1.width,0);      //oben horizontal
     bm1.Canvas.line(0,w,bm1.width-1,w);  //unten horizontal
     bm1.canvas.Font.Height:=10;
     bm1.canvas.TextOut(0,(w-bm1.canvas.Font.Height) div 2,inttostr(pw));
     bm1.SaveToFile(TempDir+ 'TestGraphicBars' + inttostr(bm1.height)+'_'+inttostr(i) +'.bmp');
     BPTPrinter.Print(bm1);
     bm1.free;
     case MessageDlg('Ausdruck OK? (OK: komplett, auch wenn sehr klein; nicht OK: Kein Ausdruck oder inkomplett)',mtConfirmation,[mbYes,mbNo, mbAbort],0) of
       mrYes: pw:=pw+step;
       mrNo:  pw:=pw-step;
       mrAbort: exit;
     end;
    end;
  pw:= round(pw div 4) * 4 ;
  showmessage(inttostr(pw));
end;

procedure TForm1.ClearBatchAllExecute(Sender: TObject);
begin
  BPTPrinter.ClearTapeAll;
end;

procedure TForm1.ClearBatchTapeExecute(Sender: TObject);
begin
  BPTPrinter.ClearTape(tape.TapeType.name);
end;

procedure TForm1.HideHistoryExecute(Sender: TObject);
begin
  Form3.visible:=false;
  Menuitem52.checked:=false;
end;

procedure TForm1.MenuItem11Click(Sender: TObject);
begin
  menuitem6.visible:=MenuItem11.checked;;
end;

procedure TForm1.MenuItem52Click(Sender: TObject);
begin
  UpdatePreviewExecute(self);
end;

procedure TForm1.MenuItem54Click(Sender: TObject);
begin
  Form1.hide;
  Form2.show;
end;


procedure TForm1.SelectFontExecute(Sender: TObject);
begin
  with FontDialog1 do
    begin
      PreviewText:= testtext;// tape.Edit.text;
      if execute then
      begin
        case tape.tapemode of
          tmSingle, tmMulti: tape.tapefont:=font;
          tmRTF:             tape.rtf.Font:=font;
        end;
      //if fsBold in font.Style then togglebox3.checked:=true else togglebox3.checked:=false;
      //if fsItalic in font.Style then togglebox4.checked:=true else togglebox4.checked:=false;
//      if fsUnderline in font.Style then togglebox5.checked:=true else togglebox5.checked:=false;
      end;
    end;
  UpdatePreviewExecute(self);
end;


end.

