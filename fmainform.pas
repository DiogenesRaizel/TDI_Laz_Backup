unit fMainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ComCtrls,
  ActnList, DBActns, Buttons, ExtCtrls, DBCtrls, PopupNotifier, rxtoolbar,
  RxPopupNotifier, RxMDI, fProject, fCountry, dRecords, dcustomer, fcustomer,
  DB;

type

  { TfrmMainForm }

  TfrmMainForm = class(TForm)
    dsMainForm: TDataSource;
    MenuItem2: TMenuItem;
    mnCustomer: TMenuItem;
    mnExit: TMenuItem;
    Separator2: TMenuItem;
    popSelectAll: TMenuItem;
    popDeselectAll: TMenuItem;
    MenuItem7: TMenuItem;
    Separator1: TMenuItem;
    PopupMenu1: TPopupMenu;
    StatusBar1: TStatusBar;
    SystemSearch: TAction;
    ActionList1: TActionList;
    DataSetCancel1: TDataSetCancel;
    DataSetDelete1: TDataSetDelete;
    DataSetEdit1: TDataSetEdit;
    DataSetFirst1: TDataSetFirst;
    DataSetInsert1: TDataSetInsert;
    DataSetLast1: TDataSetLast;
    DataSetNext1: TDataSetNext;
    DataSetPost1: TDataSetPost;
    DataSetPrior1: TDataSetPrior;
    DataSetRefresh1: TDataSetRefresh;
    ImageList1: TImageList;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    mnProject: TMenuItem;
    mnCountry: TMenuItem;
    PageControl1: TPageControl;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    tbCloseTab: TToolButton;
    tbTable: TToolButton;
    ToolButton14: TToolButton;
    tbCloseAllTabs: TToolButton;
    tbRegister: TToolButton;
    ToolButton16: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    procedure dsMainFormDataChange(Sender: TObject; Field: TField);
    procedure dsMainFormStateChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure mnProjectClick(Sender: TObject);
    procedure mnCountryClick(Sender: TObject);
    procedure mnCustomerClick(Sender: TObject);
    procedure mnExitClick(Sender: TObject);
    procedure PageControl1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure popDeselectAllClick(Sender: TObject);
    procedure popSelectAllClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure tbCloseAllTabsClick(Sender: TObject);
    procedure tbCloseTabClick(Sender: TObject);
    procedure tbTableClick(Sender: TObject);
  private
    frmProject: TfrmProject;
    frmCustomer: TfrmCustomer;
    frmCountry: TfrmCountry;
    FSheet: TTabSheet;
    function GetCloseForms(Sender: TObject; var aMsg: String): Boolean;
    procedure CreateTabSheet(aForm: TForm);
    procedure SetActivePage(aCaption: TCaption);
    procedure CloseForm(aName: TComponentName);
  public

  end;

var
  frmMainForm: TfrmMainForm;

implementation

{$R *.lfm}

{ TfrmMainForm }

procedure TfrmMainForm.mnProjectClick(Sender: TObject);
begin
  if not Assigned(frmProject) then
  begin
    frmProject := TfrmProject.Create (Application);
    CreateTabSheet(frmProject);
  end
  else SetActivePage(frmProject.Caption);
  dsMainForm.DataSet:= dmRecords.qryProject;
end;

procedure TfrmMainForm.dsMainFormStateChange(Sender: TObject);
begin
  case (Sender as TDataSource).State of
    dsOpening: StatusBar1.Panels[1].Text:= 'Opening';
    dsBrowse: StatusBar1.Panels[1].Text:= 'Browse';
    dsInsert: StatusBar1.Panels[1].Text:= 'Insert';
    dsEdit: StatusBar1.Panels[1].Text:= 'Edit';
    dsInactive: StatusBar1.Panels[1].Text:= 'Inactive';
    else StatusBar1.Panels[1].Text:= '';
  end;
end;

procedure TfrmMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  aMsg: String;
begin
  CanClose:= True;
  if not GetCloseForms(Sender, aMsg ) then
  begin
     CanClose:= False;
     MessageDlg  ('Warning', aMsg +
       ': Cancel or accept changes before tab close!', mtWarning, [mbOK], 0);
  end;
