unit unittape;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls, graphics, math, Dialogs,StdCtrls,RichMemo, forms,controls, inifiles;

type
  TTapeType=record
    index: integer;
    name: string;
    width: integer; //px. selbst verwaltet
    widthPtp: integer; //px aus ptouch-print
    supported: boolean;
  end;

  TPrinterType=record
    name: string;
    dpi: integer;
    maxlength_mm: integer;
    maxlength_px:integer;
  end;

 TTapemode=(tmSingle,tmMulti,tmRTF,tmImage);
  { TTape }

  TTape= Class(TScrollbox)
    private
      FMemoLinecount: integer;
      FFontsizefactor: integer;
      FOnContentChanged: TNotifyEvent;
      FPrinterType: TPrinterType;
      FtapeCustomLength_px: integer;
      FTapeFont: TFont;
      FtapeUseCustomLength: boolean;
      FTapeUsedLength_px: integer;
      Ftapemode: TTapemode;
      FTapeType: TTapeType;
      function AdjustFontHeight(s: String; f:TFont; th {textheight}:integer): integer;
      function GetTextlength_px(s: String; f:TFont):integer;
      function GetTextlength_mm(s: String; f: TFont): integer;
      procedure SetFontsizefactor(AValue: integer);
      procedure SetOnContentChanged(AValue: TNotifyEvent);
      procedure SetPrinterType(AValue: TPrinterType);
      procedure SettapeCustomLength_px(AValue: integer);
      procedure Settapefont(AValue: TFont);
      procedure Settapemode(AValue: TTapemode);
      procedure SetTapeType(AValue: TTapeType);
      procedure SettapeUseCustomLength(AValue: boolean);
      procedure SetTapeUsedLength_px(AValue: integer);
      procedure RTFChange(Sender: TObject);
      procedure ImageChange(Sender: TObject);
    public
      Paintbox: TPaintbox;
      bm: TBitmap;
      edit: TEdit;
      memo: Tmemo;
      rtfPanel:TPanel;
      rtf:TRichMemo;
      image: Timage;
      procedure EditChange(Sender: TObject);
      procedure MemoChange(Sender: TObject);
      function px2mm(px:integer): integer;
      function mm2px(mm:integer): integer;
      constructor create(own:TComponent); override;
      destructor destroy; override;
      procedure UpdateBitmap;
      procedure UpdateTape;
      function TapeUsedLength_mm: integer;
      procedure CalculateTapeUsedlength;
      procedure SetTapeFontStyle(fs:TFontStyle; add: boolean);
      procedure LoadPrinterConfig(fn:string);
      property Fontsizefactor: integer read FFontsizefactor write SetFontsizefactor;
      property tapefont: TFont read Ftapefont write Settapefont;
      property TapeType: TTapeType read FTapeType write SetTapeType;
      property PrinterType: TPrinterType read FPrinterType write SetPrinterType;
      property tapemode: TTapemode read Ftapemode write Settapemode;
      property OnContentChanged: TNotifyEvent read FOnContentChanged write SetOnContentChanged;
      property TapeUsedLength_px: integer read FTapeUsedLength_px write SetTapeUsedLength_px;
      property tapeCustomLength_px: integer read FtapeCustomLength_px write SettapeCustomLength_px;
      property tapeUseCustomLength: boolean read FtapeUseCustomLength write SettapeUseCustomLength;
    end ;

const
  tapetypes: array [0..5] of TTapeType = (  (index:0;name:'3,5mm';width:20;widthPtp:20;supported:false),
                                            (index:1;name:'6mm';width:32;widthPtp:32;supported:true),
                                            (index:2;name:'9mm';width:48;widthPtp:52;supported:true),
                                            (index:3;name:'12mm';width:68;widthPtp:76;supported:true),
                                            (index:4;name:'18mm';width:112;widthPtp:120;supported:true),
                                            (index:5;name:'24mm';width:128;widthPtp:128;supported:true)
                                            //(index:6;name:'32mm';width:172;widthPtp:168;supported:false)
                                            );


  testtext='ÄÖÜQZqyjgµ';

