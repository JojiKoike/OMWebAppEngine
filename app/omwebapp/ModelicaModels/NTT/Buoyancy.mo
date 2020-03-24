within NTT;
model Buoyancy
  import SI = Modelica.SIunits;
  extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.TwoPort;
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort annotation(
    Placement(visible = true, transformation(origin = {2, -96}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //parameter SI.Temperature Ta "Ambient Temperature";
  parameter SI.Length Width "ENC Width";
  parameter SI.Length Depth "ENC Depth";
  parameter SI.Length CL "ENC Height";
  output SI.Pressure p1(start=0.001);
  output SI.Velocity Vout;
  output Real ohr;
  output SI.Area area;  
  //output Real CL=0.0;



equation
  area=Width*Depth;
  //CL=Height*(1-tapT);
  Q_flow = heatPort.Q_flow;
  p1 =medium.rho * dT * CL * Modelica.Constants.g_n/T0;
  heatPort.T = T_q;
  ohr=1/medium.rho;
  V_flow=sqrt(2*area^2*p1*ohr);
  Vout=V_flow/area;
  annotation(
    uses(Modelica(version = "3.2.2")),
    Icon(graphics = {Line(origin = {-0.31, 6.15}, points = {{-89.6857, -6.14993}, {90.3143, -6.14993}, {60.3143, 5.85007}}, thickness = 1), Line(origin = {75, -6}, points = {{15, 6}, {-15, -6}}, thickness = 1), Text(origin = {6,-4}, rotation = -90, extent = {{-84, 14}, {76, -26}}, textString = "Buoyancy")}));
end Buoyancy;
