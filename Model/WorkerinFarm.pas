unit WorkerinFarm;

interface

uses
  Pkg.Json.DTO, System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TGpu_StatsDTO = class
  private
    FBus_Id: string;
    FBus_Number: Integer;
    FFan: Integer;
    FHash: Double;
    FIs_Overheated: Boolean;
    FPower: Integer;
    FTemp: Integer;
  published
    property Bus_Id: string read FBus_Id write FBus_Id;
    property Bus_Number: Integer read FBus_Number write FBus_Number;
    property Fan: Integer read FFan write FFan;
    property Hash: Double read FHash write FHash;
    property Is_Overheated: Boolean read FIs_Overheated write FIs_Overheated;
    property Power: Integer read FPower write FPower;
    property Temp: Integer read FTemp write FTemp;
  end;

  TSharesDTO = class
  private
    FAccepted: Integer;
    FInvalid: Integer;
    FRatio: Double;
    FRejected: Integer;
    FTotal: Integer;
  published
    property Accepted: Integer read FAccepted write FAccepted;
    property Invalid: Integer read FInvalid write FInvalid;
    property Ratio: Double read FRatio write FRatio;
    property Rejected: Integer read FRejected write FRejected;
    property Total: Integer read FTotal write FTotal;
  end;

  THashratesDTO = class
  private
    FAlgo: string;
    FCoin: string;
    FHash: Integer;
    FMiner: string;
    FShares: TSharesDTO;
    FVer: string;
  published
    property Algo: string read FAlgo write FAlgo;
    property Coin: string read FCoin write FCoin;
    property Hash: Integer read FHash write FHash;
    property Miner: string read FMiner write FMiner;
    property Shares: TSharesDTO read FShares write FShares;
    property Ver: string read FVer write FVer;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TMiners_SummaryDTO = class
  private
    [JSONName('hashrates')]
    FHashratesArray: TArray<THashratesDTO>;
    [GenericListReflect]
    FHashrates: TObjectList<THashratesDTO>;
  published
    function GetHashrates: TObjectList<THashratesDTO>;
    property Hashrates: TObjectList<THashratesDTO> read GetHashrates;
    destructor Destroy; override;
  end;

  TProblemsDTO = class
  end;

  TStatsDTO = class
  private
    FBoot_Time: Integer;
    FCpus_Online: Integer;
    FGpus_Offline: Integer;
    FGpus_Online: Integer;
    FGpus_Overheated: Integer;
    FInvalid: Boolean;
    FLow_Asr: Boolean;
    FMiner_Start_Time: Integer;
    FOnline: Boolean;
    FOverheated: Boolean;
    FOverloaded: Boolean;
    FPower_Draw: Integer;
    [JSONName('problems')]
    FProblemsArray: TArray<TProblemsDTO>;
    [GenericListReflect]
    FProblems: TObjectList<TProblemsDTO>;
    FStats_Time: Integer;
    function GetProblems: TObjectList<TProblemsDTO>;
  published
    property Boot_Time: Integer read FBoot_Time write FBoot_Time;
    property Cpus_Online: Integer read FCpus_Online write FCpus_Online;
    property Gpus_Offline: Integer read FGpus_Offline write FGpus_Offline;
    property Gpus_Online: Integer read FGpus_Online write FGpus_Online;
    property Gpus_Overheated: Integer read FGpus_Overheated write FGpus_Overheated;
    property Invalid: Boolean read FInvalid write FInvalid;
    property Low_Asr: Boolean read FLow_Asr write FLow_Asr;
    property Miner_Start_Time: Integer read FMiner_Start_Time write FMiner_Start_Time;
    property Online: Boolean read FOnline write FOnline;
    property Overheated: Boolean read FOverheated write FOverheated;
    property Overloaded: Boolean read FOverloaded write FOverloaded;
    property Power_Draw: Integer read FPower_Draw write FPower_Draw;
    property Problems: TObjectList<TProblemsDTO> read GetProblems;
    property Stats_Time: Integer read FStats_Time write FStats_Time;
    destructor Destroy; override;
  end;

  TDataWorkerDTO = class
  private
    FActive: Boolean;
    FDescription: string;
    FFarm_Id: Integer;
    [JSONName('gpu_stats')]
    FGpu_StatsArray: TArray<TGpu_StatsDTO>;
    [GenericListReflect]
    FGpu_Stats: TObjectList<TGpu_StatsDTO>;
    FId: Integer;
    FMiners_Summary: TMiners_SummaryDTO;
    FName: string;
    FPlatform: Integer;
    FStats: TStatsDTO;
    FUnits_Count: Integer;
    function GetGpu_Stats: TObjectList<TGpu_StatsDTO>;
  published
    property Active: Boolean read FActive write FActive;
    property Description: string read FDescription write FDescription;
    property Farm_Id: Integer read FFarm_Id write FFarm_Id;
    property Gpu_Stats: TObjectList<TGpu_StatsDTO> read GetGpu_Stats;
    property Id: Integer read FId write FId;
    property Miners_Summary: TMiners_SummaryDTO read FMiners_Summary write FMiners_Summary;
    property Name: string read FName write FName;
    property Platform: Integer read FPlatform write FPlatform;
    property Stats: TStatsDTO read FStats write FStats;
    property Units_Count: Integer read FUnits_Count write FUnits_Count;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TRootWorkerinFarm = class(TJsonDTO)
  private
    [JSONName('data')]
    FDataArray: TArray<TDataWorkerDTO>;
    [GenericListReflect]
    FData: TObjectList<TDataWorkerDTO>;
  Public
    function GetData: TObjectList<TDataWorkerDTO>;
  published
    property Data: TObjectList<TDataWorkerDTO> read GetData;
    destructor Destroy; override;
  end;