implementation
uses unitmain;
{ TTape }

constructor TTape.create(own:TComponent);
begin
  inherited create(own);
  FMemoLinecount:=1;;

  self.BorderStyle:=bsSingle;
  self.AutoScroll:=true;
  self.BorderSpacing.Around:=5;
  self.borderwidth:=5;
  self.HorzScrollBar.visible:=true;
  self.VertScrollBar.visible:=false;
  self.AutoSize:=false;
  self.align:=altop;

  bm:=TBitmap.create;
  bm.PixelFormat:=pf8bit;

  edit:=TEdit.create(self);
  edit.parent:=self;
  edit.BorderSpacing.Around:=0;
  edit.autosize:=false;
  edit.BorderStyle:=bsNone;
  edit.OnChange:=@editchange;
  edit.BorderStyle:=bsNone;

  memo:=TMemo.create(self);
  memo.parent:=self;
  memo.BorderSpacing.Around:=0;
  memo.WordWrap:=false;
  memo.WantReturns:=true;
  memo.WantTabs:=true;
  memo.OnChange:=@memochange;
  memo.BorderStyle:=bsNone;

  rtfPanel:=TPanel.create(self);
  rtfPanel.Parent:=self;
  rtfPanel.BorderSpacing.Around:=0;
  rtfPanel.BorderStyle:=bsNone;
  rtf:=TRichMemo.create(rtfPanel);
  rtf.parent:=rtfPanel;
  rtf.OnChange:=@rtfchange;
  rtf.BorderStyle:=bsNone;

  image:=Timage.Create(self);
  image.parent:=self;
  image.BorderSpacing.Around:=0;
  image.picture.bitmap:=TBitmap.create;
  image.picture.bitmap.PixelFormat:=pf8bit;
  image.picture.bitmap.Width:=printertype.maxlength_px;
  image.picture.Bitmap.OnChange:=@Imagechange;

  Ftapefont:=TFont.Create;
  FFontsizefactor:=100;
  TapeType:=tapetypes[0];
  tapemode:=tmSingle;
  tapefont.assign(edit.Font);
end;

destructor TTape.destroy;
begin
  inherited destroy;
end;


function TTape.AdjustFontHeight(s: String; f: TFont; th {textheight}: integer):integer;
var IterationStep: integer;
begin
  if th=0 then begin result:=f.height; exit; end;
  bm.canvas.font.Assign(f);
  IterationStep:=th;
  repeat
  if bm.Canvas.GetTextHeight(s) > th
    then begin
         IterationStep:=-((abs(IterationStep)+1) div 2);
         end
    else begin
         IterationStep:=((abs(IterationStep)+1) div 2);
         end;
  bm.canvas.Font.height:=bm.canvas.Font.height+IterationStep;
  until abs(IterationStep)=1;
  result:= bm.canvas.Font.height * Fontsizefactor  div 100 -1;
end;

function TTape.GetTextlength_px(s: String; f: TFont): integer;
begin
  bm.canvas.Font:=f;
  result:=bm.canvas.TextWidth(s);
end;

function TTape.GetTextlength_mm(s: String; f: TFont): integer;
begin
  result:= px2mm(GetTextLength_px(s,f));
end;


procedure TTape.SetFontsizefactor(AValue: integer);
begin
  if FFontsizefactor=AValue then Exit;
  case  AValue of
    0..9 : FFontsizefactor:=10;
    10..100 : FFontsizefactor:=AValue;
    else FFontsizefactor:=100;
  end;
  UpdateTape;
end;

procedure TTape.SetOnContentChanged(AValue: TNotifyEvent);
begin
  if FOnContentChanged=AValue then Exit;
  FOnContentChanged:=AValue;
end;

