within NTT;
model NaturanConvection_Top1
  import SI = Modelica.SIunits;
  SI.HeatFlowRate Q_flow "Heat flow rate from solid -> fluid";
  SI.TemperatureDifference dT(start=1) "= solid.T - fluid.T";
  SI.CoefficientOfHeatTransfer h "Coefficient of Heat Transfer";
  SI.CoefficientOfHeatTransfer hp;
  SI.ThermalConductance C "Thermal Conductance";
  parameter SI.Length width "Plate Width";
  parameter SI.Length depth "Plate Depth";
  parameter SI.Area area = width * depth "Plate Area";
  Real dh "Hydraulic Diameter";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a solid annotation(
    Placement(visible = true, transformation(origin = {0, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b fluid annotation(
    Placement(visible = true, transformation(origin = {0, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  dT = solid.T - fluid.T;
  solid.Q_flow = Q_flow;
  fluid.Q_flow = -Q_flow;
  dh = 2 * width * depth / (width + depth);
  hp = 2.51 * 0.54 * (abs(dT) / dh) ^ 0.25;
  if dT>=0 then h=hp;
    else h=-hp;
  end if;
  C = area * h;
  Q_flow=dT*C;
  annotation(
    Icon(graphics = {Rectangle(origin = {10, -50}, fillPattern = FillPattern.Forward, extent = {{-90, 10}, {70, -10}}), Line(origin = {-64.9316, 9.72}, points = {{5.17082, -49.7236}, {5.17082, 50.2764}, {-4.82918, 30.2764}}, color = {0, 0, 255}), Line(origin = {-55, 49.7616}, points = {{-5, 10}, {5, -10}}, color = {0, 0, 255}), Line(origin = {-25.5303, 10.0503}, points = {{5.17082, -49.7236}, {5.17082, 50.2764}, {-4.82918, 30.2764}}, color = {0, 0, 255}), Line(origin = {-15.3603, 50.3303}, points = {{-5, 10}, {5, -10}}, color = {0, 0, 255}), Line(origin = {15.1604, 9.75}, points = {{5.17082, -49.7236}, {5.17082, 50.2764}, {-4.82918, 30.2764}}, color = {0, 0, 255}), Line(origin = {25.3304, 50.03}, points = {{-5, 10}, {5, -10}}, color = {0, 0, 255}), Line(origin = {54.8, 9.4497}, points = {{5.17082, -49.7236}, {5.17082, 50.2764}, {-4.82918, 30.2764}}, color = {0, 0, 255}), Line(origin = {64.97, 49.7297}, points = {{-5, 10}, {5, -10}}, color = {0, 0, 255}), Text(origin = {0, 7}, extent = {{-54, 21}, {54, -21}}, textString = "Top"), Text(origin = {0, 84}, extent = {{-46, 10}, {46, -10}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)),
    uses(Modelica(version = "3.2.2")));
end NaturanConvection_Top1;