implementation

{ THashratesDTO }

constructor THashratesDTO.Create;
begin
  inherited;
  FShares := TSharesDTO.Create;
end;

destructor THashratesDTO.Destroy;
begin
  FShares.Free;
  inherited;
end;

{ TMiners_SummaryDTO }

destructor TMiners_SummaryDTO.Destroy;
begin
  GetHashrates.Free;
  inherited;
end;

function TMiners_SummaryDTO.GetHashrates: TObjectList<THashratesDTO>;
begin
  if not Assigned(FHashrates) then
  begin
    FHashrates := TObjectList<THashratesDTO>.Create;
    FHashrates.AddRange(FHashratesArray);
  end;
  Result := FHashrates;
end;

{ TStatsDTO }

destructor TStatsDTO.Destroy;
begin
  GetProblems.Free;
  inherited;
end;

function TStatsDTO.GetProblems: TObjectList<TProblemsDTO>;
begin
  if not Assigned(FProblems) then
  begin
    FProblems := TObjectList<TProblemsDTO>.Create;
    FProblems.AddRange(FProblemsArray);
  end;
  Result := FProblems;
end;

{ TDataDTO }

constructor TDataWorkerDTO.Create;
begin
  inherited;
  FStats := TStatsDTO.Create;
  FMiners_Summary := TMiners_SummaryDTO.Create;
end;

destructor TDataWorkerDTO.Destroy;
begin
  FStats.Free;
  FMiners_Summary.Free;
  GetGpu_Stats.Free;
  inherited;
end;

function TDataWorkerDTO.GetGpu_Stats: TObjectList<TGpu_StatsDTO>;
begin
  if not Assigned(FGpu_Stats) then
  begin
    FGpu_Stats := TObjectList<TGpu_StatsDTO>.Create;
    FGpu_Stats.AddRange(FGpu_StatsArray);
  end;
  Result := FGpu_Stats;
end;

{ TRootDTO }


destructor TRootWorkerinFarm.Destroy;
begin
  GetData.Free;
  inherited;
end;

function TRootWorkerinFarm.GetData: TObjectList<TDataWorkerDTO>;
begin
  if not Assigned(FData) then
  begin
    FData := TObjectList<TDataWorkerDTO>.Create;
    FData.AddRange(FDataArray);
  end;
  Result := FData;
end;

end.
