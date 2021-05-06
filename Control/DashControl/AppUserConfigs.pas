unit AppUserConfigs;

interface

uses
  Pkg.Json.DTO, System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TTokenDTO = class
  private
    FId: Integer;
    FName: string;
    FValue: string;
  published
    property Id: Integer read FId write FId;
    property Name: string read FName write FName;
    property Value: string read FValue write FValue;
  end;

  TWalletDTO = class
  private
    FCoin: string;
    FId: Integer;
    FName: string;
    FPool: string;
  published
    property Coin: string read FCoin write FCoin;
    property Id: Integer read FId write FId;
    property Name: string read FName write FName;
    property Pool: string read FPool write FPool;
  end;

  TFiatDTO = class
  private
    FDesc: string;
    FId: Integer;
    FName: string;
  published
    property Desc: string read FDesc write FDesc;
    property Id: Integer read FId write FId;
    property Name: string read FName write FName;
  end;

  TRootAppConfig = class(TJsonDTO)
  private
    FAggregatePay: Boolean;
    FCrypto: string;
    FFiat: TFiatDTO;
    FMultipleAccount: Boolean;
    FPool: TArray<Boolean>;
    FPremium: Boolean;
    FPrivacy: Boolean;
    [JSONName('token')]
    FTokenArray: TArray<TTokenDTO>;
    [GenericListReflect]
    FToken: TObjectList<TTokenDTO>;
    [JSONName('wallet')]
    FWalletArray: TArray<TWalletDTO>;
    [GenericListReflect]
    FWallet: TObjectList<TWalletDTO>;
    function GetWallet: TObjectList<TWalletDTO>;
    function GetToken: TObjectList<TTokenDTO>;
  published
    property AggregatePay: Boolean read FAggregatePay write FAggregatePay;
    property Crypto: string read FCrypto write FCrypto;
    property Fiat: TFiatDTO read FFiat write FFiat;
    property MultipleAccount: Boolean read FMultipleAccount write FMultipleAccount;
    property Pool: TArray<Boolean> read FPool write FPool;
    property Premium: Boolean read FPremium write FPremium;
    property Privacy: Boolean read FPrivacy write FPrivacy;
    property Token: TObjectList<TTokenDTO> read GetToken;
    property Wallet: TObjectList<TWalletDTO> read GetWallet;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

{ TRootDTO }

constructor TRootAppConfig.Create;
begin
  inherited;
  FFiat := TFiatDTO.Create;
end;

destructor TRootAppConfig.Destroy;
begin
  FFiat.Free;
  GetWallet.Free;
  GetToken.Free;
  inherited;
end;

function TRootAppConfig.GetWallet: TObjectList<TWalletDTO>;
begin
  if not Assigned(FWallet) then
  begin
    FWallet := TObjectList<TWalletDTO>.Create;
    FWallet.AddRange(FWalletArray);
  end;
  Result := FWallet;
end;

function TRootAppConfig.GetToken: TObjectList<TTokenDTO>;
begin
  if not Assigned(FToken) then
  begin
    FToken := TObjectList<TTokenDTO>.Create;
    FToken.AddRange(FTokenArray);
  end;
  Result := FToken;
end;

end.
