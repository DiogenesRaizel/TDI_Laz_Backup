unit fProject;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBCtrls,
  DBGrids, StdCtrls, ComCtrls, Buttons, ZDataset, dRecords, RxDBGrid,
  rxpagemngr, Grids, PopupNotifier, CheckLst, ListFilterEdit, Types;

type

  { TfrmProject }

  TfrmProject = class(TForm)
    btnSearch: TBitBtn;
    cbParam: TComboBox;
    dsProject: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBMemo1: TDBMemo;
    edValue: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ListFilterEdit1: TListFilterEdit;
    PageControl1: TPageControl;
    Panel1: TPanel;
    dbTable: TRxDBGrid;
    StringGrid1: TStringGrid;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;

    procedure btnSearchClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure DBComponenteExit(Sender: TObject);
    procedure PageControl1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbTableCellClick(Column: TColumn);
    procedure TabSheet2Exit(Sender: TObject);
  private
    FActivePageName: TComponentName;
    sl: TStringList;
    FieldFocusIndex: Integer;
  public
    procedure SetActionSelect(value: integer);
  property ActivePageName: String read FActivePageName;

  end;

var
  frmProject: TfrmProject;

implementation

{$R *.lfm}

{ TfrmProject }

procedure TfrmProject.btnSearchClick(Sender: TObject);
var
  s: String;
begin
  if Trim(edValue.Text) <> '' then
    s:= 'where r.' + cbParam.Text + ' like ' + '''' + '%' + Trim(edValue.Text) + '%' + '''';
  dmRecords.SetProjectSQL(s);
  if dmRecords.qryProject.IsEmpty then
  begin
    MessageDlg  ('Information', 'Register not found!', mtInformation, [mbOK], 0);
    edValue.SetFocus;
  end
  else dbTable.SetFocus;
end;

procedure TfrmProject.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin

end;

procedure TfrmProject.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin


end;

procedure TfrmProject.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePage:= TabSheet1;
  dmRecords.SetProjectEmpty;
end;

procedure TfrmProject.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

end;

procedure TfrmProject.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  if dsProject.State in dsEditModes then
  begin
     AllowChange:= False;
{
    if FieldFocusIndex > -1 then
      TWinControl(Components[FieldFocusIndex]).SetFocus
    else
      dsProject.DataSet.FieldByName('PROJ_ID').FocusControl;
      }
  end;
end;

procedure TfrmProject.DBComponenteExit(Sender: TObject);
begin
  FieldFocusIndex:= (Sender as TComponent).ComponentIndex;
end;

procedure TfrmProject.PageControl1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  PageControl1.Hint:= dsProject.DataSet.FieldByName('PROJ_ID').Text + ' - ' + dsProject.DataSet.FieldByName('PROJ_NAME').Text;;
end;

procedure TfrmProject.dbTableCellClick(Column: TColumn);
begin
  if Column.FieldName = 'ACAO3' then
  begin
    dsProject.DataSet.DisableControls;
    dsProject.DataSet.Edit;
    dsProject.DataSet.FieldByName('ACAO3').AsInteger:= not(dsProject.DataSet.FieldByName('ACAO3').AsInteger);
    dsProject.DataSet.Post;
    dsProject.DataSet.EnableControls;
  end;
end;

procedure TfrmProject.TabSheet2Exit(Sender: TObject);
begin
  if TabSheet2.ComponentIndex = (Sender as TComponent).ComponentIndex then
  begin
    if FieldFocusIndex > -1 then
    begin
      if TWinControl(Components[FieldFocusIndex]).IsVisible then
        TWinControl(Components[FieldFocusIndex]).SetFocus
    end
    else
      dsProject.DataSet.FieldByName('PROJ_ID').FocusControl;
  end;
end;

procedure TfrmProject.SetActionSelect(value: integer);
var
  i: Integer;
begin
  i:= dsProject.DataSet.RecNo;
  dsProject.DataSet.DisableControls;
  dsProject.DataSet.First;
  while not( dsProject.DataSet.EOF) do
  begin
    dsProject.DataSet.Edit;
    dsProject.DataSet.FieldByName('ACAO3').AsInteger:= value;
    dsProject.DataSet.Post;
    dsProject.DataSet.Next;
  end;
  dsProject.DataSet.RecNo:= i;
  dsProject.DataSet.EnableControls;
end;

end.


