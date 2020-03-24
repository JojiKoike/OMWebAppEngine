within NTT;
model draftLoss
  import SI=Modelica.SIunits;
  extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.TwoPort(final tapT=1);
  parameter SI.Area VentArea;
  parameter Real Cd=1/(0.66^2);
protected
  SI.Pressure pressureDrop;
equation
  pressureDrop=flowPort_a.m_flow^2*Cd/(2*VentArea^2*medium.rho);
  dp=-pressureDrop;
  Q_flow=0;
  
annotation(
    Icon(graphics = {Rectangle(fillColor = {216, 216, 216}, fillPattern = FillPattern.Solid, extent = {{-20, 100}, {20, -100}}), Rectangle(origin = {-2, 0}, fillColor = {85, 255, 255}, fillPattern = FillPattern.Horizontal, extent = {{-18, 60}, {22, -60}}), Text( rotation = -90, extent = {{-60, 20}, {60, -20}}, textString = "Vent")}));
end draftLoss;
