unit NicehashRig2;

interface

uses
  Pkg.Json.DTO, System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TPaginationDTO = class
  private
    FPage: Integer;
    FSize: Integer;
    FTotalPageCount: Integer;
  published
    property Page: Integer read FPage write FPage;
    property Size: Integer read FSize write FSize;
    property TotalPageCount: Integer read FTotalPageCount write FTotalPageCount;
  end;

  TAlgorithmDTO = class
  private
    FDescription: string;
    FEnumName: string;
  published
    property Description: string read FDescription write FDescription;
    property EnumName: string read FEnumName write FEnumName;
  end;

  TStatsDTO = class
  private
    FAlgorithm: TAlgorithmDTO;
    FDifficulty: Double;
    FMarket: string;
    FProfitability: Double;
    FProxyId: Integer;
    FSpeedAccepted: Double;
    FSpeedRejectedR1Target: Integer;
    FSpeedRejectedR2Stale: Integer;
    FSpeedRejectedR3Duplicate: Integer;
    FSpeedRejectedR4NTime: Integer;
    FSpeedRejectedR5Other: Integer;
    FSpeedRejectedTotal: Integer;
    FStatsTime: Int64;
    FTimeConnected: Int64;
    FUnpaidAmount: string;
    FXnsub: Boolean;
  published
    property Algorithm: TAlgorithmDTO read FAlgorithm write FAlgorithm;
    property Difficulty: Double read FDifficulty write FDifficulty;
    property Market: string read FMarket write FMarket;
    property Profitability: Double read FProfitability write FProfitability;
    property ProxyId: Integer read FProxyId write FProxyId;
    property SpeedAccepted: Double read FSpeedAccepted write FSpeedAccepted;
    property SpeedRejectedR1Target: Integer read FSpeedRejectedR1Target write FSpeedRejectedR1Target;
    property SpeedRejectedR2Stale: Integer read FSpeedRejectedR2Stale write FSpeedRejectedR2Stale;
    property SpeedRejectedR3Duplicate: Integer read FSpeedRejectedR3Duplicate write FSpeedRejectedR3Duplicate;
    property SpeedRejectedR4NTime: Integer read FSpeedRejectedR4NTime write FSpeedRejectedR4NTime;
    property SpeedRejectedR5Other: Integer read FSpeedRejectedR5Other write FSpeedRejectedR5Other;
    property SpeedRejectedTotal: Integer read FSpeedRejectedTotal write FSpeedRejectedTotal;
    property StatsTime: Int64 read FStatsTime write FStatsTime;
    property TimeConnected: Int64 read FTimeConnected write FTimeConnected;
    property UnpaidAmount: string read FUnpaidAmount write FUnpaidAmount;
    property Xnsub: Boolean read FXnsub write FXnsub;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TMiningRigsDTO = class
  private
    FLocalProfitability: Integer;
    FMinerStatus: string;
    FName: string;
    FProfitability: Double;
    FRigId: string;
    [JSONName('stats')]
    FStatsArray: TArray<TStatsDTO>;
    [GenericListReflect]
    FStats: TObjectList<TStatsDTO>;
    FStatusTime: Int64;
    FType: string;
    FUnpaidAmount: string;
    function GetStats: TObjectList<TStatsDTO>;
  published
    property LocalProfitability: Integer read FLocalProfitability write FLocalProfitability;
    property MinerStatus: string read FMinerStatus write FMinerStatus;
    property Name: string read FName write FName;
    property Profitability: Double read FProfitability write FProfitability;
    property RigId: string read FRigId write FRigId;
    property Stats: TObjectList<TStatsDTO> read GetStats;
    property StatusTime: Int64 read FStatusTime write FStatusTime;
    property &Type: string read FType write FType;
    property UnpaidAmount: string read FUnpaidAmount write FUnpaidAmount;
    destructor Destroy; override;
  end;

  TMiningRigGroupsDTO = class
  end;

  TDevicesStatusesDTO = class
  private
    FDISABLED: Integer;
    FMINING: Integer;
  published
    property DISABLED: Integer read FDISABLED write FDISABLED;
    property MINING: Integer read FMINING write FMINING;
  end;

  TRigTypesDTO = class
  private
    FMANAGED: Integer;
    FUNMANAGED: Integer;
  published
    property MANAGED: Integer read FMANAGED write FMANAGED;
    property UNMANAGED: Integer read FUNMANAGED write FUNMANAGED;
  end;

  TMinerStatusesDTO = class
  private
    FMINING: Integer;
  published
    property MINING: Integer read FMINING write FMINING;
  end;

  TRootNicehashRig2 = class(TJsonDTO)
  private
    FBtcAddress: string;
    FDevicesStatuses: TDevicesStatusesDTO;
    FExternalAddress: Boolean;
    FExternalBalance: Boolean;
    FGroupPowerMode: string;
    FLastPayoutTimestamp: TDateTime;
    FMinerStatuses: TMinerStatusesDTO;
    [JSONName('miningRigGroups')]
    FMiningRigGroupsArray: TArray<TMiningRigGroupsDTO>;
    [GenericListReflect]
    FMiningRigGroups: TObjectList<TMiningRigGroupsDTO>;
    [JSONName('miningRigs')]
    FMiningRigsArray: TArray<TMiningRigsDTO>;
    [GenericListReflect]
    FMiningRigs: TObjectList<TMiningRigsDTO>;
    FNextPayoutTimestamp: string;
    FPagination: TPaginationDTO;
    FPath: string;
    FRigNhmVersions: TArray<string>;
    FRigTypes: TRigTypesDTO;
    FTotalDevices: Integer;
    FTotalProfitability: Double;
    FTotalProfitabilityLocal: Double;
    FTotalRigs: Integer;
    FUnpaidAmount: string;
    function GetMiningRigGroups: TObjectList<TMiningRigGroupsDTO>;
    function GetMiningRigs: TObjectList<TMiningRigsDTO>;
  published
    property BtcAddress: string read FBtcAddress write FBtcAddress;
    property DevicesStatuses: TDevicesStatusesDTO read FDevicesStatuses write FDevicesStatuses;
    property ExternalAddress: Boolean read FExternalAddress write FExternalAddress;
    property ExternalBalance: Boolean read FExternalBalance write FExternalBalance;
    property GroupPowerMode: string read FGroupPowerMode write FGroupPowerMode;
    property LastPayoutTimestamp: TDateTime read FLastPayoutTimestamp write FLastPayoutTimestamp;
    property MinerStatuses: TMinerStatusesDTO read FMinerStatuses write FMinerStatuses;
    property MiningRigGroups: TObjectList<TMiningRigGroupsDTO> read GetMiningRigGroups;
    property MiningRigs: TObjectList<TMiningRigsDTO> read GetMiningRigs;
    property NextPayoutTimestamp: string read FNextPayoutTimestamp write FNextPayoutTimestamp;
    property Pagination: TPaginationDTO read FPagination write FPagination;
    property Path: string read FPath write FPath;
    property RigNhmVersions: TArray<string> read FRigNhmVersions write FRigNhmVersions;
    property RigTypes: TRigTypesDTO read FRigTypes write FRigTypes;
    property TotalDevices: Integer read FTotalDevices write FTotalDevices;
    property TotalProfitability: Double read FTotalProfitability write FTotalProfitability;
    property TotalProfitabilityLocal: Double read FTotalProfitabilityLocal write FTotalProfitabilityLocal;
    property TotalRigs: Integer read FTotalRigs write FTotalRigs;
    property UnpaidAmount: string read FUnpaidAmount write FUnpaidAmount;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

