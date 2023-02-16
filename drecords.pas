unit dRecords;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, dMain, DB, ZDataset, ZSequence, ZSqlUpdate, Dialogs;

type

  { TdmRecords }

  TdmRecords = class(TDataModule)
    qryCountry_OLDCOUNTRY: TStringField;
    qryCountry_OLDCURRENCY: TStringField;
    qryProject: TZQuery;
    qryProjectACAO3: TLongintField;
    qryProjectPRODUCT: TStringField;
    qryProjectPROJ_DESC: TMemoField;
    qryProjectPROJ_ID: TStringField;
    qryProjectPROJ_NAME: TStringField;
    qryProjectTEAM_LEADER: TSmallintField;
    qryCustumer: TZQuery;
    qryCountry: TZQuery;
    updCountry: TZUpdateSQL;
    procedure qryCountryAfterPost(DataSet: TDataSet);
  private

  public
    procedure SetProjectEmpty;
    procedure SetNotEmpty;
    procedure SetProjectSQL(Value: String);
    procedure SetCountrySQL(Value: String);
    procedure SetCountryEmpty;
  end;

var
  dmRecords: TdmRecords;

implementation

{$R *.lfm}

{ TdmRecords }

procedure TdmRecords.qryCountryAfterPost(DataSet: TDataSet);
begin
  qryCountry.ApplyUpdates;
end;

procedure TdmRecords.SetProjectEmpty;
begin
  qryProject.Active:= False;
  qryProject.SQL.Clear;
  qryProject.SQL.Add('SELECT 0 as ACAO3, r.PROJ_ID, r.PROJ_NAME, r.PROJ_DESC, r.TEAM_LEADER, r.PRODUCT ');
  qryProject.SQL.Add('FROM PROJECT r ');
  qryProject.SQL.Add('WHERE r.PROJ_NAME = ' + '''' + '''');
  qryProject.SQL.SaveToFile('C:\Lazarus-Project\Tabbed Document Interface Demo\tmp\projectEmpty.txt');
  qryProject.Active:= True;
end;

procedure TdmRecords.SetNotEmpty;
begin
  qryProject.Active:= False;
  qryProject.SQL.Clear;
  qryProject.SQL.Add('SELECT 0 as ACAO3, r.PROJ_ID, r.PROJ_NAME, r.PROJ_DESC, r.TEAM_LEADER, r.PRODUCT ');
  qryProject.SQL.Add('FROM PROJECT r ');
  qryProject.Active:= True;
end;

procedure TdmRecords.SetProjectSQL(Value: String);
begin
  qryProject.Active:= False;
  qryProject.SQL.Clear;
  qryProject.SQL.Add('SELECT 0 as ACAO3, r.PROJ_ID, r.PROJ_NAME, r.PROJ_DESC, r.TEAM_LEADER, r.PRODUCT ');
  qryProject.SQL.Add('FROM PROJECT r ');
  qryProject.SQL.Add(Value);
  qryProject.Active:= True;
  qryProject.SQL.SaveToFile('C:\Lazarus-Project\Tabbed Document Interface Demo\tmp\Project.txt');
end;

procedure TdmRecords.SetCountrySQL(Value: String);
begin
  qryCountry.Active:= False;
  qryCountry.SQL.Clear;
  qryCountry.SQL.Add('SELECT r.COUNTRY, r.CURRENCY ');
  qryCountry.SQL.Add('FROM COUNTRY r ');
  qryCountry.SQL.Add(Value);
  qryCountry.Active:= True;
//  qryCountry.SQL.SaveToFile('C:\Lazarus-Project\Tabbed Document Interface Demo\tmp\COUNTRY.txt');
end;

procedure TdmRecords.SetCountryEmpty;
begin
  qryCountry.Active:= False;
  qryCountry.SQL.Clear;
  qryCountry.SQL.Add('SELECT r.COUNTRY, r.CURRENCY ');
  qryCountry.SQL.Add('FROM COUNTRY r ');
  qryCountry.SQL.Add('WHERE r.COUNTRY = ' + '''' + '''');
  qryCountry.Active:= True;
end;

end.