procedure TTape.SetPrinterType(AValue: TPrinterType);
begin
  if     (FPrinterType.name = AValue.name)
     and (FPrinterType.maxlength_mm = AValue.maxlength_mm)
     and (FPrinterType.maxlength_px = AValue.maxlength_px)
     and (FPrinterType.dpi = AValue.dpi)
     then Exit;
  FPrinterType.name:=AValue.name;
  FPrinterType.maxlength_mm:=AValue.maxlength_mm;
  FPrinterType.maxlength_px:=AValue.maxlength_px;
  FPrinterType.dpi:=AValue.dpi;
  self.Width:=PrinterType.maxlength_px+2*self.borderwidth +2;
  edit.Width:=PrinterType.maxlength_px;
  memo.Width:=PrinterType.maxlength_px;
  rtfPanel.Width:=PrinterType.maxlength_px;
  rtf.Width:=PrinterType.maxlength_px;
  image.Width:=PrinterType.maxlength_px;
end;

procedure TTape.SettapeCustomLength_px(AValue: integer);
begin
  if FtapeCustomLength_px=AValue then Exit;
  if AValue > PrinterType.maxlength_px
    then FtapeCustomLength_px:=PrinterType.maxlength_px
    else FtapeCustomLength_px:=AValue;
  TapeUsedLength_px:=tapeCustomLength_px;
end;

procedure TTape.Settapefont(AValue: TFont);
begin
  if Ftapefont.IsEqual(aValue) then exit;
  Ftapefont.Assign(aValue);
  edit.font.assign(Ftapefont);
  memo.font.assign(Ftapefont);
  UpdateTape;
end;

procedure TTape.SetTapeFontStyle(fs: TFontStyle; add: boolean);
begin
  if add
    then Ftapefont.Style :=Ftapefont.style + [fs]    //add
    else Ftapefont.Style :=Ftapefont.style - [fs];   //remove
    case tapemode of
      tmSingle: edit.font.assign(Ftapefont);
      tmMulti: memo.font.assign(Ftapefont);
      tmRTF: rtf.SetTextAttributes(rtf.SelStart,rtf.SelLength,FTapeFont);
    end;
    UpdateTape;
end;


procedure TTape.LoadPrinterConfig(fn: string);
var i:integer;
    pt:TPrinterType;
    tapename: array[0..5] of string = ('3,5 mm','6 mm','9 mm','12 mm','18 mm','24 mm');
begin
if not FileExists(fn) then begin showmessage('Printer-Datei existiert nicht: '+fn); exit; end;
With Tinifile.create(fn) do
  begin
    with pt do
      begin
        name:=ReadString('Printer','Name','2420pc');
        dpi:=ReadInteger('Printer','DPI',180);
        maxlength_mm:=ReadInteger('Printer','MaxLength_mm',270);
        maxlength_px:=trunc(maxlength_mm * dpi / 25.4);
      end;
    SetPrinterType(pt);
    for i:=0  to 5 do
      begin
//        tapetypes[i].name:=ReadString('Tape_'+tapename[i],'Name', '');  //tapename bereits vorhanden und nich mehr  in ini gespeichert als value
        tapetypes[i].width:=ReadInteger('Tape_'+tapename[i],'Width', 0 );
        tapetypes[i].widthPtp:=ReadInteger('Tape_'+tapename[i],'widthPtp', 0 );
        tapetypes[i].supported:=ReadBool('Tape_'+tapename[i],'Supported', false);
      end;
    free;
  end;
end;

procedure TTape.SetTapeType(AValue: TTapeType);
begin
  if FTapeType.name=AValue.name then Exit;
  FTapeType:=AValue;
  self.Height:=TapeType.width + 2* self.BorderWidth + self.HorzScrollBar.Size;
  bm.Height:=TapeType.width;
  edit.Height:=TapeType.width;
  memo.Height:=TapeType.width;
  rtfPanel.Height:=TapeType.width;;
  rtf.Height:=TapeType.width;
  image.Height:=TapeType.width;
  image.picture.Bitmap.Height:=TapeType.width;
  UpdateTape;
end;

