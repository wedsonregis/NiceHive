unit U_FarmStatistics;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls ,

  // Teclado...
  FMX.VirtualKeyboard, FMX.Platform, FMXTee.Series, FMXTee.Series.OHLC,
  FMXTee.Series.Candle, FMXTee.Engine, FMXTee.Tools, FMXTee.Tools.PageNumber,
  FMXTee.Series.Donut, FMXTee.Procs, FMXTee.Chart, FMX.Effects,
  FMX.Filter.Effects, Workers, WorkerinFarm, FMXTee.Import;

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
    FlowLayout1: TFlowLayout;
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
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure butt_DockerClick(Sender: TObject);
    procedure butt_ReloadClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Chart_GPUClickSeries(Sender: TCustomChart; Series: TChartSeries;
      ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
    DashboardWorker : TRootWorkers;
    WorkerHiveos : TRootWorkerinFarm;
    Procedure ShowWorker(GpuIndex : integer);
    Procedure  CreateWorker(Token, FarmID :string);
  public
    { Public declarations }
  end;

var
  F_FarmStatistics: TF_FarmStatistics;

implementation

{$R *.fmx}

uses F_Main, RESTRequest4D, Loading;


procedure TF_FarmStatistics.butt_DockerClick(Sender: TObject);
begin
    Close;
end;

procedure TF_FarmStatistics.butt_ReloadClick(Sender: TObject);
begin
    CreateWorker(
       Token,
       inttostr(FrmPrincipal.WorkerId)
    );
end;



procedure TF_FarmStatistics.Chart_GPUClickSeries(Sender: TCustomChart;
  Series: TChartSeries; ValueIndex: Integer; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  //  change for function
    Lbl_Gputemp.Text := inttostr(DashboardWorker.WorkerList[0].Gpu_Stats[ValueIndex].Temp) + '°';
end;



procedure TF_FarmStatistics.CreateWorker(Token, FarmID: string);
begin
  TLoading.Show(F_FarmStatistics, 'Loading data');
  TThread.CreateAnonymousThread(procedure
      var
        LResponse: IResponse;
        i, GpuIndex : integer;
    begin
      // GET in nicehash
      LResponse := TRequest.New.BaseURL(HiveApi +'/farms/'+FarmID+'/workers')
          .Accept('application/json')
          .Token('bearer '+token)
          .Get;

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

          // GPU status
          for GpuIndex := 0 to pred(WorkerHiveos.data.Count) do
            begin
             for I := 0 to pred(WorkerHiveos.data[GpuIndex].Gpu_Stats.Count) do
                 begin
                  DashboardWorker.TempMax :=  WorkerHiveos.data[GpuIndex].Gpu_Stats[i].Temp;
                 end;
            end;
      end;

      TThread.Synchronize(nil, procedure
      begin
          TLoading.Hide;
          ShowWorker(0);
      end);
   end).Start;
end;

procedure TF_FarmStatistics.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action := TCloseAction.caFree;
    F_FarmStatistics := nil;
    FrmPrincipal.FloatAnimation1.Start;
end;

procedure TF_FarmStatistics.FormDestroy(Sender: TObject);
begin
    DashboardWorker.free;
    WorkerHiveos.free;
end;

procedure TF_FarmStatistics.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
{$IFDEF ANDROID}
var
    FService : IFMXVirtualKeyboardService;
{$ENDIF}
begin
    {$IFDEF ANDROID}
    if (Key = vkHardwareBack) then
    begin
        TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));

        if (FService <> nil) and (TVirtualKeyboardState.Visible in FService.VirtualKeyBoardState) then
        begin
            // Botao back pressionado e teclado visivel...
            // (apenas fecha o teclado)
        end
        else
        begin
            // Botao back pressionado e teclado NAO visivel...
            // "Cancela" o efeito do botao back para nao fechar o app...
            Key := 0;
            close;
        end;
    end;
    {$ENDIF}
end;

procedure TF_FarmStatistics.FormShow(Sender: TObject);
begin
    Timer1.Enabled := true;
end;

procedure TF_FarmStatistics.ShowWorker(GpuIndex : integer);
var
  i,  fan :integer;
begin

  // GPU Stats temp
  Chart_GPU.Series[0].Clear;
  Chart_Fan.Series[0].Clear;
  Chart_GPUActive.Series[0].Clear;
  Fan := 0;

     for I := 0 to pred(DashboardWorker.WorkerList[GpuIndex].Gpu_Stats.Count) do
       begin
         Chart_GPU.Series[0].Add(DashboardWorker.WorkerList[GpuIndex].Gpu_Stats[i].Temp,
           'GPU-'+inttostr(i),DashboardWorker.TempColor(DashboardWorker.WorkerList[GpuIndex].Gpu_Stats[i].Temp));

         Chart_Fan.Series[0].Add(DashboardWorker.WorkerList[GpuIndex].Gpu_Stats[i].Fan,
           'GPU-'+inttostr(i),DashboardWorker.TfColor(DashboardWorker.WorkerList[GpuIndex].Gpu_Stats[i].Fan));

         Chart_GPUActive.Series[0].Add(DashboardWorker.WorkerList[GpuIndex].Gpu_Stats[i].Hash / 1000,
           'GPU-'+inttostr(i),TAlphaColor($FF667765));
         // Change for property
        fan := fan + DashboardWorker.WorkerList[GpuIndex].Gpu_Stats[i].Fan;
       end;


      With Chart_Shares.Series[0] do
         begin
           Clear;
           Add(DashboardWorker.WorkerList[GpuIndex].Miners_Summary.Hashrates[GpuIndex].Shares.Accepted,
             'Accept',TAlphaColor($FF667765));
           Add(DashboardWorker.WorkerList[GpuIndex].Miners_Summary.Hashrates[GpuIndex].Shares.Rejected,
             'Rejected',TAlphaColor($78b35664));
           Add(DashboardWorker.WorkerList[GpuIndex].Miners_Summary.Hashrates[GpuIndex].Shares.Invalid,
             'Invalid',TAlphaColor($FFa67a2d));
      end;

      Lbl_SharesValue.Text := floattostr(DashboardWorker.WorkerList[GpuIndex].Miners_Summary.Hashrates[GpuIndex].Shares.Ratio) + '%';
     // Change for function
      Lbl_GpuValue.Text := inttostr(DashboardWorker.WorkerList[GpuIndex].Stats.Gpus_Online)+
              '/'+ inttostr(DashboardWorker.WorkerList[GpuIndex].Gpu_Stats.Count);
     // Change for property
      fan := fan div DashboardWorker.WorkerList[GpuIndex].Gpu_Stats.Count;
    // Change for function
      Lbl_fanValue.Text := inttostr(fan)+'%';
      Lbl_Gputemp.Text := inttostr(DashboardWorker.TempMax) + '°';
      butt_Worker.Text := DashboardWorker.WorkerList[0].Name;
end;

procedure TF_FarmStatistics.Timer1Timer(Sender: TObject);
begin
    butt_Reload.onclick(self);
    Timer1.Enabled := false;
end;

end.
