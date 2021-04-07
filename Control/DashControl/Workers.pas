unit Workers;

interface

uses
  Pkg.Json.DTO, System.Generics.Collections, REST.Json.Types, WorkerinFarm,
  System.UITypes;

{$M+}

type
  TRootWorkers = class
  private
    FID: integer;
    FWorkerListArray: TArray<TDataWorkerDTO>;
    FWorkerList: TObjectList<TDataWorkerDTO>;

 Public
    procedure SetWorkerList(const Value: TObjectList<TDataWorkerDTO>);
    Function  GetData: TObjectList<TDataWorkerDTO>;

  published
    property ID : integer read FID write FID;
    Property WorkerList : TObjectList<TDataWorkerDTO> read FWorkerList write SetWorkerList;
    //
    destructor Destroy;
    constructor Create();

  end;

implementation

uses
  System.SysUtils;

{ TFarmsDTO }

constructor TRootWorkers.Create;
begin
  Fid := 0;
end;

destructor TRootWorkers.Destroy;
begin
   GetData.Free;
  inherited;
end;



function TRootWorkers.GetData: TObjectList<TDataWorkerDTO>;
begin
  if not Assigned(FWorkerList) then
  begin
    FWorkerList := TObjectList<TDataWorkerDTO>.Create;
    FWorkerList.AddRange(FWorkerListArray);
  end;
  Result := FWorkerList;
end;

procedure TRootWorkers.SetWorkerList(const Value: TObjectList<TDataWorkerDTO>);
begin
  FWorkerList := Value;
end;

end.