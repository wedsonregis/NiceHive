unit U_FarmStatistics;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls,

  // Teclado...
  FMX.VirtualKeyboard, FMX.Platform, FMXTee.Series, FMXTee.Series.OHLC,
  FMXTee.Series.Candle, FMXTee.Engine, FMXTee.Tools, FMXTee.Tools.PageNumber,
  FMXTee.Series.Donut, FMXTee.Procs, FMXTee.Chart, FMX.Effects,
  FMX.Filter.Effects, Workers, WorkerinFarm, FMXTee.Import, Radiant.Shapes,
  FMX.Ani, FMXTee.Series.ImagePoint;

type
  TF_FarmStatistics = class(TForm)
    VertScrollBox1: TVertScrollBox;
    Lay_nav: TLayout;
    Rec_Navigation: TRectangle;
    Lay_top: TLayout;
    butt_Docker: TButton;
    lbl_Dashboard: TLabel;
    butt_Reload: TButton;
    FillRGBEffect1: TFillRGBEffect;
    Rec_gradient: TRectangle;
    Rec_ground: TRectangle;
    Lay_Bottom: TLayout;
    Chart_Bar: TChart;
    Series3: THorizBarSeries;
    Chart_Lines: TChart;
    Series4: TCandleSeries;
    Lay_statsInfo: TLayout;
    Flow_top: TFlowLayout;
    Chart_Shares: TChart;
    Lbl_SharesValue: TLabel;
    DonutSeries1: TDonutSeries;
    Chart_Fan: TChart;
    Lbl_FanValue: TLabel;
    Series2: TDonutSeries;
    Chart_GPUActive: TChart;
    Lbl_GpuValue: TLabel;
    DonutSeries2: TDonutSeries;
    butt_Previous: TSpeedButton;
    butt_Worker: TSpeedButton;
    butt_Next: TSpeedButton;
    Timer1: TTimer;
    Chart_GPU: TChart;
    Lbl_Gputemp: TLabel;
    Series1: TDonutSeries;
    ChartTool1: TPageNumTool;
    RadiantC_Stats: TRadiantCallout;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    FloatAnimation1: TFloatAnimation;
    Series5: TVolumeSeries;
    Series6: TDeltaPointSeries;
    Series7: THorizBarSeries;
    Series8: THorizBarSeries;
    Series9: THorizBarSeries;
    FlowLay_Top: TFlowLayout;
    Lay_Wallet: TLayout;
    Lbl_SharesValue2: TLabel;
    Lbl_WalletCaption: TLabel;
    Label11: TLabel;
    Label14: TLabel;
    Lay_NextPay: TLayout;
    Lbl_FanValue2: TLabel;
    Lbl_UnpaidAmountCaption: TLabel;
    Label10: TLabel;
    Lbl_UnpaidAmountBtc: TLabel;
    Lay_InPay: TLayout;
    Lbl_GpuValue2: TLabel;
    Lbl_ProfitabilityCaption: TLabel;
    Lbl_currency: TLabel;
    Lbl_ProfitabilityBtc: TLabel;
    Label15: TLabel;
    FlowLayout1: TFlowLayout;
    Layout1: TLayout;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label12: TLabel;
    Layout2: TLayout;
    Label13: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Layout3: TLayout;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    FlowLayout2: TFlowLayout;
    Layout4: TLayout;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Layout5: TLayout;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Layout6: TLayout;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure butt_DockerClick(Sender: TObject);
    procedure butt_ReloadClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Chart_GPUClickSeries(Sender: TCustomChart; Series: TChartSeries;
      ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Chart_GPUClick(Sender: TObject);
  private
    { Private declarations }
    DashboardWorker: TRootWorkers;
    WorkerHiveos: TRootWorkerinFarm;
    Procedure ShowWorker(GpuIndex: Integer);
    Procedure CreateWorker(Token, FarmID: string);

    procedure StrinTtoL(s:string);
    Procedure SwitchChar(value: Integer);
  public
    { Public declarations }
  end;

var
  F_FarmStatistics: TF_FarmStatistics;

implementation

{$R *.fmx}

uses F_Main, RESTRequest4D, Loading, System.DateUtils;

function UNIXTimeToDateTimeFAST(UnixTime: LongWord): TDateTime;
begin
  Result := (UnixTime / 86400) + 25569;
end;

procedure TF_FarmStatistics.Button1Click(Sender: TObject);

begin
   StrinTtoL('Shares');
   SwitchChar(2);
end;

procedure TF_FarmStatistics.Button2Click(Sender: TObject);
begin
  StrinTtoL('Percent');
  SwitchChar(1);

end;

procedure TF_FarmStatistics.Button3Click(Sender: TObject);

begin
  StrinTtoL('MHs');
  SwitchChar(0);
end;

procedure TF_FarmStatistics.butt_DockerClick(Sender: TObject);
begin
  Close;
end;

procedure TF_FarmStatistics.butt_ReloadClick(Sender: TObject);
begin
  CreateWorker(HiveToken, inttostr(FrmPrincipal.DashboardMain.ID));
end;

procedure TF_FarmStatistics.Chart_GPUClick(Sender: TObject);
begin
StrinTtoL('Degrees');
SwitchChar(3);
end;

procedure TF_FarmStatistics.Chart_GPUClickSeries(Sender: TCustomChart;
  Series: TChartSeries; ValueIndex: Integer; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   Lbl_Gputemp.Text := Chart_GPU.SeriesList[0].YValue[ValueIndex].ToString + '°';
   Label23.Text :=  DashboardWorker.WorkerList[0].Gpu_Summary.Gpus[0].Name;
   Label27.Text :=  inttostr(DashboardWorker.WorkerList[0].Gpu_Stats[ValueIndex].Power)+' KW';
   Label31.Text :=  inttostr(DashboardWorker.WorkerList[0].Gpu_Stats[ValueIndex].Fan)+' %';
   //showmessage(inttostr(ValueIndex));
end;

procedure TF_FarmStatistics.CreateWorker(Token, FarmID: string);
begin
  try
    TLoading.Show(F_FarmStatistics, 'Loading data');
    TThread.CreateAnonymousThread(
      procedure
      var
        LResponse: IResponse;
      begin
        // GET in nicehash
        LResponse := TRequest.New.BaseURL(HiveApi + '/farms/' + FarmID +
          '/workers').Accept('application/json').Token('bearer ' + Token).Get;

        if LResponse.StatusCode = 200 then
        begin
          if Assigned(WorkerHiveos) then
            WorkerHiveos.Free;

          if Assigned(DashboardWorker) then
            DashboardWorker.Free;

          WorkerHiveos := TRootWorkerinFarm.Create;
          WorkerHiveos.AsJson := LResponse.Content;

          DashboardWorker := TRootWorkers.Create;
          DashboardWorker.SetWorkerList(WorkerHiveos.getdata);
        end;

        TThread.Synchronize(nil,
          procedure
          begin
            TLoading.Hide;
            ShowWorker(0);
          end);
      end).Start;
  Except
    on E: Exception do
    begin
      TLoading.Hide;
      ShowMessage('Erro: ' + E.Message);
    end;
  end;

end;


procedure TF_FarmStatistics.FormClose(Sender: TObject;
var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  F_FarmStatistics := nil;
  FrmPrincipal.FloatAnimation1.Start;
end;

procedure TF_FarmStatistics.FormDestroy(Sender: TObject);
begin
  DashboardWorker.Free;
  WorkerHiveos.Free;
end;

procedure TF_FarmStatistics.FormKeyUp(Sender: TObject; var Key: Word;
var KeyChar: Char; Shift: TShiftState);
{$IFDEF ANDROID}
var
  FService: IFMXVirtualKeyboardService;
{$ENDIF}
begin
{$IFDEF ANDROID}
  if (Key = vkHardwareBack) then
  begin
    TPlatformServices.Current.SupportsPlatformService
      (IFMXVirtualKeyboardService, IInterface(FService));

    if (FService <> nil) and (TVirtualKeyboardState.Visible
      in FService.VirtualKeyBoardState) then
    begin
      // Botao back pressionado e teclado visivel...
      // (apenas fecha o teclado)
    end
    else
    begin
      // Botao back pressionado e teclado NAO visivel...
      // "Cancela" o efeito do botao back para nao fechar o app...
      Key := 0;
      Close;
    end;
  end;
{$ENDIF}
end;

procedure TF_FarmStatistics.FormShow(Sender: TObject);
begin
  Timer1.Enabled := true;
end;

procedure TF_FarmStatistics.ShowWorker(GpuIndex: Integer);
var
  i: Integer;
begin

  // GPU Stats temp
  Chart_GPU.Series[0].Clear;
  Chart_Fan.Series[0].Clear;
  Chart_GPUActive.Series[0].Clear;

  for i := 0 to pred(DashboardWorker.WorkerList[GpuIndex].Gpu_Stats.Count) do
  begin
    Chart_GPU.Series[0].Add(DashboardWorker.WorkerList[GpuIndex].Gpu_Stats[i]
      .Temp, 'GPU-' + inttostr(i),
      DashboardWorker.TempColor(DashboardWorker.WorkerList[GpuIndex].Gpu_Stats
      [i].Temp));

    Chart_Fan.Series[0].Add(DashboardWorker.WorkerList[GpuIndex].Gpu_Stats[i]
      .Fan, 'GPU-' + inttostr(i),
      DashboardWorker.TfColor(DashboardWorker.WorkerList[GpuIndex]
      .Gpu_Stats[i].Fan));

    Chart_GPUActive.Series[0].Add(DashboardWorker.WorkerList[GpuIndex].Gpu_Stats
      [i].Hash / 1000, 'GPU-' + inttostr(i), TAlphaColor($FF667765));

    // Change for property
    DashboardWorker.Fan := DashboardWorker.WorkerList[GpuIndex]
      .Gpu_Stats[i].Fan;

    // GPU status
    DashboardWorker.TempMax := DashboardWorker.WorkerList[GpuIndex]
      .Gpu_Stats[i].Temp;

      DashboardWorker.WorkerList[GpuIndex].Stats.Power_Draw :=
          DashboardWorker.WorkerList[GpuIndex].Stats.Power_Draw +
              DashboardWorker.WorkerList[GpuIndex].Gpu_Stats[i].Power
  end;

  // Shares
  With Chart_Shares.Series[0] do
  begin
    Clear;
    Add(DashboardWorker.WorkerList[GpuIndex].Miners_Summary.Hashrates[GpuIndex]
      .Shares.Accepted, 'Accept', TAlphaColor($FF667765));
    Add(DashboardWorker.WorkerList[GpuIndex].Miners_Summary.Hashrates[GpuIndex]
      .Shares.Rejected, 'Rejected', TAlphaColor($78B35664));
    Add(DashboardWorker.WorkerList[GpuIndex].Miners_Summary.Hashrates[GpuIndex]
      .Shares.Invalid, 'Invalid', TAlphaColor($FFA67A2D));
  end;

  Lbl_SharesValue.Text := floattostr(DashboardWorker.WorkerList[GpuIndex]
    .Miners_Summary.Hashrates[GpuIndex].Shares.Ratio) + '%';
  Lbl_SharesValue2.Text := Lbl_SharesValue.Text;
  Lbl_GpuValue.Text := inttostr(DashboardWorker.WorkerList[GpuIndex]
    .Stats.Gpus_Online) + '/' + inttostr(DashboardWorker.WorkerList[GpuIndex]
    .Gpu_Stats.Count);
  Lbl_GpuValue2.Text := Lbl_GpuValue.Text;
  Lbl_FanValue.Text :=
    inttostr(DashboardWorker.Fan div DashboardWorker.WorkerList[GpuIndex]
    .Gpu_Stats.Count) + '%';

  Lbl_FanValue2.Text := Lbl_FanValue.Text;
  Lbl_Gputemp.Text := inttostr(DashboardWorker.TempMax) + '°';
  butt_Worker.Text := DashboardWorker.WorkerList[GpuIndex].Name;

  Label7.Text := FormatDateTime('dd/mm hh:mm:ss',
    UnixToDateTime(DashboardWorker.WorkerList[GpuIndex].Stats.Boot_Time,true));

  Label13.Text := FormatDateTime('dd/mm hh:mm:ss',
    UnixToDateTime(DashboardWorker.WorkerList[GpuIndex]
    .Stats.Miner_Start_Time,true));

  Label19.Text := inttostr(DashboardWorker.WorkerList[GpuIndex]
    .Stats.Power_Draw)+' KW';
end;

procedure TF_FarmStatistics.StrinTtoL(s: string);
var
  sl: TStrings;
begin
  sl := TStringList.Create;
  try
    sl.text := s;
    Chart_Bar.Legend.Title.Text :=sl;
  finally
    sl.Free;
  end;

end;

procedure TF_FarmStatistics.SwitchChar(value: Integer);
var
  i: Integer;
begin
  for i := 0 to pred(Chart_Bar.SeriesCount) do
  begin
    if i = value then
      Chart_Bar.Series[value].Active := true
    else
      Chart_Bar.Series[i].Active := false;
  end;
end;

procedure TF_FarmStatistics.Timer1Timer(Sender: TObject);
begin
  butt_Reload.onclick(self);
  Timer1.Enabled := false;
end;

end.
