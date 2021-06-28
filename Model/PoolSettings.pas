unit PoolSettings;

interface

uses
  Pkg.Json.DTO, System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TDataDTO = class
  private
    FBalance: string;
    FBalance_Unconfirmed: string;
    FExpression: string;
    FMin_Payout: Integer;
    FName: string;
    FUrlpool: string;
  published
    property Balance: string read FBalance write FBalance;
    property Balance_Unconfirmed: string read FBalance_Unconfirmed
      write FBalance_Unconfirmed;
    property Expression: string read FExpression write FExpression;
    property Min_Payout: Integer read FMin_Payout write FMin_Payout;
    property Name: string read FName write FName;
    property Urlpool: string read FUrlpool write FUrlpool;
  end;

  TRootPoolSettings = class(TJsonDTO)
  private
    [JSONName('pool')]
    FPoolArray: TArray<TDataDTO>;
    [GenericListReflect]
    FPool: TObjectList<TDataDTO>;
    function GetPool: TObjectList<TDataDTO>;
  published
    property data: TObjectList<TDataDTO> read GetPool;
    destructor Destroy; override;
  end;

implementation

{ TRootDTO }

destructor TRootPoolSettings.Destroy;
begin
  GetPool.Free;
  inherited;
end;

function TRootPoolSettings.GetPool: TObjectList<TDataDTO>;
begin
  if not Assigned(FPool) then
  begin
    FPool := TObjectList<TDataDTO>.Create;
    FPool.AddRange(FPoolArray);
  end;
  Result := FPool;
end;

end.
