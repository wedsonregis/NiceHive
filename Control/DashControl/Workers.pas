unit Workers;

interface

uses
  System.SysUtils, System.UITypes, Pkg.Json.DTO, System.Generics.Collections, REST.Json.Types, WorkerinFarm;

{$M+}

type
  TRootWorkers = class
  private
    FID: integer;
    FWorkerListArray: TArray<TDataWorkerDTO>;
    FWorkerList: TObjectList<TDataWorkerDTO>;
    FTempMax: Integer;
    //Mining stats shared
    FShareAccepted: Integer;
    FShareInvalid: Integer;
    FShareRatio: Double;
    FShareTotal: Integer;
    FShareRejected: Integer;

    procedure SetTempMax(const Value: Integer);
    procedure SetShareAccepted(const Value: Integer);
    procedure SetShareInvalid(const Value: Integer);
    procedure SetShareRatio(const Value: Double);
    procedure SetShareRejected(const Value: Integer);
    procedure SetShareTotal(const Value: Integer);

 Public
    procedure SetWorkerList(const Value: TObjectList<TDataWorkerDTO>);
    Function  GetData: TObjectList<TDataWorkerDTO>;

  published
    property ID : integer read FID write FID;
    Property TempMax : Integer read FTempMax write SetTempMax;

    property ShareAccepted: Integer read FShareAccepted write SetShareAccepted;
    property ShareInvalid: Integer read FShareInvalid write SetShareInvalid;
    property ShareRatio: Double read FShareRatio write SetShareRatio;
    property ShareRejected: Integer read FShareRejected write SetShareRejected;
    property ShareTotal: Integer read FShareTotal write SetShareTotal;

    Property WorkerList : TObjectList<TDataWorkerDTO> read FWorkerList write SetWorkerList;
    //
    destructor Destroy;
    constructor Create();

    class function TfColor(temp: integer): TAlphaColor;
    class Function TempColor(temp: integer): TAlphaColor;

  end;

implementation





{ TFarmsDTO }

constructor TRootWorkers.Create;
begin
  Fid := 0;
  FTempMax := 0;
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

procedure TRootWorkers.SetShareAccepted(const Value: Integer);
begin
  FShareAccepted := Value;
end;

procedure TRootWorkers.SetShareInvalid(const Value: Integer);
begin
  FShareInvalid := Value;
end;

procedure TRootWorkers.SetShareRatio(const Value: Double);
begin
  FShareRatio := Value;
end;

procedure TRootWorkers.SetShareRejected(const Value: Integer);
begin
  FShareRejected := Value;
end;

procedure TRootWorkers.SetShareTotal(const Value: Integer);
begin
  FShareTotal := Value;
end;

procedure TRootWorkers.SetTempMax(const Value: Integer);
begin
    if Value > FTempMax then
        FTempMax := Value;
end;

procedure TRootWorkers.SetWorkerList(const Value: TObjectList<TDataWorkerDTO>);
begin
  FWorkerList := Value;
end;

class function TRootWorkers.TempColor(temp: integer): TAlphaColor;
begin

 if (temp >20) and (temp < 30) then
      result := $78f3ea8d
    else
  if (temp >=30) and (temp < 40) then
      result := $78f3ea8d
    else
  if (temp >=40) and (temp < 45) then
      result := $78f39c35
  else
    if (temp >=45) and (temp < 50) then
      result := $78f5811c
    else
  if (temp >=50) and (temp < 55) then
      result := $78f36b15
    else
  if (temp >=55) and (temp < 60) then
      result := $78f14c14
    else
  if (temp >=60) and (temp < 65) then
      result := $78e6180a
    else
  if (temp >=65) and (temp < 99) then
      result := $78b3080e
    else
    result := $FF8d5d80;
end;

class function TRootWorkers.TfColor(temp: integer): TAlphaColor;
begin
 if (temp >20) and (temp < 50) then
      result := $FF667765
    else
  if (temp >=50) and (temp < 80) then
      result := $FFa67a2d
    else
  if (temp >=80) and (temp < 100) then
      result := $78b35664
  else
      result := $FF8d5d80;
end;



end.