end;

procedure TfrmMainForm.dsMainFormDataChange(Sender: TObject; Field: TField);
begin
  StatusBar1.Panels[0].Text:= IntToStr( (Sender as TDataSource).DataSet.RecordCount ) + ':   ' + IntToStr( (Sender as TDataSource).DataSet.RecNo );
  tbTable.Enabled:= not((Sender as TDataSource).State = dsInactive);
  tbRegister.Enabled:= tbTable.Enabled;
  if (Sender as TDataSource).State in  dsEditModes then
    tbTable.Enabled:= False;
end;

procedure TfrmMainForm.mnCountryClick(Sender: TObject);
begin
  if not Assigned(frmCountry) then
  begin
    frmCountry := TfrmCountry.Create (Application);
    CreateTabSheet(frmCountry);
  end
  else SetActivePage(frmCountry.Caption);
  dsMainForm.DataSet:= dmRecords.qryCountry;
end;

procedure TfrmMainForm.mnCustomerClick(Sender: TObject);
begin
  if not Assigned(frmCustomer) then
  begin
    dmCustomer:= TdmCustomer.Create(Application);
    frmCustomer := TfrmCustomer.Create (Application);
    CreateTabSheet(frmCustomer);
  end
  else SetActivePage(frmCustomer.Caption);
  dsMainForm.DataSet:= dmCustomer.qryCustomer;
end;

procedure TfrmMainForm.mnExitClick(Sender: TObject);
begin
  Close;
end;


procedure TfrmMainForm.PageControl1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if PageControl1.ActivePage.Caption = 'Project' then
  begin
//    PageControl1.Hint:= Form.DataSource1.DataSet.FieldByName('PROJ_ID').Text + ' - ' + Form.DataSource1.DataSet.FieldByName('PROJ_NAME').Text;;
  end;
end;

procedure TfrmMainForm.popDeselectAllClick(Sender: TObject);
begin
  frmProject.SetActionSelect(0);
end;

procedure TfrmMainForm.popSelectAllClick(Sender: TObject);
begin
  frmProject.SetActionSelect(1);
end;

procedure TfrmMainForm.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage.Caption = 'Project' then
  begin
    dsMainForm.DataSet:= dmRecords.qryProject;
  end
  else
  if PageControl1.ActivePage.Caption = 'Country' then
  begin
    dsMainForm.DataSet:= dmRecords.qryCountry
  end
  else
  if PageControl1.ActivePage.Caption = 'Customer' then
  begin
    dsMainForm.DataSet:= dmCustomer.qryCustomer;
  end;
  StatusBar1.Panels[2].Text:= PageControl1.ActivePage.Caption;
end;

procedure TfrmMainForm.PopupMenu1Popup(Sender: TObject);
begin
  popSelectAll.Enabled:= False;
  popDeselectAll.Enabled:= False;
  MenuItem7.Enabled:= False;
  if PageControl1.TabIndex > -1 then
  begin
    if PageControl1.ActivePage.Caption = 'Project' then
    begin
      if frmProject.ActivePageName = 'TabSheet1' then
      begin
        popSelectAll.Enabled:= True;
        popDeselectAll.Enabled:= True;
        MenuItem7.Enabled:= True;
      end;
    end;
  end;
end;

procedure TfrmMainForm.tbCloseAllTabsClick(Sender: TObject);
var
  aMsg: String;
begin
  if not GetCloseForms(Sender, aMsg ) then
     MessageDlg  ('Warning', aMsg +
       ': Cancel or accept changes before tab close!', mtWarning, [mbOK], 0);
end;

procedure TfrmMainForm.tbCloseTabClick(Sender: TObject);
var
  i: integer;
