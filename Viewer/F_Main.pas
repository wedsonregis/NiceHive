unit F_Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.ListBox, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani,
  FMXTee.Engine, FMXTee.Series, FMXTee.Series.OHLC, FMXTee.Series.Candle,
  FMXTee.Procs, FMXTee.Chart, FMX.Effects, FMX.Filter.Effects,ListFarm, WorkerinFarm,
  Dashboard, FMXTee.Series.ActivityGauge, NicehashRig2
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
    Rec_ground: TRectangle;
    Rec_gradient: TRectangle;
    Lay_content: TLayout;
    Lay_top: TLayout;
    Butt_doker: TButton;
    Lbl_Dashboard: TLabel;
    Butt_reload: TButton;
    FillRGBEffect1: TFillRGBEffect;
    Chart_line: TChart;
    Series4: TCandleSeries;
    Chart_Gauge: TChart;
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
    procedure FloatAnimation1Finish(Sender: TObject);
    procedure OpenFormEfect;
    procedure FormCreate(Sender: TObject);
    procedure Butt_reloadClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Chart_GaugeClickSeries(Sender: TCustomChart; Series: TChartSeries;
      ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
    series : TActivityGauge;
    DashboardMain : TRootDash;
    Function  CreateDashboard(Token, Wallet : String) : boolean;
    Procedure ShowDashboard();
    Procedure CreateGauge ();
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

  Const Token = 'Your Toke Hiveos';
  Const wallet = 'Your wallet mining Nicehash';


  Const HiveApi = 'https://api2.hiveos.farm/api/v2';
  Const NiceApi = 'https://api2.nicehash.com/main/api/v2';

implementation

{$R *.fmx}

uses U_FarmStatistics, RESTRequest4D, Loading;

procedure TFrmPrincipal.OpenFormEfect;
begin
    rect_transicao.BringToFront;
    FloatAnimation1.Tag := 1;
    FloatAnimation1.Inverse := false;
    FloatAnimation1.StartValue := FrmPrincipal.Height + 500;
    FloatAnimation1.StopValue := 0;
    FloatAnimation1.Start;
end;

procedure TFrmPrincipal.ShowDashboard;
begin
      CreateGauge();
      Lbl_HashValue.Text := DashboardMain.GetHashRate;
      Lbl_PowerValue.Text :=  DashboardMain.GetPower;
      Lbl_ASRValue.Text :=  DashboardMain.GetGpuStats;

      Lbl_UnpaidAmountValue.Text := 'R$'+formatfloat('0.00',DashboardMain.getUnpaidAmount * 332095.44);
      Lbl_ProfitabilityValue.Text :=  'R$'+formatfloat('0.00',DashboardMain.getProfitability * 332095.44);
end;

procedure TFrmPrincipal.Butt_reloadClick(Sender: TObject);
begin
   CreateDashboard(Token,Wallet);
end;

procedure TFrmPrincipal.Chart_GaugeClickSeries(Sender: TCustomChart;
  Series: TChartSeries; ValueIndex: Integer; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    OpenFormEfect;
end;

function TFrmPrincipal.CreateDashboard(Token, Wallet: String): boolean;
begin

  TLoading.Show(FrmPrincipal, 'Loading data');
  TThread.CreateAnonymousThread(procedure
      var
        LResponse: IResponse;
        i : integer;
        NiceHashRig2 : TRootNicehashRig2;
        HiveFarmList : TRootFarms;
    begin
     // FarmList

         LResponse := TRequest.New.BaseURL( HiveApi +'/farms')
          .Accept('application/json')
          .Token('bearer '+token)
          .Get;
        if LResponse.StatusCode = 200 then
          begin
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

      // GET in nicehash
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

      TThread.Synchronize(nil, procedure
      begin
              TLoading.Hide;
              ShowDashboard;
              NiceHashRig2.free;
              HiveFarmList.Free;
      end);
    end).Start;

end;

procedure TFrmPrincipal.CreateGauge;
var i : integer;
begin
    if not Assigned(series) then
          series := TActivityGauge.Create(self)
        else
          Chart_Gauge.RemoveAllSeries;

      Chart_Gauge.AddSeries(series);
      series.FillSampleValues(DashboardMain.Farms.Count);

      series.CenterText.Shape.Font.Color := TAlphaColors.Orange;
      series.CenterText.Shape.Font.Size := 55;
      series.CenterText.Text := inttostr(DashboardMain.FarmOnline) +'/'+ inttostr(Length(series.ActivityValues));

  for I := 0 to pred(DashboardMain.Farms.Count)  do
    begin

      if (DashboardMain.Farms[i].Stats.Workers_Total > 0) then
        begin
            series.ActivityValues[i].Value := 100;
            series.ActivityValues[i].Color := DashboardMain.TfColor(i);
            Chart_Gauge.Hover.Visible := true;
            Chart_Gauge.Enabled := true;
        end
          else
        begin
            series.ActivityValues[i].Value := 0;
            series.ActivityValues[i].Color := TAlphaColor($57E36060);
        end;
          series.ActivityValues[i].BackColor := TAlphaColor($FF8d5d80);
    end;

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
               CreateDashboard(Token,Wallet)
             else
             // F_FarmStatistics.CreateWorker(token,'388939');
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
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  CreateDashboard(Token,Wallet);
end;

end.
