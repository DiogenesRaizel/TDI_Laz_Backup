unit fcustomer;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  DBCtrls, Buttons, ExtCtrls, dcustomer, RxDBGrid, LCLType;

type

  { TfrmCustomer }

  TfrmCustomer = class(TForm)
    btSearch: TBitBtn;
    cbColumn: TComboBox;
    DataSource1: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    edValue: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PageControl1: TPageControl;
    dbTable: TRxDBGrid;
    Panel1: TPanel;
    tsTable: TTabSheet;
    tsRegister: TTabSheet;
    procedure btSearchClick(Sender: TObject);
    procedure DataSource1StateChange(Sender: TObject);
    procedure DBEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FormCreate(Sender: TObject);
    procedure ComponentExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FocusIndex: Integer;

  public
    procedure SetTabChange(aValue: Integer);

  end;

var
  frmCustomer: TfrmCustomer;

implementation

{$R *.lfm}

{ TfrmCustomer }

procedure TfrmCustomer.FormCreate(Sender: TObject);
begin
  PageControl1.ShowTabs:= False;
  PageControl1.ActivePageIndex:= 0;
end;

procedure TfrmCustomer.ComponentExit(Sender: TObject);
begin
  FocusIndex:= (Sender as TComponent).ComponentIndex;
end;

procedure TfrmCustomer.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

end;

procedure TfrmCustomer.SetTabChange(aValue: Integer);
begin
  PageControl1.ActivePageIndex:= aValue;
  if TWinControl(Components[FocusIndex]).IsVisible then
    TWinControl(Components[FocusIndex]).SetFocus
end;

procedure TfrmCustomer.btSearchClick(Sender: TObject);
var
  s: String;
begin
  try
  if trim(edValue.Text) <> '' then
  begin
    s:= 'where a.' + cbColumn.Text + ' like ' + '''' + '%' + Trim(edValue.Text) + '%' + '''';
    s:= s + ' OR a.' + cbColumn.Text + ' IN (' + '''' + Trim(edValue.Text) + '''' + ')';
  end;
  dmCustomer.SetCustomerSql(s);

  if dmCustomer.qryCustomer.IsEmpty then
  begin
    MessageDlg  ('Information', 'Register not found!', mtInformation, [mbOK], 0);
    edValue.SetFocus;
  end
  else dbTable.SetFocus;
  except
    //on E: Exception do
    //  ShowMessage('An exception was raised: ' + E.Message);
    MessageDlg  ('Error', 'Invalid value: ' + Trim(edValue.Text), mtError, [mbOK], 0);
  end;
end;

procedure TfrmCustomer.DataSource1StateChange(Sender: TObject);
begin
  if (Sender as TDataSource).DataSet.State in  dsEditModes then
    PageControl1.ActivePageIndex:= 1;
end;

procedure TfrmCustomer.DBEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //if Key= VK_Return then SelectNext(ActiveControl,True,False);
  //if Key= VK_Return then DBEdit2.SetFocus;
  //frmCustomer.SelectNext(frmCustomer as TWinControl, True, False);
end;

end.