begin
  for i:= Screen.FormCount - 1 downto  1 do
    if Screen.Forms[I].Caption = PageControl1.Pages[PageControl1.ActivePageIndex].Name then
    begin
      if not (dsMainForm.State in dsEditModes) then
      begin
        CloseForm(Screen.Forms[i].Name);
        Break;
      end
      else
      MessageDlg  ('Warning', PageControl1.Pages[PageControl1.ActivePageIndex].Name +
           ': Cancel or accept changes before tab close!', mtWarning, [mbOK], 0);
    end;
  if PageControl1.PageCount = 0 then
    dsMainForm.DataSet:= Nil;
end;

procedure TfrmMainForm.tbTableClick(Sender: TObject);
var
  i: integer;
begin
  for i:= 1 to Screen.FormCount - 1 do
    if Screen.Forms[I].Caption = PageControl1.Pages[PageControl1.ActivePageIndex].Name then
    begin
      case Screen.Forms[i].Name of
        //'frmProject': ;
        //'frmCountry':;
        'frmCustomer': frmCustomer.SetTabChange((Sender as TToolButton).Tag);
      end;
      Break;
    end;
end;

function TfrmMainForm.GetCloseForms(Sender: TObject; var aMsg: String): Boolean;
var
  i, ii: integer;
begin
  aMsg:= '';
  for i:= 0 to PageControl1.PageCount - 1 do
  begin
    PageControl1.ActivePageIndex:= i;
    PageControl1Change(Sender);
    for ii:= 1 to Screen.FormCount - 1 do
      if Screen.Forms[ii].Caption = PageControl1.Pages[PageControl1.ActivePageIndex].Name then
      begin
        if not (dsMainForm.State in dsEditModes) then
        begin
          CloseForm(Screen.Forms[ii].Name);
          Break;
        end
        else
        begin
          aMsg:= aMsg +  PageControl1.Pages[PageControl1.ActivePageIndex].Name + ' ';
          Break;
        end;
      end;
  end;
  if aMsg = '' then
  begin
    if PageControl1.PageCount = 0 then
       dsMainForm.DataSet:= Nil;
    Result:= True;
  end
  else
    Result:= False;
end;

procedure TfrmMainForm.CreateTabSheet(aForm: TForm);
begin
  FSheet := TTabSheet.Create(PageControl1);
  FSheet.PageControl := PageControl1;
  aForm.BorderStyle := bsNone;
  aForm.Align := alClient;
  aForm.Parent := FSheet;
  aForm. Visible := True;
  PageControl1.ActivePage := FSheet;
  FSheet.Caption := aForm.Caption;
  FSheet.Name:= aForm.Caption;
  tbCloseTab.Enabled:= True;
  tbCloseAllTabs.Enabled:= True;
  StatusBar1.Panels[2].Text:= aForm.Caption;
end;

procedure TfrmMainForm.SetActivePage(aCaption: TCaption);
var
  i: Integer;
begin
  for i := 0 to PageControl1.PageCount -1 do
    if PageControl1.Pages[i].Name = aCaption then
       PageControl1.ActivePageIndex:= i;
end;

procedure TfrmMainForm.CloseForm(aName: TComponentName);
begin
  case aName of
    'frmProject':
    begin
      frmProject.Close;
      FreeAndNil(frmProject);
    end;
    'frmCountry':
    begin
      frmCountry.Close;
      FreeAndNil(frmCountry);
    end;
    'frmCustomer':
    begin
      frmCustomer.Close;
      FreeAndNil(frmCustomer);
    end;
  end;
  PageControl1.Pages[PageControl1.ActivePageIndex].Free;
  tbCloseTab.Enabled:= (Screen.FormCount > 1);
  tbCloseAllTabs.Enabled:= tbCloseTab.Enabled;
  tbTable.Enabled:= tbCloseTab.Enabled;
  tbRegister.Enabled:= tbCloseTab.Enabled;
  if PageControl1.PageCount > 0 then
  begin
    StatusBar1.Panels[2].Text:= PageControl1.Pages[PageControl1.ActivePageIndex].Caption;
    PageControl1Change(Self);
  end
  else
  begin
    StatusBar1.Panels[2].Text:= '';
    StatusBar1.Panels[1].Text:= '';
    StatusBar1.Panels[0].Text:= '';
  end;
end;

end.

