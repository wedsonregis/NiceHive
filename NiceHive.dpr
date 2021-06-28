program NiceHive;

uses
  System.StartUpCopy,
  FMX.Forms,
  F_Main in 'Viewer\F_Main.pas' {FrmPrincipal},
  U_FarmStatistics in 'Viewer\U_FarmStatistics.pas' {F_FarmStatistics},
  Pkg.Json.DTO in 'Model\Pkg.Json.DTO.pas',
  DataSet.Serialize.Config in 'Control\DataSetSerialize\DataSet.Serialize.Config.pas',
  DataSet.Serialize.Consts in 'Control\DataSetSerialize\DataSet.Serialize.Consts.pas',
  DataSet.Serialize.Export in 'Control\DataSetSerialize\DataSet.Serialize.Export.pas',
  DataSet.Serialize.Import in 'Control\DataSetSerialize\DataSet.Serialize.Import.pas',
  DataSet.Serialize.Language in 'Control\DataSetSerialize\DataSet.Serialize.Language.pas',
  DataSet.Serialize in 'Control\DataSetSerialize\DataSet.Serialize.pas',
  DataSet.Serialize.UpdatedStatus in 'Control\DataSetSerialize\DataSet.Serialize.UpdatedStatus.pas',
  DataSet.Serialize.Utils in 'Control\DataSetSerialize\DataSet.Serialize.Utils.pas',
  RESTRequest4D in 'Control\REST\RESTRequest4D.pas',
  RESTRequest4D.Request.Client in 'Control\REST\RESTRequest4D.Request.Client.pas',
  RESTRequest4D.Request.Contract in 'Control\REST\RESTRequest4D.Request.Contract.pas',
  RESTRequest4D.Response.Client in 'Control\REST\RESTRequest4D.Response.Client.pas',
  RESTRequest4D.Response.Contract in 'Control\REST\RESTRequest4D.Response.Contract.pas',
  RESTRequest4D.Response.NetHTTP in 'Control\REST\RESTRequest4D.Response.NetHTTP.pas',
  RESTRequest4D.Utils in 'Control\REST\RESTRequest4D.Utils.pas',
  Dashboard in 'Control\DashControl\Dashboard.pas',
  ListFarm in 'Model\ListFarm.pas',
  WorkerinFarm in 'Model\WorkerinFarm.pas',
  Loading in 'Viewer\Loading.pas',
  Workers in 'Control\DashControl\Workers.pas',
  AppUserConfigs in 'Control\DashControl\AppUserConfigs.pas',
  F_Wallet in 'Viewer\F_Wallet.pas' {Form1},
  FlightSheet in 'Model\FlightSheet.pas',
  PoolSettings in 'Model\PoolSettings.pas',
  Coins in 'Model\Coins.pas'
  //
  {$IFDEF Android}
    , Androidapi.Helpers, FMX.Helpers.Android,
      Androidapi.JNI.GraphicsContentViewText
  {$ENDIF}
  ;

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;

  {$IFDEF Android}
  CallInUIThreadAndWaitFinishing(
    procedure
    begin
      TAndroidHelper.Activity.getWindow.setStatusBarColor($FF4B2A4F);
    end);
{$ENDIF}
end.
