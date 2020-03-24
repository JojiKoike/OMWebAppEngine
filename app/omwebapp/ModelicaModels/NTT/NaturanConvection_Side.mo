within NTT;
model NaturanConvection_Side
  import SI = Modelica.SIunits;
  SI.HeatFlowRate Q_flow "Heat flow rate from solid -> fluid";
  SI.TemperatureDifference dT(start=1) "= solid.T - fluid.T";
  SI.CoefficientOfHeatTransfer h "Coefficient of Heat Transfer";
  SI.CoefficientOfHeatTransfer hp;
  SI.ThermalConductance C "Thermal Conductance";

  parameter SI.Area area "Plate Area";
  parameter SI.Length height "Plate Height";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a solid annotation(
    Placement(visible = true, transformation(origin = {0, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-74,0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b fluid annotation(
    Placement(visible = true, transformation(origin = {0, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {80,0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  dT = solid.T - fluid.T;
  solid.Q_flow = Q_flow;
  fluid.Q_flow = -Q_flow;
  hp = 2.51 * 0.56 * (abs(dT) / height) ^ 0.25;
  if dT >= 0 then h=hp;
    else h=-hp;
  end if;
  C = area * h;
  Q_flow=dT*C;
  annotation(
    Icon(graphics = {Rectangle(origin = {-70, -10}, rotation = -90, fillPattern = FillPattern.Forward, extent = {{-90, 10}, {70, -10}}), Line(origin = {-9.98444, 65.1162}, rotation = -90, points = {{5.17082, -49.7236}, {5.17082, 50.2764}, {-4.82918, 30.2764}}, color = {0, 0, 255}), Line(origin = {29.8847, 54.8445}, rotation = -90, points = {{-5, 10}, {5, -10}}, color = {0, 0, 255}), Line(origin = {-10.1542, 25.0051}, rotation = -90, points = {{5.17082, -49.7236}, {5.17082, 50.2764}, {-4.82918, 30.2764}}, color = {0, 0, 255}), Line(origin = {29.7149, 14.7335}, rotation = -90, points = {{-5, 10}, {5, -10}}, color = {0, 0, 255}), Line(origin = {-10.3261, -14.6833}, rotation = -90, points = {{5.17082, -49.7236}, {5.17082, 50.2764}, {-4.82918, 30.2764}}, color = {0, 0, 255}), Line(origin = {29.7536, -25.1657}, rotation = -90, points = {{-5, 10}, {5, -10}}, color = {0, 0, 255}), Line(origin = {-10.2853, -54.7931}, rotation = -90, points = {{5.17082, -49.7236}, {5.17082, 50.2764}, {-4.82918, 30.2764}}, color = {0, 0, 255}), Line(origin = {29.5838, -64.8541}, rotation = -90, points = {{-5, 10}, {5, -10}}, color = {0, 0, 255}), Text(origin = {4, 3}, extent = {{-54, 21}, {54, -21}}, textString = "Side"), Text(origin = {2, 85}, extent = {{-48, 11}, {48, -11}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)),
    uses(Modelica(version = "3.2.2")));
end NaturanConvection_Side;
