unit fCountry;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ComCtrls, ExtCtrls, DBCtrls, RxDBGrid, dRecords, DB;

type

  { TfrmCountry }

  TfrmCountry = class(TForm)
    btnSearch: TBitBtn;
    cbParam: TComboBox;
    dsCountry: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    edValue: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    dbTable: TRxDBGrid;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure btnSearchClick(Sender: TObject);
    procedure ComponentExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private
    FieldFocusIndex: Integer;

  public

  end;

var
  frmCountry: TfrmCountry;

implementation

{$R *.lfm}

{ TfrmCountry }

procedure TfrmCountry.ComponentExit(Sender: TObject);
begin
  FieldFocusIndex:= (Sender as TComponent).ComponentIndex;
end;

procedure TfrmCountry.FormCreate(Sender: TObject);
begin
  dmRecords.SetCountryEmpty;
end;

procedure TfrmCountry.PageControl1Change(Sender: TObject);
begin
  if TWinControl(Components[FieldFocusIndex]).IsVisible then
    TWinControl(Components[FieldFocusIndex]).SetFocus
  else if dbTable.IsVisible then
    dbTable.SetFocus;
end;

procedure TfrmCountry.btnSearchClick(Sender: TObject);
var
  s: String;
begin
  if trim(edValue.Text) <> '' then
    s:= 'where r.' + cbParam.Text + ' like ' + '''' + '%' + Trim(edValue.Text) + '%' + '''';
  dmRecords.SetCountrySQL(s);
  if dmRecords.qryCountry.IsEmpty then
  begin
    MessageDlg  ('Information', 'Register not found!', mtInformation, [mbOK], 0);
    edValue.SetFocus;
  end
  else dbTable.SetFocus;
end;

end.

