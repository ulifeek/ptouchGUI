unit unitbrotherpt;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, process, ExtCtrls, Graphics, unittape,
  StdCtrls, Controls, DateUtils, FileUtil,Forms, LCLType, Dialogs
  ;

type

  { TBrotherPTPrinter }

  TBrotherPTPrinter = class(TPanel)
  private
    FDN_BatchOutput: string;
    Fpadvalue: integer;
    FPrintCutmark: boolean;
    FPrintToBatch: boolean;
    FPrintToFile: boolean;
    PrinterMessages: TStringlist;
    Listbox1:TListbox;
    FFN_Imagemagick: string;
    FFN_PtouchInput: String;
    FFN_PNGpf8bit: string;
    FFN_PtouchOutput: string;
    FFN_Ptouch_Print: string;
    bm_print: TBitmap;
    procedure SetDN_BatchOutput(AValue: string);
    procedure SetFN_Imagemagick(AValue: string);
    procedure SetFN_PtouchInput(AValue: String);
    procedure SetFN_PNGpf8bit(AValue: string);
    procedure SetFN_PtouchOutput(AValue: string);
    procedure SetFN_Ptouch_Print(AValue: string);
    procedure Setpadvalue(AValue: integer);
    procedure SetPrintCutmark(AValue: boolean);
    procedure SetPrintToBatch(AValue: boolean);
    procedure SetPrintToFile(AValue: boolean);
    function GetUniqueFN: string;
  public
    helper_sl:TStringlist;
    constructor create(own:TComponent); override;
    destructor destroy; override;
    function GetTapetypeIndexFromPrinter: integer;
    function GetTapeWidthFromPrinter: integer;
    function GetPrinternameFromPrinter: string;
    function Print(bm: Tbitmap): integer; //0=oK, -1=error
    function PrintBatchedFiles: integer;
    function GetHelp(sl:TStringlist): integer;
    function GetSupported(sl:TStringlist): integer;
    function GetVersion(sl:TStringlist): integer;
    function GetInfo(sl:TStringlist): integer;
    function GetPrinterMessages(sl:TStringlist): integer;   // gibt anzahl der Messages zurück
    function IsPrinterConnected: Boolean;
    function ConvertGraphicToPNGmono(fni,fno:String):integer;
    procedure ShowVersion;
    procedure ShowHelp;
    procedure ShowSupported;
    procedure ShowInfo;
    procedure ShowVHSI;
    procedure showtext(sl:TStringlist);
    procedure ClearTape(tapename:string);
    procedure ClearTapeAll;
    property FN_Imagemagick: string read FFN_Imagemagick write SetFN_Imagemagick;
    property FN_Ptouch_Print: string read FFN_Ptouch_Print write SetFN_Ptouch_Print;
    property FN_PtouchInput: String read FFN_PtouchInput write SetFN_PtouchInput; //pf1bit
    property FN_PNGpf8bit: string read FFN_PNGpf8bit write SetFN_PNGpf8bit;
    property FN_PtouchOutput: string read FFN_PtouchOutput write SetFN_PtouchOutput;
    property PrintToFile: boolean read FPrintToFile write SetPrintToFile;
    property PrintToBatch: boolean read FPrintToBatch write SetPrintToBatch;
    property PrintCutmark: boolean read FPrintCutmark write SetPrintCutmark;
    property padvalue: integer read Fpadvalue write Setpadvalue;

    end;

implementation

uses unitmain;

procedure TBrotherPTPrinter.SetFN_Imagemagick(AValue: string);
begin
  if FFN_Imagemagick=AValue then Exit;
  FFN_Imagemagick:=AValue;
end;

procedure TBrotherPTPrinter.SetDN_BatchOutput(AValue: string);
begin
  if FDN_BatchOutput=AValue then Exit;
  FDN_BatchOutput:=AValue;
end;

procedure TBrotherPTPrinter.SetFN_PtouchInput(AValue: String);
begin
  if FFN_PtouchInput=AValue then Exit;
  FFN_PtouchInput:=AValue;
end;

procedure TBrotherPTPrinter.SetFN_PNGpf8bit(AValue: string);
begin
  if FFN_PNGpf8bit=AValue then Exit;
  FFN_PNGpf8bit:=AValue;
