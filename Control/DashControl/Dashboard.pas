unit Dashboard;

interface

uses
  Pkg.Json.DTO, System.Generics.Collections, ListFarm,
  System.UITypes;

{$M+}

type
  TRootDash = class
  private
    FASR: Double;
    FFarmOffiline: Integer;
    FFarmOnline: Integer;
    FHashRate: Integer;
    FID: Integer;
    FPowerDraw: Integer;
    FProfitability: Double;
    FUnpaidAmount: String;
    FWallet: Double;
    FDataArray: TArray<TDataFarmDTO>;
    FFarms: TObjectList<TDataFarmDTO>;
    FGpusTotal: integer;
    FGpusOffline: integer;
    FGpusOverheated: integer;
    FGpusOnline: integer;
    FWorkerId: integer;
    FCurrencyPair: String;


    procedure SetFarmOffiline(const Value: Integer);
    procedure SetFarmOnline(const Value: Integer);
    procedure SetHashRate(const Value: Integer);
    procedure SetPowerDraw(const Value: Integer);
    procedure SetProfitability(const Value: Double);
    procedure SetUnpaidAmount(const Value: String);
    procedure SetGpusOffline(const Value: integer);
    procedure SetGpusOnline(const Value: integer);
    procedure SetGpusOverheated(const Value: integer);
    procedure SetGpusTotal(const Value: integer);
    procedure SetWorkerId(const Value: integer);
    procedure SetCurrencyPair(const Value: String);

  published
    procedure SetFarms(const Value: TObjectList<TDataFarmDTO>);

    property ASR: Double read FASR write FASR;
    property FarmOffiline: Integer  read FFarmOffiline write SetFarmOffiline;
    property FarmOnline: Integer read FFarmOnline write SetFarmOnline;
    property HashRate: Integer read FHashRate write SetHashRate;
    property ID: Integer read FID write FID;
    property PowerDraw: Integer read FPowerDraw write SetPowerDraw;
    property Profitability: Double read FProfitability write SetProfitability;
    property UnpaidAmount: String read FUnpaidAmount write SetUnpaidAmount;
    property Wallet: Double read FWallet write FWallet;
    property WorkerId : integer read FWorkerId write SetWorkerId;
    property CurrencyPair : String read FCurrencyPair write SetCurrencyPair;
    Property Farms : TObjectList<TDataFarmDTO> read FFarms write SetFarms;

    Property GpusTotal : integer read FGpusTotal write SetGpusTotal;
    Property GpusOnline : integer read FGpusOnline write SetGpusOnline;
    Property GpusOffline : integer read FGpusOffline write SetGpusOffline;
    Property GpusOverheated : integer read FGpusOverheated write SetGpusOverheated;

    destructor Destroy;
    constructor Create();
    class function TfColor(temp: integer): TAlphaColor;
    class function DotsChanger(Value: string): String;

    //
    Function GetHashRate():string;
    Function GetPower():string;
    Function GetGpuStats():string;
    Function getUnpaidAmount():Double;
    Function getProfitability():Double;
    Function GetFCurrencyPair():Double;
    function GetData: TObjectList<TDataFarmDTO>;
  end;

implementation

uses
  System.SysUtils;

{ TFarmsDTO }

constructor TRootDash.Create;
begin
    FASR:= 0;
    FFarmOffiline:= 0;
    FFarmOnline:= 0;
    FHashRate:= 0;
    FID:= 0;
    FPowerDraw:= 0;
    FProfitability:= 0;
    FUnpaidAmount:= '0';
    FWallet:= 0;
    FGpusTotal:= 0;
    FGpusOffline:= 0;
    FGpusOverheated:= 0;
    FGpusOnline:= 0;
    FCurrencyPair:='';
end;

destructor TRootDash.Destroy;
begin
   GetData.Free;
  inherited;
end;

function TRootDash.GetData: TObjectList<TDataFarmDTO>;
begin
  if not Assigned(FFarms) then
  begin
    FFarms := TObjectList<TDataFarmDTO>.Create;
    FFarms.AddRange(FDataArray);
  end;
  Result := FFarms;
end;


function TRootDash.GetFCurrencyPair: Double;
begin
      Result := strtofloat(DotsChanger(FCurrencyPair))
end;

class function TRootDash.DotsChanger(Value: string): String;
   var i:integer;
begin
    if Value <>'' then begin
        for i := 0 to Length(Value) do begin
            if Value[i]='.' then Value[i]:=',';
        end;
     end;
     Result := Value;
end;

class function TRootDash.TfColor(temp: integer): TAlphaColor;
begin
    case temp of
     0 : Result := TAlphaColorRec.Coral;
     1 : result := TAlphaColorRec.Chocolate;
     2 : result := TAlphaColorRec.Peru;
     3 : result := TAlphaColorRec.Orange;
     else
      result := TAlphaColorRec.Chocolate;
    end;
end;


procedure TRootDash.SetFarms(const Value: TObjectList<TDataFarmDTO>);
begin
  FFarms := Value;
end;

function TRootDash.GetGpuStats: string;
begin
   result := inttostr(FGpusOnline)+ '/' +inttostr(FGpusTotal);
end;

function TRootDash.GetHashRate: string;
begin
    result := copy(inttostr(FHashRate),1,length(inttostr(FHashRate))-3) +' MH/s';
end;

function TRootDash.GetPower: string;
begin
   result := inttostr(FPowerDraw) +' KW';
end;

function TRootDash.getProfitability: Double;
begin
      Result :=  FProfitability;
end;

function TRootDash.getUnpaidAmount: Double;
begin
      Result := StrToFloat(FUnpaidAmount);
end;

procedure TRootDash.SetCurrencyPair(const Value: String);
begin
  FCurrencyPair := Value;
end;

procedure TRootDash.SetFarmOffiline(const Value: Integer);
begin
  FFarmOffiline := FFarmOffiline + Value;
end;

procedure TRootDash.SetFarmOnline(const Value: Integer);
begin
  FFarmOnline := FFarmOnline + Value;
end;


procedure TRootDash.SetGpusOffline(const Value: integer);
begin
  FGpusOffline := FGpusOffline + Value;
end;

procedure TRootDash.SetGpusOnline(const Value: integer);
begin
  FGpusOnline := FGpusOnline + Value;
end;

procedure TRootDash.SetGpusOverheated(const Value: integer);
begin
  FGpusOverheated := FGpusOverheated +  Value;
end;

procedure TRootDash.SetGpusTotal(const Value: integer);
begin
  FGpusTotal := FGpusTotal + Value;
end;

procedure TRootDash.SetHashRate(const Value: Integer);
begin
  FHashRate := FHashRate + Value;
end;

procedure TRootDash.SetPowerDraw(const Value: Integer);
begin
  FPowerDraw := FPowerDraw + Value;
end;

procedure TRootDash.SetProfitability(const Value: Double);
begin
  FProfitability := Value;
end;

procedure TRootDash.SetUnpaidAmount(const Value: string);
begin
  FUnpaidAmount := DotsChanger(Value);
end;

procedure TRootDash.SetWorkerId(const Value: integer);
begin
  FWorkerId := Value;
end;

end.
