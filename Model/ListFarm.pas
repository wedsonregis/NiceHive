unit ListFarm;

interface

uses
  Pkg.Json.DTO, System.Generics.Collections, REST.Json.Types;

{$M+}

type
  THashratesDTO = class
  private
    FAlgo: string;
    FHashrate: Integer;
    procedure SetHashrate(const Value: Integer);

  published
    property Algo: string read FAlgo write FAlgo;
    property Hashrate: Integer read FHashrate write SetHashrate;
  end;

  TStatsDTO = class
  private
    FAsics_Offline: Integer;
    FAsics_Online: Integer;
    FAsics_Total: Integer;
    FAsr: Double;
    FBoards_Offline: Integer;
    FBoards_Online: Integer;
    FBoards_Overheated: Integer;
    FBoards_Total: Integer;
    FCpus_Online: Integer;
    FGpus_Offline: Integer;
    FGpus_Online: Integer;
    FGpus_Overheated: Integer;
    FGpus_Total: Integer;
    FPower_Draw: Integer;
    FRigs_Offline: Integer;
    FRigs_Online: Integer;
    FRigs_Total: Integer;
    FWorkers_Invalid: Integer;
    FWorkers_Low_Asr: Integer;
    FWorkers_Offline: Integer;
    FWorkers_Online: Integer;
    FWorkers_Overheated: Integer;
    FWorkers_Overloaded: Integer;
    FWorkers_Total: Integer;
  published
    property Asics_Offline: Integer read FAsics_Offline write FAsics_Offline;
    property Asics_Online: Integer read FAsics_Online write FAsics_Online;
    property Asics_Total: Integer read FAsics_Total write FAsics_Total;
    property Asr: Double read FAsr write FAsr;
    property Boards_Offline: Integer read FBoards_Offline write FBoards_Offline;
    property Boards_Online: Integer read FBoards_Online write FBoards_Online;
    property Boards_Overheated: Integer read FBoards_Overheated write FBoards_Overheated;
    property Boards_Total: Integer read FBoards_Total write FBoards_Total;
    property Cpus_Online: Integer read FCpus_Online write FCpus_Online;
    property Gpus_Offline: Integer read FGpus_Offline write FGpus_Offline;
    property Gpus_Online: Integer read FGpus_Online write FGpus_Online;
    property Gpus_Overheated: Integer read FGpus_Overheated write FGpus_Overheated;
    property Gpus_Total: Integer read FGpus_Total write FGpus_Total;
    property Power_Draw: Integer read FPower_Draw write FPower_Draw;
    property Rigs_Offline: Integer read FRigs_Offline write FRigs_Offline;
    property Rigs_Online: Integer read FRigs_Online write FRigs_Online;
    property Rigs_Total: Integer read FRigs_Total write FRigs_Total;
    property Workers_Invalid: Integer read FWorkers_Invalid write FWorkers_Invalid;
    property Workers_Low_Asr: Integer read FWorkers_Low_Asr write FWorkers_Low_Asr;
    property Workers_Offline: Integer read FWorkers_Offline write FWorkers_Offline;
    property Workers_Online: Integer read FWorkers_Online write FWorkers_Online;
    property Workers_Overheated: Integer read FWorkers_Overheated write FWorkers_Overheated;
    property Workers_Overloaded: Integer read FWorkers_Overloaded write FWorkers_Overloaded;
    property Workers_Total: Integer read FWorkers_Total write FWorkers_Total;
  end;

  TDataFarmDTO = class
  private
    [JSONName('hashrates')]
    FHashratesArray: TArray<THashratesDTO>;
    [GenericListReflect]
    FHashrates: TObjectList<THashratesDTO>;
    FId: Integer;
    FName: string;
    FRigs_Count: Integer;
    FStats: TStatsDTO;
    FWorkers_Count: Integer;
    function GetHashrates: TObjectList<THashratesDTO>;
  published
    property Hashrates: TObjectList<THashratesDTO> read GetHashrates;
    property Id: Integer read FId write FId;
    property Name: string read FName write FName;
    property Rigs_Count: Integer read FRigs_Count write FRigs_Count;
    property Stats: TStatsDTO read FStats write FStats;
    property Workers_Count: Integer read FWorkers_Count write FWorkers_Count;
  public
    constructor Create;
    destructor Destroy; override;
    function GetHashRate():integer;
  end;

  TRootFarms = class(TJsonDTO)
  private
    [JSONName('data')]
    FDataArray: TArray<TDataFarmDTO>;
    [GenericListReflect]
    FData: TObjectList<TDataFarmDTO>;

  published
    function GetData: TObjectList<TDataFarmDTO>;
    property Data: TObjectList<TDataFarmDTO> read GetData;
    destructor Destroy; override;

  end;

implementation

uses
  System.SysUtils;

{ TDataDTO }

constructor TDataFarmDTO.Create;
begin
  inherited;
  FStats := TStatsDTO.Create;
end;

destructor TDataFarmDTO.Destroy;
begin
  FStats.Free;
  GetHashrates.Free;
  inherited;
end;

function TDataFarmDTO.GetHashrate: integer;
var
  i,hash :integer;
begin
    result:=0;
    hash:=0;

    for I := 0 to GetHashrates.Count -1 do
      begin
        hash:= hash + GetHashrates[i].FHashrate;
      end;
    result := hash;
end;

function TDataFarmDTO.GetHashRates: TObjectList<THashratesDTO>;
begin
  if not Assigned(FHashrates) then
  begin
    FHashrates := TObjectList<THashratesDTO>.Create;

    if Assigned(FHashratesArray) then
        FHashrates.AddRange(FHashratesArray)
          else
        FHashrates.Add(THashratesDTO.Create)
  end;
  Result := FHashrates;
end;

{ TRootDTO }

destructor TRootFarms.Destroy;
begin
  GetData.Free;
  inherited;
end;

function TRootFarms.GetData: TObjectList<TDataFarmDTO>;
begin
  if not Assigned(FData) then
  begin
    FData := TObjectList<TDataFarmDTO>.Create;
    FData.AddRange(FDataArray);
  end;
  Result := FData;
end;



{ THashratesDTO }

procedure THashratesDTO.SetHashrate(const Value: Integer);
begin
    FHashrate := Value;
end;

end.
