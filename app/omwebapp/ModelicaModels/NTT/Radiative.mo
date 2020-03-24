within NTT;

model Radiative
  import SI = Modelica.SIunits;
  SI.HeatFlowRate Q_flow "Heat flow rate from solid -> fluid";
  SI.TemperatureDifference dT "= solid.T - fluid.T";
  SI.CoefficientOfHeatTransfer hr "Coefficient of Radiative Heat Transfer";
  SI.ThermalConductance C "Thermal Conductance";
  
  parameter SI.Area area "Plate Area";
  parameter SI.Emissivity E "Emissivity";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a solid annotation(
    Placement(visible = true, transformation(origin = {0, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b fluid annotation(
    Placement(visible = true, transformation(origin = {0, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  dT = solid.T - fluid.T;
  solid.Q_flow = Q_flow;
  fluid.Q_flow = -Q_flow;
  hr = Modelica.Constants.sigma * E * (solid.T ^ 2 + fluid.T ^ 2) * (solid.T + fluid.T);
  C = area * hr;
  Q_flow = dT*C ;
  annotation(
    Diagram,
    Icon(graphics = {Rectangle(origin = {0, -50}, fillPattern = FillPattern.Solid, extent = {{-60, 10}, {60, -10}}), Line(origin = {0, -5}, points = {{0, 25}, {0, -25}}, color = {0, 0, 255}, pattern = LinePattern.Dash, thickness = 0.5), Line(origin = {-29.8314, -5.17914}, points = {{-30, 25}, {0, -25}}, color = {0, 0, 255}, pattern = LinePattern.Dash, thickness = 0.5), Line(origin = {30.4004, -5.13699}, points = {{30, 25}, {0, -25}}, color = {0, 0, 255}, pattern = LinePattern.Dash, thickness = 0.5), Text(origin = {1, -3}, extent = {{-29, 13}, {29, -13}}, textString = "Rad"), Text(origin = {0, 70}, extent = {{-40, 10}, {40, -10}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)));
end Radiative;
