unit CoibaseCurrencies;

interface

uses
  Pkg.Json.DTO, System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TDataDTO = class
  private
    FId: string;
    FMin_Size: string;
    FName: string;
  published
    property Id: string read FId write FId;
    property Min_Size: string read FMin_Size write FMin_Size;
    property Name: string read FName write FName;
  end;

  TRootCoinSuported = class(TJsonDTO)
  private
    [JSONName('data')]
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

destructor TRootCoinSuported.Destroy;
begin
  GetData.Free;
  inherited;
end;

function TRootCoinSuported.GetData: TObjectList<TDataDTO>;
begin
  if not Assigned(FData) then
  begin
    FData := TObjectList<TDataDTO>.Create;
    FData.AddRange(FDataArray);
  end;
  Result := FData;
end;

end.
