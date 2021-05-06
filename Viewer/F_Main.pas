unit F_Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.ListBox, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani,
  FMXTee.Engine, FMXTee.Series, FMXTee.Series.OHLC, FMXTee.Series.Candle,
  FMXTee.Procs, FMXTee.Chart, FMX.Effects, FMX.Filter.Effects,ListFarm, WorkerinFarm,
  Dashboard, FMXTee.Series.ActivityGauge,
  FMXTee.Tools, FMXTee.Tools.PageNumber, FMXTee.Series.Donut, FMX.MultiView,
  FMX.Edit, Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components
   {$IFDEF Android}
    ,Androidapi.Helpers,FMX.Helpers.Android,
    Androidapi.JNI.GraphicsContentViewText
    {$ENDIF}
  ;

type
  TFrmPrincipal = class(TForm)
    rect_transicao: TRectangle;
    FloatAnimation1: TFloatAnimation;
    Rectangle1: TRectangle;
    Rec_gradient: TRectangle;
    Lay_content: TLayout;
    Lay_top: TLayout;
    Butt_doker: TButton;
    Lbl_Dashboard: TLabel;
    Butt_reload: TButton;
    FillRGBEffect1: TFillRGBEffect;
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
    Lay_NextPay: TLayout;
    Lbl_UnpaidAmountValue: TLabel;
    Lbl_UnpaidAmountCaption: TLabel;
    Lay_InPay: TLayout;
    Lbl_ProfitabilityValue: TLabel;
    Lbl_ProfitabilityCaption: TLabel;
    Chart_GPU: TChart;
    Lbl_Gputemp: TLabel;
    Series1: TDonutSeries;
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
    Swt_Binance: TSwitch;
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
    Lbl_currency: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    BindingsList1: TBindingsList;
    LinkFillControlToPropertyText: TLinkFillControlToProperty;
    LinkFillControlToPropertyText2: TLinkFillControlToProperty;
    LinkFillControlToPropertyText3: TLinkFillControlToProperty;
    procedure FloatAnimation1Finish(Sender: TObject);
    procedure OpenFormEfect;
    procedure FormCreate(Sender: TObject);
    procedure Butt_reloadClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Chart_GPUClickSeries(Sender: TCustomChart; Series: TChartSeries;
      ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer);
    procedure PrivacySwitchSwitch(Sender: TObject);
  private
    { Private declarations }
    series : TActivityGauge;
    HiveFarmList : TRootFarms;
    DashboardMain : TRootDash;

    Function  CreateDashboard(Token, Wallet : String) : boolean;
    Procedure ShowDashboard();
    Procedure CreateGauge ();
    procedure LoadCurrency;
  public
    { Public declarations }
    WorkerId : integer;
  end;

var
  FrmPrincipal: TFrmPrincipal;

   Const HiveToken = '';

   //Coins configuration
  Const hiveoncode = '';
  Const NiceWallet = '';


  Const HiveApi = 'https://api2.hiveos.farm/api/v2';
  Const NiceApi = 'https://api2.nicehash.com/main/api/v2';
  Const CoinbaseAPI = 'https://api.coinbase.com/v2';
  const HiveonAPI = 'https://hiveon.net/api/v1';




implementation

{$R *.fmx}

uses U_FarmStatistics, RESTRequest4D, Loading, CoibaseCurrency, AppUserConfigs,
      NicehashRig2,Hiveon, CoibaseCurrencies;

procedure TFrmPrincipal.OpenFormEfect;
begin
    rect_transicao.BringToFront;
    FloatAnimation1.Tag := 1;
    FloatAnimation1.Inverse := false;
    FloatAnimation1.StartValue := FrmPrincipal.Height + 500;
    FloatAnimation1.StopValue := 0;
    FloatAnimation1.Start;
end;

procedure TFrmPrincipal.PrivacySwitchSwitch(Sender: TObject);
begin
    LoadCurrency;
end;

