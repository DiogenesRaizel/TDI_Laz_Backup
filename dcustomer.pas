unit dcustomer;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, dMain, DB, ZDataset, ZSqlUpdate, Dialogs;

type

  { TdmCustomer }

  TdmCustomer = class(TDataModule)
    qryCustomer: TZQuery;
    qryCustomerADDRESS_LINE1: TStringField;
    qryCustomerADDRESS_LINE2: TStringField;
    qryCustomerCITY: TStringField;
    qryCustomerCONTACT_FIRST: TStringField;
    qryCustomerCONTACT_LAST: TStringField;
    qryCustomerCOUNTRY: TStringField;
    qryCustomerCUSTOMER: TStringField;
    qryCustomerCUST_NO: TLongintField;
    qryCustomerON_HOLD: TStringField;
    qryCustomerPHONE_NO: TStringField;
    qryCustomerPOSTAL_CODE: TStringField;
    qryCustomerSTATE_PROVINCE: TStringField;
    ZUpdateSQL1: TZUpdateSQL;
    procedure DataModuleCreate(Sender: TObject);
  private

  public
    procedure SetCustomerSql(Value: String);

  end;

var
  dmCustomer: TdmCustomer;

implementation

{$R *.lfm}

{ TdmCustomer }

procedure TdmCustomer.DataModuleCreate(Sender: TObject);
begin
  qryCustomer.Active:= True;
end;

procedure TdmCustomer.SetCustomerSql(Value: String);
begin
  {WHERE CAST( a.CUST_NO as VARCHAR(8)) LIKE '%%'}
  qryCustomer.Active:= False;
  qryCustomer.SQL.Clear;
  qryCustomer.SQL.Add('SELECT a.CUST_NO, a.CUSTOMER, a.CONTACT_FIRST, ');
  qryCustomer.SQL.Add('a.CONTACT_LAST, a.PHONE_NO, a.ADDRESS_LINE1, ');
  qryCustomer.SQL.Add('a.ADDRESS_LINE2, a.CITY, a.STATE_PROVINCE, a.COUNTRY, ');
  qryCustomer.SQL.Add('a.POSTAL_CODE, a.ON_HOLD ');
  qryCustomer.SQL.Add('FROM CUSTOMER a ');
  qryCustomer.SQL.Add(Value);
  qryCustomer.SQL.SaveToFile('C:\Lazarus-Project\Tabbed Document Interface Demo\tmp\Customer.txt');
  qryCustomer.Active:= True;

end;

end.

