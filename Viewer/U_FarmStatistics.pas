unit U_FarmStatistics;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls,

  // Teclado...
  FMX.VirtualKeyboard, FMX.Platform, FMXTee.Series, FMXTee.Series.OHLC,
  FMXTee.Series.Candle, FMXTee.Engine, FMXTee.Tools, FMXTee.Tools.PageNumber,
  FMXTee.Series.Donut, FMXTee.Procs, FMXTee.Chart, FMX.Effects,
  FMX.Filter.Effects;

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
    Chart_GPU: TChart;
    Lbl_Gputemp: TLabel;
    Series1: TDonutSeries;
    ChartTool1: TPageNumTool;
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
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure butt_DockerClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_FarmStatistics: TF_FarmStatistics;

implementation

{$R *.fmx}

uses F_Main;


procedure TF_FarmStatistics.butt_DockerClick(Sender: TObject);
begin
    Close;
     { // Worker by FarmID
       FarmID := inttostr(ListFarm.Data[1].Id);

        LResponse := TRequest.New.BaseURL( HiveApi +'/farms/'+FarmID+'/workers')
          .Accept('application/json')
          .Token('bearer '+token)
          .Get;

        if LResponse.StatusCode = 200 then
            begin
                Worker := TRootWorkerinFarm.Create;
                Worker.AsJson := LResponse.Content;
            end;
     }
end;

procedure TF_FarmStatistics.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action := TCloseAction.caFree;
    F_FarmStatistics := nil;
    FrmPrincipal.FloatAnimation1.Start;
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

end.