end;

procedure TBrotherPTPrinter.SetFN_PtouchOutput(AValue: string);
begin
  if FFN_PtouchOutput=AValue then Exit;
  FFN_PtouchOutput:=AValue;
end;

procedure TBrotherPTPrinter.SetFN_Ptouch_Print(AValue: string);
begin
  if FFN_Ptouch_Print=AValue then Exit;
  FFN_Ptouch_Print:=AValue;
end;

procedure TBrotherPTPrinter.Setpadvalue(AValue: integer);
begin
  if Fpadvalue=AValue then Exit;
  Fpadvalue:=AValue;
end;

procedure TBrotherPTPrinter.SetPrintCutmark(AValue: boolean);
begin
  if FPrintCutmark=AValue then Exit;
  FPrintCutmark:=AValue;
end;

procedure TBrotherPTPrinter.SetPrintToBatch(AValue: boolean);
begin
  if FPrintToBatch=AValue then Exit;
  FPrintToBatch:=AValue;
end;

procedure TBrotherPTPrinter.SetPrintToFile(AValue: boolean);
begin
  if FPrintToFile=AValue then Exit;
  FPrintToFile:=AValue;
end;

function TBrotherPTPrinter.GetUniqueFN: string;
var dir, fn: string;
begin
  dir := IncludeTrailingPathDelimiter(WorkDir)+ TForm1(owner).Tape.TapeType.name;
  if not DirectoryExists(dir) then ForceDirectories(dir);
  fn:=FormatDateTime('yyyymmdd_hhnnss',now,[])+'.png';
  result:=IncludeTrailingPathDelimiter(dir)+fn;
end;

constructor TBrotherPTPrinter.create(own: TComponent);
begin
  inherited create(own);
  self.height:=200;
  self.width:=1000;
  FN_PNGpf8bit:=  TempDir + 'Raw.png';
  FN_PtouchInput:= TempDir + 'Input.png';
  FN_PtouchOutput:=  WorkDir + 'print_output.png';
  PrinterMessages:=TStringlist.create;
  helper_sl:=TStringlist.create;
  Listbox1:=TListbox.Create(self);
  Listbox1.parent:=self;
  Listbox1.align := alClient;
  bm_print:=TBitmap.create;
  padvalue:=10;
end;

destructor TBrotherPTPrinter.destroy;
begin
  PrinterMessages.free;
  helper_sl.free;
  bm_print.free;
  inherited destroy;
end;

function TBrotherPTPrinter.Print(bm: Tbitmap): integer;
var png: TPortableNetworkGraphic;
    var FN_Temp:string;
begin
  bm_print.assign(bm);
  //bm_print.savetofile('prntest.bmp');  //debugging
  png:=TPortableNetworkGraphic.create();
  png.PixelFormat:=pf8bit;
  png.Assign(bm);
  png.SaveToFile(FN_PNGpf8bit);

  if PrintToBatch = true then FN_Temp:=GetUniqueFN else FN_Temp:=FN_PtouchInput;

//  workaround pf1bit mit imagemagick Lazarus/Gtk2 unterstützen pf1bit nicht
  ConvertGraphicToPNGmono(FN_PNGpf8bit,FN_Temp);
// ENDE workaround

//  image1.Picture.PNG.SaveToFile(printfilename); //debugging
  if PrintToBatch = true then exit;

with TProcess.create(self) do
  begin
    executable:=FN_Ptouch_Print;
    with Parameters do
    begin
      Clear;
      add('--image');
      add(FN_Temp); //(FN_PtouchInput);
      if PrintToFile = true
        then begin
             add('--writepng');
             add(FN_PtouchOutput);
             end;
    end;
    options:=[poWaitOnExit,poUsePipes];
    execute;
    PrinterMessages.LoadFromStream(Output);
    if Printermessages.count=0 then PrinterMessages.add('Ausdruck ohne Fehler erfolgt.');
    Listbox1.items.Assign(PrinterMessages);
    result:=ExitCode;
    free;
  end;
end;

function TBrotherPTPrinter.PrintBatchedFiles: integer;
var dir: string;
  i: Integer;
