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
    FUnpaidAmount: Double;
    FDataArray: TArray<TDataFarmDTO>;
    FFarms: TObjectList<TDataFarmDTO>;
    FGpusTotal: Integer;
    FGpusOffline: Integer;
    FGpusOverheated: Integer;
    FGpusOnline: Integer;
    FWorkerId: Integer;
    FCurrencyPair: String;
    procedure SetFarmOffiline(const Value: Integer);
    procedure SetFarmOnline(const Value: Integer);
    procedure SetHashRate(const Value: Integer);
    procedure SetPowerDraw(const Value: Integer);
    procedure SetProfitability(const Value: Double);
    procedure SetUnpaidAmount(const Value: Double);
    procedure SetGpusOffline(const Value: Integer);
    procedure SetGpusOnline(const Value: Integer);
    procedure SetGpusOverheated(const Value: Integer);
    procedure SetGpusTotal(const Value: Integer);
    procedure SetWorkerId(const Value: Integer);
    procedure SetCurrencyPair(const Value: String);
    function GetData: TObjectList<TDataFarmDTO>;
    procedure SetFarms(const Value: TObjectList<TDataFarmDTO>);
  published
    property ASR: Double read FASR write FASR;
    property FarmOffiline: Integer read FFarmOffiline write SetFarmOffiline;
    property FarmOnline: Integer read FFarmOnline write SetFarmOnline;
    property HashRate: Integer read FHashRate write SetHashRate;
    property ID: Integer read FID write FID;
    property PowerDraw: Integer read FPowerDraw write SetPowerDraw;
    property Profitability: Double read FProfitability write SetProfitability;
    property UnpaidAmount: Double read FUnpaidAmount write SetUnpaidAmount;
    property WorkerId: Integer read FWorkerId write SetWorkerId;
    property CurrencyPair: String read FCurrencyPair write SetCurrencyPair;
    Property Farms: TObjectList<TDataFarmDTO> read FFarms write SetFarms;
    Property GpusTotal: Integer read FGpusTotal write SetGpusTotal;
    Property GpusOnline: Integer read FGpusOnline write SetGpusOnline;
    Property GpusOffline: Integer read FGpusOffline write SetGpusOffline;
    Property GpusOverheated: Integer read FGpusOverheated
      write SetGpusOverheated;
    // Events
    destructor Destroy;
    constructor Create(farm: TRootFarms);
    class function TfColor(temp: Integer): TAlphaColor;
    class function DotsChanger(Value: string): String;
    //
    Function GetHashRate(): string;
    Function GetPower(): string;
    Function GetGpuStats(): string;
    Function GetUnpaidAmount(): Double;
    Function GetProfitability(): Double;
    Function GetFCurrencyPair(): Double;
  end;

implementation

uses
  System.SysUtils;

{ TFarmsDTO }

constructor TRootDash.Create(farm: TRootFarms);
var
  i: Integer;
begin
  FID := 0;
  FProfitability := 0;
  FUnpaidAmount := 0;
  FCurrencyPair := '';

  for i := 0 to pred(farm.Data.Count) do
  begin
    HashRate := farm.Data[i].GetHashRate;
    PowerDraw := farm.Data[i].Stats.Power_Draw;
    ASR := farm.Data[i].Stats.ASR;
    FarmOnline := farm.Data[i].Stats.Rigs_Online;
    FarmOffiline := farm.Data[i].Stats.Rigs_Offline;
    GpusTotal := farm.Data[i].Stats.Gpus_Total;
    GpusOnline := farm.Data[i].Stats.Gpus_Online;
    GpusOffline := farm.Data[i].Stats.Gpus_Offline;
    GpusOverheated := farm.Data[i].Stats.Gpus_Overheated;
    SetFarms(farm.GetData);
  end;
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
var
  i: Integer;
begin
  if Value <> '' then
  begin
    for i := 0 to Length(Value) do
    begin
      if Value[i] = '.' then
        Value[i] := ',';
    end;
  end;
  Result := Value;
end;

class function TRootDash.TfColor(temp: Integer): TAlphaColor;
begin
  case temp of
    0:
      Result := TAlphaColorRec.Coral;
    1:
      Result := TAlphaColorRec.Chocolate;
    2:
      Result := TAlphaColorRec.Peru;
    3:
      Result := TAlphaColorRec.Orange;
  else
    Result := TAlphaColorRec.Chocolate;
  end;
end;

procedure TRootDash.SetFarms(const Value: TObjectList<TDataFarmDTO>);
begin
  FFarms := Value;
end;

function TRootDash.GetGpuStats: string;
begin
  Result := inttostr(FGpusOnline) + '/' + inttostr(FGpusTotal);
end;

function TRootDash.GetHashRate: string;
var
  hash: real;
begin
  hash := strtofloat(copy(inttostr(FHashRate), 1,
    Length(inttostr(FHashRate)) - 3));
  Result := FloatToStr(hash) + ' MH/s';

end;

function TRootDash.GetPower: string;
begin
  Result := inttostr(FPowerDraw) + ' KW';
end;

function TRootDash.GetProfitability: Double;
begin
  Result := FProfitability;
end;

function TRootDash.GetUnpaidAmount: Double;
begin
  Result := FUnpaidAmount;
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

procedure TRootDash.SetGpusOffline(const Value: Integer);
begin
  FGpusOffline := FGpusOffline + Value;
end;

procedure TRootDash.SetGpusOnline(const Value: Integer);
begin
  FGpusOnline := FGpusOnline + Value;
end;

procedure TRootDash.SetGpusOverheated(const Value: Integer);
begin
  FGpusOverheated := FGpusOverheated + Value;
end;

procedure TRootDash.SetGpusTotal(const Value: Integer);
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

procedure TRootDash.SetUnpaidAmount(const Value: Double);
begin
  FUnpaidAmount := Value;
end;

procedure TRootDash.SetWorkerId(const Value: Integer);
begin
  FWorkerId := Value;
end;

end.
