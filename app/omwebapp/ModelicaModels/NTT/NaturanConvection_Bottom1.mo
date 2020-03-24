within NTT;
  model NaturanConvection_Bottom1

  import SI=Modelica.SIunits;

    SI.HeatFlowRate Q_flow "Heat flow rate from solid -> fluid";
    SI.TemperatureDifference dT(start=1) "= solid.T - fluid.T";
    SI.CoefficientOfHeatTransfer h "Coefficient of Heat Transfer";
    SI.CoefficientOfHeatTransfer hp;
    SI.ThermalConductance C "Thermal Conductance";
    parameter SI.Length width "Plate Width";
    parameter SI.Length depth "Plate Depth";
    parameter SI.Area area=width*depth "Plate Area";
    Real dh "Hydraulic Diameter";
    
    
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a solid annotation(
      Placement(visible = true, transformation(origin = {0, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b fluid annotation(
      Placement(visible = true, transformation(origin = {0, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      
    equation
    dT = solid.T - fluid.T;
    solid.Q_flow = Q_flow;
    fluid.Q_flow = -Q_flow;
    dh=2*width*depth/(width+depth);
    hp=2.51*0.27*(abs(dT)/dh)^0.25;
    if dT>=0 then h=hp;
      else h=-hp;
    end if;
    C=area*h;
    Q_flow=dT*C;
    annotation(
      Icon(graphics = {Rectangle(origin = {10, 50}, fillPattern = FillPattern.Forward, extent = {{-90, 10}, {70, -10}}), Line(origin = {-55.2901, -9.40915}, rotation = 180, points = {{5.17082, -49.7236}, {5.17082, 50.2764}, {-4.82918, 30.2764}}, color = {0, 0, 255}), Line(origin = {-65.5105, -49.4294}, rotation = 180, points = {{-5, 10}, {5, -10}}, color = {0, 0, 255}), Line(origin = {-15.23, -9.28905}, rotation = 180, points = {{5.17082, -49.7236}, {5.17082, 50.2764}, {-4.82918, 30.2764}}, color = {0, 0, 255}), Line(origin = {-25.2402, -49.5195}, rotation = 180, points = {{-5, 10}, {5, -10}}, color = {0, 0, 255}), Line(origin = {25.0403, -9.58937}, rotation = 180, points = {{5.17082, -49.7236}, {5.17082, 50.2764}, {-4.82918, 30.2764}}, color = {0, 0, 255}), Line(origin = {14.8199, -49.6097}, rotation = 180, points = {{-5, 10}, {5, -10}}, color = {0, 0, 255}), Line(origin = {64.8901, -9.46925}, rotation = 180, points = {{5.17082, -49.7236}, {5.17082, 50.2764}, {-4.82918, 30.2764}}, color = {0, 0, 255}), Line(origin = {55.0901, -49.4896}, rotation = 180, points = {{-5, 10}, {5, -10}}, color = {0, 0, 255}), Text(origin = {0, -3}, extent = {{-54, 21}, {54, -21}}, textString = "Bottom"), Text(origin = {-1, 85}, extent = {{-49, 11}, {49, -11}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)),
      uses(Modelica(version = "3.2.2")));
    
  end NaturanConvection_Bottom1;