procedure TFrmPrincipal.ShowDashboard;
begin
      CreateGauge();
      Lbl_HashValue.Text := DashboardMain.GetHashRate;
      Lbl_PowerValue.Text :=  DashboardMain.GetPower;
      Lbl_ASRValue.Text :=  DashboardMain.GetGpuStats;

      Lbl_UnpaidAmountValue.Text := formatfloat('0.00',DashboardMain.getUnpaidAmount *
         DashboardMain.GetFCurrencyPair);

      Lbl_ProfitabilityValue.Text := formatfloat('0.00',DashboardMain.getProfitability *
           DashboardMain.GetFCurrencyPair);
end;

procedure TFrmPrincipal.Butt_reloadClick(Sender: TObject);
begin
   CreateDashboard(HiveToken,NiceWallet);
end;

procedure TFrmPrincipal.Chart_GPUClickSeries(Sender: TCustomChart;
  Series: TChartSeries; ValueIndex: Integer; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   OpenFormEfect;
   WorkerId := DashboardMain.Farms[ValueIndex].Id;
   //showmessage(IntToStr(WorkerId));
end;

function TFrmPrincipal.CreateDashboard(Token, Wallet: String): boolean;
begin

  TLoading.Show(FrmPrincipal, 'Loading data');
  TThread.CreateAnonymousThread(procedure
      var
        LResponse: IResponse;
        i : integer;
        NiceHashRig2 : TRootNicehashRig2;
        Coibase : TRootCoinbase;
        SurpotedCurrency : TRootCoinSuported;
        Hiveon : TRootHiveon;
    begin
     // FarmList

         LResponse := TRequest.New.BaseURL( HiveApi +'/farms')
          .Accept('application/json')
          .Token('bearer '+token)
          .Get;
        if LResponse.StatusCode = 200 then
          begin

                if Assigned(HiveFarmList) then
                    HiveFarmList.Free;

                HiveFarmList := TRootFarms.Create;
                HiveFarmList.AsJson := LResponse.Content;

                if Assigned(DashboardMain) then
                      DashboardMain.Free;

                DashboardMain := TRootDash.Create;
        //for
          for I := 0 to pred(HiveFarmList.Data.Count) do
             begin
                 DashboardMain.HashRate:= HiveFarmList.Data[i].GetHashRate;
                 DashboardMain.PowerDraw:= HiveFarmList.Data[i].Stats.Power_Draw;
                 DashboardMain.ASR := HiveFarmList.Data[i].Stats.Asr;
                 DashboardMain.FarmOnline := HiveFarmList.Data[i].Stats.Rigs_Online;
                 DashboardMain.FarmOffiline := HiveFarmList.Data[i].Stats.Rigs_Offline;
                 DashboardMain.GpusTotal := HiveFarmList.Data[i].Stats.Gpus_Total;
                 DashboardMain.GpusOnline := HiveFarmList.Data[i].Stats.Gpus_Online;
                 DashboardMain.GpusOffline := HiveFarmList.Data[i].Stats.Gpus_Offline;
                 DashboardMain.GpusOverheated := HiveFarmList.Data[i].Stats.Gpus_Overheated;
                 DashboardMain.SetFarms(HiveFarmList.GetData);
             end;
          end;

      // GET in coibase
        LResponse := TRequest.New.BaseURL(CoinbaseAPI + '/prices/'
        +ComBx_Crypto.Items[ComBx_Crypto.ItemIndex]+'-'
        +ComBx_Currency.Items[ComBx_Currency.ItemIndex]+'/buy')
          .Accept('application/json')
          .Get;

        if LResponse.StatusCode = 200 then
          begin
              Coibase := TRootCoinbase.Create;
              Coibase.AsJson := LResponse.Content;
              DashboardMain.CurrencyPair := Coibase.Data.Amount;
          end;

      // GET in nicehash
     if Swt_Nicehash.IsChecked = true then
      begin
        LResponse := TRequest.New.BaseURL(NiceApi+'/mining/external/'+Wallet+'/rigs2')
          .Accept('application/json')
          .Get;

        if LResponse.StatusCode = 200 then
        begin
            NiceHashRig2 := TRootNicehashRig2.Create;
            NiceHashRig2.AsJson := LResponse.Content;
            DashboardMain.UnpaidAmount := NiceHashRig2.UnpaidAmount;
            DashboardMain.Profitability :=  NiceHashRig2.TotalProfitability;
        end;
       end
        else
      if Swt_Hiveon.IsChecked = true then
        begin
          // GET in Hiveon
              LResponse := TRequest.New.BaseURL(HiveonAPI + '/stats/miner/'+hiveoncode+
              '/ETH/billing-acc')
                .Accept('application/json')
                .Get;

              if LResponse.StatusCode = 200 then
              begin
                  Hiveon := TRootHiveon.Create;
                  Hiveon.AsJson := LResponse.Content;
                  DashboardMain.Profitability := Hiveon.ExpectedReward24H;
                  DashboardMain.UnpaidAmount :=  floattostr(Hiveon.TotalUnpaid);
              end;

      end;


      TThread.Synchronize(nil, procedure
      begin
              TLoading.Hide;
              ShowDashboard;
              NiceHashRig2.free;
              Coibase.Free;
              Hiveon.free;
      end);
    end).Start;

end;

procedure TFrmPrincipal.CreateGauge;
var i : integer;
begin
  Chart_GPU.Series[0].Clear;

  for I := 0 to pred(DashboardMain.Farms.Count) do
  begin
   With Chart_GPU.Series[0] do
      begin
        if DashboardMain.Farms[i].Stats.Workers_Online > 0 then

        add (DashboardMain.Farms[i].Id,DashboardMain.Farms[i].Name,DashboardMain.TfColor(i))
         else
         Add(DashboardMain.Farms[i].Id,DashboardMain.Farms[i].Name,TAlphaColor($57E36060))
      end;
       Lbl_Gputemp.Text := inttostr(DashboardMain.FarmOnline) +'/'+ inttostr(DashboardMain.Farms.Count);
  end;

end;

procedure TFrmPrincipal.LoadCurrency;

begin

TLoading.Show(FrmPrincipal, 'Loading price');

  TThread.CreateAnonymousThread(procedure
      var
        LResponse: IResponse;
        SurpotedCurrency : TRootCoinSuported;
  begin

      LResponse := TRequest.New.BaseURL(CoinbaseAPI + '/currencies')
        .Accept('application/json')
          .Get;
    if LResponse.StatusCode = 200 then
    begin
      SurpotedCurrency := TRootCoinSuported.Create;
      SurpotedCurrency.AsJson := LResponse.Content;
      ComBx_Currency.Items.Clear;
    end;

        TThread.Synchronize(nil, procedure
        var   i :integer;
      begin
        TLoading.Hide;

        for I := 0 to pred(SurpotedCurrency.Data.Count) do
          begin
            ComBx_Currency.Items.Add(SurpotedCurrency.Data[i].Id);
          end;

          SurpotedCurrency.Free;
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
    end;

    FloatAnimation1.Inverse := NOT FloatAnimation1.Inverse;
      if (NOT  FloatAnimation1.Inverse) then
             //  CreateDashboard(Token,Wallet)
             else
     //F_FarmStatistics.CreateWorker(token,IntToStr(DashboardMain.workerid));
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  {$IFDEF Android}
  CallInUIThreadAndWaitFinishing(
    procedure
    begin
      TAndroidHelper.Activity.getWindow.setStatusBarColor($FF4B2A4F);
    end
    );
    {$ENDIF}

    rect_transicao.Visible := true;
    rect_transicao.Margins.Top := FrmPrincipal.Height + 500;
end;

procedure TFrmPrincipal.FormDestroy(Sender: TObject);
begin
  if Assigned(DashboardMain) then
      DashboardMain.Free;
  HiveFarmList.Free;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  CreateDashboard(HiveToken,NiceWallet);
  // LoadCurrency;
end;

end.
