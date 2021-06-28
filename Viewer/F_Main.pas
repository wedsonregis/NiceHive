unit F_Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.ListBox, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani,
  FMXTee.Engine, FMXTee.Series, FMXTee.Series.OHLC, FMXTee.Series.Candle,
  FMXTee.Procs, FMXTee.Chart, FMX.Effects, FMX.Filter.Effects,
  FMXTee.Series.ActivityGauge,
  FMXTee.Tools, FMXTee.Tools.PageNumber, FMXTee.Series.Donut, FMX.MultiView,
  FMX.Edit, Data.Bind.EngExt, FMX.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.Components,
  System.IOUtils,
  Dashboard, ListFarm, FlightSheet, PoolSettings, Coins,
  RESTRequest4D, Loading, AppUserConfigs,WorkerinFarm
  ;

type
  TFrmPrincipal = class(TForm)
    rect_transicao: TRectangle;
    FloatAnimation1: TFloatAnimation;
    Rectangle1: TRectangle;
    Rec_gradient: TRectangle;
    Lay_top: TLayout;
    Butt_doker: TButton;
    Lbl_Dashboard: TLabel;
    Butt_reload: TButton;
    FillRGBEffect1: TFillRGBEffect;
    StyleBook1: TStyleBook;
    MultiView1: TMultiView;
    VertScrollBox1: TVertScrollBox;
    PoolMiningLayout: TLayout;
    PrivacyLayout: TLayout;
    PrivacyLabel: TLabel;
    PrivacySwitch: TSwitch;
    PrivacyImage: TImage;
    FillRGBEffect3: TFillRGBEffect;
    AggregateLayout: TLayout;
    CloudLabel: TLabel;
    CloudImage: TImage;
    FillRGBEffect5: TFillRGBEffect;
    label4: TLabel;
    Swt_Nicehash: TSwitch;
    Swt_Hiveon: TSwitch;
    Label3: TLabel;
    Label2: TLabel;
    Swt_2miners: TSwitch;
    Label1: TLabel;
    Image2: TImage;
    FillRGBEffect8: TFillRGBEffect;
    CurrencyLayout: TLayout;
    Label5: TLabel;
    Image3: TImage;
    ComBx_Currency: TComboBox;
    FillRGBEffect2: TFillRGBEffect;
    CryptoLayout: TLayout;
    Label6: TLabel;
    Image1: TImage;
    ComBx_Crypto: TComboBox;
    FillRGBEffect4: TFillRGBEffect;
    FillRGBEffect6: TFillRGBEffect;
    FillRGBEffect7: TFillRGBEffect;
    BotomLayout: TLayout;
    Image4: TImage;
    FillRGBEffect9: TFillRGBEffect;
    Label7: TLabel;
    Layout1: TLayout;
    Label8: TLabel;
    Switch1: TSwitch;
    Image5: TImage;
    FillRGBEffect10: TFillRGBEffect;
    Layout2: TLayout;
    Label9: TLabel;
    Switch2: TSwitch;
    Image6: TImage;
    FillRGBEffect11: TFillRGBEffect;
    Image7: TImage;
    FillRGBEffect12: TFillRGBEffect;
    BindingsList1: TBindingsList;
    LinkFillControlToPropertyText: TLinkFillControlToProperty;
    LinkFillControlToPropertyText2: TLinkFillControlToProperty;
    LinkFillControlToPropertyText3: TLinkFillControlToProperty;
    Label12: TLabel;
    Swt_NanoPool: TSwitch;
    Lay_content: TLayout;
    Chart_line: TChart;
    Series4: TCandleSeries;
    Lay_bottom: TLayout;
    FlowLay_botom: TFlowLayout;
    Lay_Hashrate: TLayout;
    Lbl_HashValue: TLabel;
    Lbl_HashCaption: TLabel;
    Lay_Power: TLayout;
    Lbl_PowerValue: TLabel;
    Lbl_PowerCaption: TLabel;
    Lay_Asr: TLayout;
    Lbl_ASRValue: TLabel;
    Lbl_ASRCaption: TLabel;
    Layout5: TLayout;
    FlowLay_Top: TFlowLayout;
    Lay_Wallet: TLayout;
    Lbl_WalletValue: TLabel;
    Lbl_WalletCaption: TLabel;
    Label11: TLabel;
    Label14: TLabel;
    Lay_NextPay: TLayout;
    Lbl_UnpaidAmountValue: TLabel;
    Lbl_UnpaidAmountCaption: TLabel;
    Label10: TLabel;
    Lbl_UnpaidAmountBtc: TLabel;
    Lay_InPay: TLayout;
    Lbl_ProfitabilityValue: TLabel;
    Lbl_ProfitabilityCaption: TLabel;
    Lbl_currency: TLabel;
    Lbl_ProfitabilityBtc: TLabel;
    Chart_GPU: TChart;
    Lbl_Gputemp: TLabel;
    Label15: TLabel;
    Series1: TDonutSeries;
    ChartTool1: TPageNumTool;
    procedure FloatAnimation1Finish(Sender: TObject);
    procedure OpenFormEfect;
    procedure Butt_reloadClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Chart_GPUClickSeries(Sender: TCustomChart; Series: TChartSeries;
      ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function LoadJsonConfigs(const FileName: TFileName): String;
    function ParseDelimite(str: String; index: Integer): string;
    Function CreateDashboard(Token: string): boolean;

    procedure GaugCreate;
    procedure SetLabelDash;
    procedure GetPool;
    procedure GetRig(Token: string);
    procedure GetCoinbase();
  public
    { Public declarations }
    HiveFarmList: TRootFarms;
    DashboardMain: TRootDash;
  end;

type
  TGlobalConfig = record
    poolId: Integer;
    coinId: Integer;
    pool: TRootPoolSettings;
    coin: TRootCoins;
    fs: TRootFlightSheet;
  end;

var
  FrmPrincipal: TFrmPrincipal;
  Config: TGlobalConfig;

Const
  HiveToken = '';

  // Coins configuration
Const
  HiveApi = 'https://api2.hiveos.farm/api/v2';

Const
  CoinbaseAPI = 'https://www.coinbase.com/api/v2';

implementation

{$R *.fmx}

uses U_FarmStatistics, System.JSON, F_Wallet;

procedure TFrmPrincipal.OpenFormEfect;
begin
  rect_transicao.BringToFront;
  FloatAnimation1.Tag := 1;
  FloatAnimation1.Inverse := false;
  FloatAnimation1.StartValue := FrmPrincipal.Height + 500;
  FloatAnimation1.StopValue := 0;
  FloatAnimation1.Start;
end;

function TFrmPrincipal.ParseDelimite(str: String; index: Integer): string;
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  sl.Delimiter := '|';
  sl.DelimitedText := str;
  result := sl[index];
  sl.Free;
end;

function TFrmPrincipal.LoadJsonConfigs(const FileName: TFileName): String;
var
  LStrings: TStringList;
begin
  LStrings := TStringList.Create;
  try
    LStrings.Loadfromfile(TPath.GetDocumentsPath + PathDelim + FileName);
    result := LStrings.text;
  finally
    FreeAndNil(LStrings);
  end;
end;

procedure TFrmPrincipal.GaugCreate;
var
  i: Integer;
begin
  Chart_GPU.Series[0].Clear;
  for i := 0 to pred(DashboardMain.Farms.Count) do
  begin
    with Chart_GPU.Series[0] do
    begin
      if DashboardMain.Farms[i].Stats.Workers_Online > 0 then
        add(DashboardMain.Farms[i].ID, DashboardMain.Farms[i].Name,
          DashboardMain.TfColor(i))
      else
        add(DashboardMain.Farms[i].ID, DashboardMain.Farms[i].Name,
          TAlphaColor($57E36060));
    end;
    Lbl_Gputemp.text := inttostr(DashboardMain.FarmOnline) + '/' +
      inttostr(DashboardMain.Farms.Count);
  end;
end;

procedure TFrmPrincipal.SetLabelDash;
begin
  Lbl_HashValue.text := DashboardMain.GetHashRate;
  Lbl_PowerValue.text := DashboardMain.GetPower;
  Lbl_ASRValue.text := DashboardMain.GetGpuStats;

  Lbl_UnpaidAmountValue.text := formatfloat('0.00',
    DashboardMain.getUnpaidAmount * DashboardMain.GetFCurrencyPair);
  Lbl_ProfitabilityValue.text := formatfloat('0.00',
    DashboardMain.getProfitability * DashboardMain.GetFCurrencyPair);
  Lbl_ProfitabilityBtc.text := formatfloat('0.00000',
    DashboardMain.getProfitability);
  Lbl_UnpaidAmountBtc.text := formatfloat('0.00000',
    DashboardMain.getUnpaidAmount);
end;

procedure TFrmPrincipal.GetCoinbase;
var
  LResponse: IResponse;
  JSonValue: TJSonValue;
  st: string;
begin
  LResponse := TRequest.New.BaseURL(CoinbaseAPI + '/assets/prices/' +
    Config.coin.Data[Config.coinId].Base_Id + '?base=' + ComBx_Currency.Items
    [ComBx_Currency.ItemIndex]).Accept('application/json').Get;
  if LResponse.StatusCode = 200 then
  begin
    st := LResponse.Content;
    JSonValue := TJSonObject.ParseJSONValue(st);
    DashboardMain.CurrencyPair := JSonValue.GetValue<string>
      ('data.prices.latest');
    JSonValue.Free;
  end;
end;

procedure TFrmPrincipal.GetPool;
var
  i: Integer;
  LResponse: IResponse;
  JSonValue: TJSonValue;
  st: string;
begin
  for i := 0 to pred(Config.fs.Data.Count) do
  begin
    if Config.fs.Data[i].Acctive = true then
    begin
      Config.poolId := Config.fs.Data[i].poolId;
      Config.coinId := Config.fs.Data[i].coinId;

      LResponse := TRequest.New.BaseURL
        (format(Config.pool.Data[Config.poolId].Expression,
        [Config.pool.Data[Config.poolId].Urlpool, Config.fs.Data[i].Wallet]))
        .Accept('application/json').Get;
      if LResponse.StatusCode = 200 then
      begin
        st := LResponse.Content;
        JSonValue := TJSonObject.ParseJSONValue(st);
        // Balance
        if (ParseDelimite(Config.pool.Data[Config.poolId].Balance, 0) = 'i')
        then
          DashboardMain.Profitability := JSonValue.GetValue<Double>
            (ParseDelimite(Config.pool.Data[Config.poolId].Balance, 1)) /
            1000000000
        else if (ParseDelimite(Config.pool.Data[Config.poolId].Balance, 0) = 'b')
        then
          DashboardMain.Profitability := JSonValue.GetValue<Double>
            (ParseDelimite(Config.pool.Data[Config.poolId].Balance, 1)) /
            1000000000000000000
        else if (ParseDelimite(Config.pool.Data[Config.poolId].Balance, 0) = 'f')
        then
          DashboardMain.Profitability := JSonValue.GetValue<Double>
            (ParseDelimite(Config.pool.Data[Config.poolId].Balance, 1));

        // Balance_Unconfirmed
        if ParseDelimite(Config.pool.Data[Config.poolId].Balance_Unconfirmed, 0)
          = 'i' then
          DashboardMain.UnpaidAmount := JSonValue.GetValue<Double>
            (ParseDelimite(Config.pool.Data[Config.poolId].Balance_Unconfirmed,
            1)) / 1000000000
        else if ParseDelimite(Config.pool.Data[Config.poolId]
          .Balance_Unconfirmed, 0) = 'b' then
          DashboardMain.UnpaidAmount := JSonValue.GetValue<Double>
            (ParseDelimite(Config.pool.Data[Config.poolId].Balance_Unconfirmed,
            1)) / 1000000000000000000
        else if ParseDelimite(Config.pool.Data[Config.poolId]
          .Balance_Unconfirmed, 0) = 'f' then
          DashboardMain.UnpaidAmount := JSonValue.GetValue<Double>
            (ParseDelimite(Config.pool.Data[Config.poolId]
            .Balance_Unconfirmed, 1));
        JSonValue.Free;
      end;

    end;
  end;
end;

procedure TFrmPrincipal.GetRig(Token: string);
var
  LResponse: IResponse;
begin
  LResponse := TRequest.New.BaseURL(HiveApi + '/farms')
    .Accept('application/json').Token('bearer ' + Token).Get;
  if LResponse.StatusCode = 200 then
  begin
    if Assigned(HiveFarmList) then
      HiveFarmList.Free;

    if Assigned(DashboardMain) then
      DashboardMain.Free;

    HiveFarmList := TRootFarms.Create;
    HiveFarmList.AsJson := LResponse.Content;
    DashboardMain := TRootDash.Create(HiveFarmList);
  end;
end;

procedure TFrmPrincipal.Butt_reloadClick(Sender: TObject);
begin
  CreateDashboard(HiveToken);
end;

procedure TFrmPrincipal.Chart_GPUClickSeries(Sender: TCustomChart;
  Series: TChartSeries; ValueIndex: Integer; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  OpenFormEfect;
  DashboardMain.ID := DashboardMain.Farms[ValueIndex].ID;
end;

// create informations
function TFrmPrincipal.CreateDashboard(Token: string): boolean;
begin
  TLoading.Show(FrmPrincipal, 'Loading data');
  TThread.CreateAnonymousThread(
    procedure
    begin
      // Get Rigs
      GetRig(Token);
      // Get pool information
      GetPool();
      // Get Coinbase
      GetCoinbase();

      TThread.Synchronize(nil,
        procedure
        begin
          TLoading.Hide;
          GaugCreate;
          SetLabelDash;
        end);
    end).Start;

end;

procedure TFrmPrincipal.FloatAnimation1Finish(Sender: TObject);
begin
  if FloatAnimation1.Tag = 1 then
  begin
    FloatAnimation1.Tag := 0;

    if NOT Assigned(F_FarmStatistics) then
      Application.CreateForm(TF_FarmStatistics, F_FarmStatistics);
    F_FarmStatistics.Show;
    {
      if NOT Assigned(F_flaghtSheet) then
      Application.CreateForm(TF_flaghtSheet, F_flaghtSheet);
      F_flaghtSheet.Show;
    }
  end;

  FloatAnimation1.Inverse := NOT FloatAnimation1.Inverse;
  if (NOT FloatAnimation1.Inverse) then
    // CreateDashboard(Token,Wallet)
  else
    // F_FarmStatistics.CreateWorker(token,IntToStr(DashboardMain.workerid));
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  rect_transicao.Visible := true;
  rect_transicao.Margins.Top := FrmPrincipal.Height + 500;
  try
  // Load configuration
    Config.fs := TRootFlightSheet.Create;
    Config.fs.AsJson := LoadJsonConfigs('flaghtsheet.json');
    Config.pool := TRootPoolSettings.Create;
    Config.pool.AsJson := LoadJsonConfigs('pool.json');
    Config.coin := TRootCoins.Create;
    Config.coin.AsJson := LoadJsonConfigs('coin.json');
  Except
    on E: Exception do
    begin
      TLoading.Hide;
      ShowMessage('Erro: ' + E.Message);
    end;
  end;
end;

procedure TFrmPrincipal.FormDestroy(Sender: TObject);
begin
  if Assigned(DashboardMain) then
    DashboardMain.Free;

    HiveFarmList.Free;
    Config.fs.Free;
    Config.pool.Free;
    Config.coin.Free;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  CreateDashboard(HiveToken);
end;

end.