begin
  dir := IncludeTrailingPathDelimiter(WorkDir)+ TForm1(owner).Tape.TapeType.name;
  helper_sl.Clear;
  Findallfiles(helper_sl,dir,'*.png',false);

  with TProcess.create(self) do
    begin
      executable:=FN_Ptouch_Print;
      with Parameters do
      begin
        Clear;
        for i:=0 to helper_sl.count-1 do
          begin
            add('--image');
            add(helper_sl[i]);
            if i=helper_sl.count-1 then break;
            add('--pad');
            add(inttostr(padvalue div 2));
            if PrintCutmark = true then add('--cutmark');
            add('--pad');
            add(inttostr(padvalue div 2));
          end;

        if PrintToFile = true
          then begin
               add('--writepng');
               add(FN_PtouchOutput);
               end;
      end;
      options:=[poWaitOnExit,poUsePipes];
      execute;
      PrinterMessages.LoadFromStream(Output);
      if Printermessages.count=0 then PrinterMessages.add('Ausdruck ohne Fehler erfolgt.');
      Listbox1.items.Assign(PrinterMessages);
      result:=ExitCode;
      if exitcode=0 then
        if PrintToFile = false then
          if Application.MessageBox('Dateien aus Warteschlange löschen?','Ausdruck OK?',MB_YESNO)=IDYES then
          for i:=0 to helper_sl.count-1 do DeleteFile(helper_sl[i]);
      helper_sl.clear;
      free;
    end;

end;

function TBrotherPTPrinter.GetHelp(sl: TStringlist): integer;
begin
  with TProcess.create(self) do
  begin
    executable:=FN_Ptouch_Print;
    Parameters.add('--help');
    options:=[poWaitOnExit,poUsePipes];
    execute;
    sl.LoadFromStream(output);
    result:=ExitCode;
    free;
  end;
end;

function TBrotherPTPrinter.GetSupported(sl: TStringlist): integer;
begin
  with TProcess.create(self) do
  begin
    executable:=FN_Ptouch_Print;
    Parameters.add('--list-supported');
    options:=[poWaitOnExit,poUsePipes];
    execute;
    sl.LoadFromStream(output);
    result:=ExitCode;
    free;
  end;
end;

function TBrotherPTPrinter.GetVersion(sl: TStringlist): integer;
begin
  with TProcess.create(self) do
  begin
    executable:=FN_Ptouch_Print;
    Parameters.add('--version');
    options:=[poWaitOnExit,poUsePipes];
    execute;
    sl.LoadFromStream(output);
    result:=ExitCode;
    free;
  end;
end;

function TBrotherPTPrinter.GetInfo(sl: TStringlist): integer;
var s: string;
begin
  with TProcess.create(self) do
  begin
    executable:=FN_Ptouch_Print;
    Parameters.add('--info');
    options:=[poWaitOnExit,poUsePipes];
    execute;
    sl.LoadFromStream(stderr);  //liest printerinfo
    s:=sl[0];
    sl.LoadFromStream(output);
    sl.Insert(0,s);
    result:=exitcode;
    free;
  end;
end;

function TBrotherPTPrinter.GetPrinterMessages(sl: TStringlist): integer;
begin
  try
    sl.Assign(PrinterMessages);
  finally
    result:=PrinterMessages.Count;
  end;
end;

function TBrotherPTPrinter.IsPrinterConnected: Boolean;
var s: String;
begin
  s:=GetPrinternameFromPrinter;
  if s='No' then result:=false else result:=true;
end;

function TBrotherPTPrinter.ConvertGraphicToPNGmono(fni, fno: String): integer;
begin
 with TProcess.create(self) do
   begin
     executable:=FN_Imagemagick;
     Parameters.add(fni);
     Parameters.add('-threshold');
     Parameters.add('50%');
     Parameters.add(fno);
     options:=[poWaitOnExit];
     Execute;
     result:=ExitCode;
     free;
   end;

end;

procedure TBrotherPTPrinter.ShowVersion;
begin
  GetVersion(helper_sl);
  Listbox1.items.assign(helper_sl);
end;

procedure TBrotherPTPrinter.ShowHelp;
begin
  GetHelp(helper_sl);
  Listbox1.items.assign(helper_sl);
end;

