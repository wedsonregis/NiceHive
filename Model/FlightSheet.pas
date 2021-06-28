unit FlightSheet;

interface

uses
  Pkg.Json.DTO, System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TDataDTO = class
  private
    FAcctive: Boolean;
    FCoinid: Integer;
    FId: Integer;
    FPoolid: Integer;
    FWallet: string;
  published
    property Acctive: Boolean read FAcctive write FAcctive;
    property Coinid: Integer read FCoinid write FCoinid;
    property Id: Integer read FId write FId;
    property Poolid: Integer read FPoolid write FPoolid;
    property Wallet: string read FWallet write FWallet;
  end;

  TRootFlightSheet = class(TJsonDTO)
  private
    [JSONName('flightsheet')]
    FDataArray: TArray<TDataDTO>;
    [GenericListReflect]
    FData: TObjectList<TDataDTO>;
    function GetData: TObjectList<TDataDTO>;
  published
    property Data: TObjectList<TDataDTO> read GetData;
    destructor Destroy; override;
  end;

implementation

{ TRootDTO }

destructor TRootFlightSheet.Destroy;
begin
  GetData.Free;
  inherited;
end;

function TRootFlightSheet.GetData: TObjectList<TDataDTO>;
begin
  if not Assigned(FData) then
  begin
    FData := TObjectList<TDataDTO>.Create;
    FData.AddRange(FDataArray);
  end;
  Result := FData;
end;

end.
