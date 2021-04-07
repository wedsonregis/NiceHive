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
  NicehashRig2 in 'Model\NicehashRig2.pas',
  Workers in 'Control\DashControl\Workers.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