{ TStatsDTO }

constructor TStatsDTO.Create;
begin
  inherited;
  FAlgorithm := TAlgorithmDTO.Create;
end;

destructor TStatsDTO.Destroy;
begin
  FAlgorithm.Free;
  inherited;
end;

{ TMiningRigsDTO }

destructor TMiningRigsDTO.Destroy;
begin
  GetStats.Free;
  inherited;
end;

function TMiningRigsDTO.GetStats: TObjectList<TStatsDTO>;
begin
  if not Assigned(FStats) then
  begin
    FStats := TObjectList<TStatsDTO>.Create;
    FStats.AddRange(FStatsArray);
  end;
  Result := FStats;
end;

{ TRootDTO }

constructor TRootNicehashRig2.Create;
begin
  inherited;
  FMinerStatuses := TMinerStatusesDTO.Create;
  FRigTypes := TRigTypesDTO.Create;
  FDevicesStatuses := TDevicesStatusesDTO.Create;
  FPagination := TPaginationDTO.Create;
end;

destructor TRootNicehashRig2.Destroy;
begin
  FMinerStatuses.Free;
  FRigTypes.Free;
  FDevicesStatuses.Free;
  FPagination.Free;
  GetMiningRigGroups.Free;
  GetMiningRigs.Free;
  inherited;
end;

function TRootNicehashRig2.GetMiningRigGroups: TObjectList<TMiningRigGroupsDTO>;
begin
  if not Assigned(FMiningRigGroups) then
  begin
    FMiningRigGroups := TObjectList<TMiningRigGroupsDTO>.Create;
    FMiningRigGroups.AddRange(FMiningRigGroupsArray);
  end;
  Result := FMiningRigGroups;
end;

function TRootNicehashRig2.GetMiningRigs: TObjectList<TMiningRigsDTO>;
begin
  if not Assigned(FMiningRigs) then
  begin
    FMiningRigs := TObjectList<TMiningRigsDTO>.Create;
    FMiningRigs.AddRange(FMiningRigsArray);
  end;
  Result := FMiningRigs;
end;

end.