procedure TTape.SettapeUseCustomLength(AValue: boolean);
begin
  if FtapeUseCustomLength=AValue then Exit;
  FtapeUseCustomLength:=AValue;
end;

procedure TTape.SetTapeUsedLength_px(AValue: integer);
begin
  if FTapeUsedLength_px=AValue then Exit;
  if tapeUseCustomLength = true
    then FTapeUsedLength_px:=tapeCustomLength_px
    else FTapeUsedLength_px:=AValue;
end;

procedure TTape.UpdateBitmap;
begin
  Application.ProcessMessages;
  bm.Height:=tapetype.width;
  bm.width:=max(min(TapeUsedLength_px, printertype.maxlength_px),1); //zwischen 0 und maxheight
  bm.canvas.brush.color:=clwhite;
  bm.canvas.brush.style:=bssolid;
  bm.canvas.FillRect(rect(0,0,bm.Width, bm.height));
  case tapemode of
    tmSingle: edit.PaintTo(bm.canvas,0,0);
    tmMulti: memo.PaintTo(bm.canvas,0,0);
    tmRTF: rtfPanel.PaintTo(bm.canvas,0,0);
    tmImage: bm.canvas.draw(0,0,image.Picture.Bitmap);
  end;
end;

procedure TTape.UpdateTape;
begin
 edit.Hide;  memo.Hide; rtfpanel.Hide; image.hide;
   case tapemode of
    tmSingle: begin
                edit.show;
                edit.font.height:=AdjustFontHeight(testtext,edit.font,TapeType.width);
                CalculateTapeUsedlength;
              end;
    tmMulti:  begin
                memo.show;
                memo.font.height:= AdjustFontHeight(testtext, memo.font, TapeType.width div FMemoLineCount);
                memo.SetFocus;
                CalculateTapeUsedlength;
              end;
    tmRTF:    begin
                rtfPanel.show;
                rtf.SetFocus;
              end;
    tmImage:  begin
                image.show;
              end;
   end;
end;

procedure TTape.Settapemode(AValue: TTapemode);
begin
  if Ftapemode=AValue then Exit;
  Ftapemode:=AValue;
  UpdateTape;
end;


function TTape.TapeUsedLength_mm: integer;
begin
  result :=px2mm(TapeUsedLength_px);
end;

procedure TTape.CalculateTapeUsedlength;
var i, ml: integer;
begin
  case tapemode of
   tmsingle:  TapeUsedLength_px:=GetTextlength_px(edit.text,edit.Font);
   tmMulti:   begin
                ml:=0;
                for i:=0 to memo.Lines.Count-1 do
                  ml:=max(GetTextlength_px(memo.lines[i],memo.Font), ml);
                TapeUsedLength_px:=ml;
              end;
   tmImage:   TapeUsedLength_px:=image.picture.Graphic.width;
  end;
end;

procedure TTape.EditChange(Sender: TObject);
begin
  CalculateTapeUsedlength;
  if assigned(FOnContentChanged) then FOnContentChanged(self);
end;

procedure TTape.MemoChange(Sender: TObject);
begin
  if memo.lines.count <> FMemoLinecount
    then begin
           FMemoLinecount:=max(memo.Lines.Count,1);  //mindestens 1 Zeile für weitere Berechnungen fontheight
           UpdateTape;
         end;
  calculateTapeUsedlength;
  if assigned(FOnContentChanged) then FOnContentChanged(self);
end;

procedure TTape.RTFChange(Sender: TObject);
begin
if assigned(FOnContentChanged) then FOnContentChanged(self);
end;

procedure TTape.ImageChange(Sender: TObject);
begin
if assigned(FOnContentChanged) then FOnContentChanged(self);
calculateTapeUsedlength;
end;

function TTape.px2mm(px: integer): integer;
begin
  result:=trunc(px * 25.4 / PrinterType.dpi);
end;

function TTape.mm2px(mm: integer): integer;
begin
  result:=trunc(mm * PrinterType.dpi / 25.4);
end;


end.