procedure TBrotherPTPrinter.ShowSupported;
begin
  GetSupported(helper_sl);
  Listbox1.items.assign(helper_sl);
end;

procedure TBrotherPTPrinter.ShowInfo;
begin
  GetInfo(helper_sl);
  Listbox1.items.assign(helper_sl);
end;

procedure TBrotherPTPrinter.ShowVHSI;
begin
 GetVersion(helper_sl);
 Listbox1.items.assign(helper_sl);
 Listbox1.items.add('-----------------------------------------------------');
 GetHelp(helper_sl);
 Listbox1.items.AddStrings(helper_sl);
 Listbox1.items.add('-----------------------------------------------------');
 GetInfo(helper_sl);
 Listbox1.items.AddStrings(helper_sl);
 Listbox1.items.add('-----------------------------------------------------');
 GetSupported(helper_sl);
 Listbox1.items.AddStrings(helper_sl);
end;

procedure TBrotherPTPrinter.showtext(sl: TStringlist);
begin
 Listbox1.items.assign(helper_sl);
end;

procedure TBrotherPTPrinter.ClearTape(tapename: string);
var i:integer;
begin
  if Application.MessageBox(pChar('Alle Dateien aus aktueller Warteschlange ('+tapename+') löschen?'),pChar('Alles gedruckt?'),MB_YESNO)=IDNO then exit;
  helper_sl.clear;
  FindAllFiles(helper_sl,IncludeTrailingPathDelimiter(WorkDir+tapename),'*.png',false);
  for i:=0 to helper_sl.count-1 do DeleteFile(helper_sl[i]);
end;

procedure TBrotherPTPrinter.ClearTapeAll;
var i:integer;
begin
  if Application.MessageBox('Alle Dateien aus allen Warteschlange löschen?','Alles gedruck?',MB_YESNO)=IDNO then exit;
  helper_sl.clear;
  FindAllDirectories(helper_sl,WorkDir,true);
  for i:=0 to helper_sl.count-1 do DeleteDirectory(helper_sl[i],false);  //ratzeputz leer incl files
  ForceDirectories(TempDir);
end;

function TBrotherPTPrinter.GetTapetypeIndexFromPrinter: integer;
var sl:TStringlist;
      s: String;
      i, value: integer;
begin
 sl:=TStringList.create;
 result:=-1;
 if GetInfo(sl) = -1 then exit;  //fehler
 if sl.count > 0
    then for i:= 0 to sl.count-1 do
      if  Leftstr(sl[i],14)= 'media width = '
        then begin
             s:=copy(sl[i],15,5);
             s:=copy(s,0,length(s)-3);
             try value := strtoint(s);
                except value :=-1; exit;
                 end;
              break;
              end;
 case value of
   -1: result:=0;//tt3mm;
   6: result:=1;//tt6mm;
   9: result:=2;//tt9mm;
   12: result:=3;//tt12mm;
   18: result:=4;//tt18mm;
   24: result:=5;//tt24mm;
   32: result:=6;//tt32mm;
    else result :=-1;// tterror;
    end;
  sl.free;
end;

function TBrotherPTPrinter.GetTapeWidthFromPrinter: integer;
var sl:TStringlist;
       s: String;
       i, value: integer;
begin
  sl:=TStringList.create;
  result:=-1;
  if GetInfo(sl) = -1 then exit;  //fehler
  if sl.count > 0
     then for i:= 0 to sl.count-1 do
       if  Leftstr(sl[i],40)= 'maximum printing width for this tape is '
         then begin
              s:=copy(sl[i],41,5);
              s:=copy(s,0,length(s)-2);
              try value := strtoint(s);
                 except value :=-1; //exit;
                  end;
               break;
               end;
  result:=value;
end;

function TBrotherPTPrinter.GetPrinternameFromPrinter: string;
var sl:TStringlist;
       s: String;
       p: integer;
begin
  sl:=TStringList.create;
  result:='';
  if GetInfo(sl) = -1 then exit;  //fehler
//  sl.savetofile('sl.txt');      //debugging
  if sl.count > 0 then
    begin
      p:=pos(' ', sl[0],1);
      s:=copy(sl[0],0,p-1);
    end;
  result:=s;
end;

end.



