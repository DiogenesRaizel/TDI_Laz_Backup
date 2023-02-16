unit dMain;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ZConnection;

type

  { TdmMain }

  TdmMain = class(TDataModule)
    ZConnection1: TZConnection;
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

var
  dmMain: TdmMain;

implementation

{$R *.lfm}

{ TdmMain }


procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  ZConnection1.Connected:= False;
  ZConnection1.Connected:= True;
end;

end.

