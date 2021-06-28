unit Coins;

interface

uses
  Pkg.Json.DTO, System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TDataDTO = class
  private
    FBase_Id: string;
    FName: string;
  published
    property Base_Id: string read FBase_Id write FBase_Id;
    property Name: string read FName write FName;
  end;

  TRootCoins = class(TJsonDTO)
  private
    [JSONName('coin')]
    FCoinArray: TArray<TDataDTO>;
    [GenericListReflect]
    FData: TObjectList<TDataDTO>;
    function GetCoin: TObjectList<TDataDTO>;
  published
    property data: TObjectList<TDataDTO> read GetCoin;
    destructor Destroy; override;
  end;

implementation

{ TRootDTO }

destructor TRootCoins.Destroy;
begin
  GetCoin.Free;
  inherited;
end;

function TRootCoins.GetCoin: TObjectList<TDataDTO>;
begin
  if not Assigned(FData) then
  begin
    FData := TObjectList<TDataDTO>.Create;
    FData.AddRange(FCoinArray);
  end;
  Result := FData;
end;

end.
