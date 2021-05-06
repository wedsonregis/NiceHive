unit Hiveon;

interface

uses
  Pkg.Json.DTO, System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TSucceedPayoutsDTO = class
  end;

  TPendingPayoutsDTO = class
  end;

  TEarningStatsDTO = class
  private
    FMeanReward: Double;
    FReward: Double;
    FTimestamp: string;
  published
    property MeanReward: Double read FMeanReward write FMeanReward;
    property Reward: Double read FReward write FReward;
    property Timestamp: string read FTimestamp write FTimestamp;
  end;

  TRootHiveon = class(TJsonDTO)
  private
    [JSONName('earningStats')]
    FEarningStatsArray: TArray<TEarningStatsDTO>;
    [GenericListReflect]
    FEarningStats: TObjectList<TEarningStatsDTO>;
    FExpectedReward24H: Double;
    FExpectedRewardWeek: Double;
    [JSONName('pendingPayouts')]
    FPendingPayoutsArray: TArray<TPendingPayoutsDTO>;
    [GenericListReflect]
    FPendingPayouts: TObjectList<TPendingPayoutsDTO>;
    [JSONName('succeedPayouts')]
    FSucceedPayoutsArray: TArray<TSucceedPayoutsDTO>;
    [GenericListReflect]
    FSucceedPayouts: TObjectList<TSucceedPayoutsDTO>;
    FTotalUnpaid: Double;
    function GetEarningStats: TObjectList<TEarningStatsDTO>;
    function GetPendingPayouts: TObjectList<TPendingPayoutsDTO>;
    function GetSucceedPayouts: TObjectList<TSucceedPayoutsDTO>;
  published
    property EarningStats: TObjectList<TEarningStatsDTO> read GetEarningStats;
    property ExpectedReward24H: Double read FExpectedReward24H write FExpectedReward24H;
    property ExpectedRewardWeek: Double read FExpectedRewardWeek write FExpectedRewardWeek;
    property PendingPayouts: TObjectList<TPendingPayoutsDTO> read GetPendingPayouts;
    property SucceedPayouts: TObjectList<TSucceedPayoutsDTO> read GetSucceedPayouts;
    property TotalUnpaid: Double read FTotalUnpaid write FTotalUnpaid;
    destructor Destroy; override;
  end;

implementation

{ TRootDTO }

destructor TRootHiveon.Destroy;
begin
  GetEarningStats.Free;
  GetPendingPayouts.Free;
  GetSucceedPayouts.Free;
  inherited;
end;

function TRootHiveon.GetEarningStats: TObjectList<TEarningStatsDTO>;
begin
  if not Assigned(FEarningStats) then
  begin
    FEarningStats := TObjectList<TEarningStatsDTO>.Create;
    FEarningStats.AddRange(FEarningStatsArray);
  end;
  Result := FEarningStats;
end;

function TRootHiveon.GetPendingPayouts: TObjectList<TPendingPayoutsDTO>;
begin
  if not Assigned(FPendingPayouts) then
  begin
    FPendingPayouts := TObjectList<TPendingPayoutsDTO>.Create;
    FPendingPayouts.AddRange(FPendingPayoutsArray);
  end;
  Result := FPendingPayouts;
end;

function TRootHiveon.GetSucceedPayouts: TObjectList<TSucceedPayoutsDTO>;
begin
  if not Assigned(FSucceedPayouts) then
  begin
    FSucceedPayouts := TObjectList<TSucceedPayoutsDTO>.Create;
    FSucceedPayouts.AddRange(FSucceedPayoutsArray);
  end;
  Result := FSucceedPayouts;
end;

end.

