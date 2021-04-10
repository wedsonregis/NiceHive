unit CoibaseCurrency;

interface

uses
  Pkg.Json.DTO, System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TDataDTO = class
  private
    FAmount: string;
    FBase: string;
    FCurrency: string;
  published
    property Amount: string read FAmount write FAmount;
    property Base: string read FBase write FBase;
    property Currency: string read FCurrency write FCurrency;
  end;

  TRootCoinbase = class(TJsonDTO)
  private
    FData: TDataDTO;
  published
    property Data: TDataDTO read FData write FData;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

{ TRootDTO }

constructor TRootCoinbase.Create;
begin
  inherited;
  FData := TDataDTO.Create;
end;

destructor TRootCoinbase.Destroy;
begin
  FData.Free;
  inherited;
end;

end.