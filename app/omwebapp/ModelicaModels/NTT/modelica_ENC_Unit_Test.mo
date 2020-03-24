within NTT;
model modelica_ENC_Unit_Test
  import SI=Modelica.SIunits;
  
  // ----- Initial Condition Inputs START ----- //

  // For ModelicaUnit
  parameter SI.Length width_unit = 0.1;
  parameter SI.Length height_unit = 0.1;
  parameter SI.Length depth_unit = 0.1;
  parameter SI.SpecificHeatCapacity cp_unit = 24;
  parameter SI.Emissivity e_unit = 0.7;
  parameter SI.Power power_unit = 10.0;
  parameter SI.Temperature T_st_unit = 294.15;

  // For ModelicaEnc
  parameter SI.Length width_enc = 0.5;
  parameter SI.Length height_enc = 0.5;
  parameter SI.Length depth_enc = 0.5;
  parameter SI.Length thickness_enc = 0.002;
  parameter SI.ThermalConductivity ke_enc = 50;
  parameter SI.SpecificHeatCapacity cp_enc = 24;
  parameter SI.Density ro_enc = 3.75;
  parameter SI.Emissivity ein_enc = 0.7;
  parameter SI.Emissivity eout_enc = 0.7;
  parameter SI.Temperature T_st_enc = 293.15;

  // For FixedTemperature
  parameter SI.Temperature T_fixed = 291.15;

  // ----- Initial Condition Inputs END ----- //

  // ----- Component Construction START ----- //

  // Unit
  ModelicaUnit modelicaUnit1(
    width = width_unit,
    height = height_unit,
    depth = depth_unit,
    Power = power_unit,
    cp = cp_unit,
    E = e_unit,
    T_st = T_st_unit
    )  annotation(
    Placement(visible = true, transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  // Enclosure
  ModelicaEnc modelicaEnc(
    width = width_enc,
    height = height_enc,
    depth = depth_enc,
    thickness = thickness_enc,
    ke = ke_enc,
    cp = cp_enc,
    Ro = ro_enc,
    Ein = ein_enc,
    Eout = eout_enc,
    T_st = T_st_enc
    )  annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));

  // Fixed Temperature
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature1(T = T_fixed)  annotation(
    Placement(visible = true, transformation(origin = {60, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));

  // ----- Component Construction END ----- //

equation

  connect(modelicaEnc.port_rad_b[6], fixedTemperature1.port) annotation(
    Line(points = {{12, -6}, {30, -6}, {30, 0}, {50, 0}, {50, 0}}, color = {191, 0, 0}, thickness = 0.5));
  connect(modelicaEnc.port_rad_b[5], fixedTemperature1.port) annotation(
    Line(points = {{12, -6}, {30, -6}, {30, 0}, {50, 0}, {50, 0}}, color = {191, 0, 0}, thickness = 0.5));
  connect(modelicaEnc.port_rad_b[4], fixedTemperature1.port) annotation(
    Line(points = {{12, -6}, {30, -6}, {30, 0}, {50, 0}, {50, 0}}, color = {191, 0, 0}, thickness = 0.5));
  connect(modelicaEnc.port_rad_b[3], fixedTemperature1.port) annotation(
    Line(points = {{12, -6}, {30, -6}, {30, 0}, {50, 0}, {50, 0}}, color = {191, 0, 0}, thickness = 0.5));
  connect(modelicaEnc.port_rad_b[2], fixedTemperature1.port) annotation(
    Line(points = {{12, -6}, {30, -6}, {30, 0}, {50, 0}, {50, 0}}, color = {191, 0, 0}, thickness = 0.5));
  connect(modelicaEnc.port_rad_b[1], fixedTemperature1.port) annotation(
    Line(points = {{12, -6}, {30, -6}, {30, 0}, {50, 0}, {50, 0}}, color = {191, 0, 0}, thickness = 0.5));

  connect(modelicaEnc.port_con_b[6], fixedTemperature1.port) annotation(
    Line(points = {{12, 6}, {30, 6}, {30, 0}, {50, 0}, {50, 0}}, color = {191, 0, 0}, thickness = 0.5));
  connect(modelicaEnc.port_con_b[5], fixedTemperature1.port) annotation(
    Line(points = {{12, 6}, {30, 6}, {30, 0}, {50, 0}, {50, 0}}, color = {191, 0, 0}, thickness = 0.5));
  connect(modelicaEnc.port_con_b[4], fixedTemperature1.port) annotation(
    Line(points = {{12, 6}, {30, 6}, {30, 0}, {50, 0}, {50, 0}}, color = {191, 0, 0}, thickness = 0.5));
  connect(modelicaEnc.port_con_b[3], fixedTemperature1.port) annotation(
    Line(points = {{12, 6}, {30, 6}, {30, 0}, {50, 0}, {50, 0}}, color = {191, 0, 0}, thickness = 0.5));
  connect(modelicaEnc.port_con_b[2], fixedTemperature1.port) annotation(
    Line(points = {{12, 6}, {30, 6}, {30, 0}, {50, 0}, {50, 0}}, color = {191, 0, 0}, thickness = 0.5));
  connect(modelicaEnc.port_con_b[1], fixedTemperature1.port) annotation(
    Line(points = {{12, 6}, {30, 6}, {30, 0}, {50, 0}, {50, 0}}, color = {191, 0, 0}, thickness = 0.5));

  connect(modelicaUnit1.portEmi[6], modelicaEnc.port_rad_a[6]) annotation(
    Line(points = {{-40, -6}, {-12, -6}, {-12, -6}, {-12, -6}}, color = {191, 0, 0}, thickness = 0.5));
  connect(modelicaUnit1.portEmi[5], modelicaEnc.port_rad_a[5]) annotation(
    Line(points = {{-40, -6}, {-12, -6}, {-12, -6}, {-12, -6}}, color = {191, 0, 0}, thickness = 0.5));
  connect(modelicaUnit1.portEmi[4], modelicaEnc.port_rad_a[4]) annotation(
    Line(points = {{-40, -6}, {-12, -6}, {-12, -6}, {-12, -6}}, color = {191, 0, 0}, thickness = 0.5));
  connect(modelicaUnit1.portEmi[3], modelicaEnc.port_rad_a[3]) annotation(
    Line(points = {{-40, -6}, {-12, -6}, {-12, -6}, {-12, -6}}, color = {191, 0, 0}, thickness = 0.5));
  connect(modelicaUnit1.portEmi[2], modelicaEnc.port_rad_a[2]) annotation(
    Line(points = {{-40, -6}, {-12, -6}, {-12, -6}, {-12, -6}}, color = {191, 0, 0}, thickness = 0.5));
  connect(modelicaUnit1.portEmi[1], modelicaEnc.port_rad_a[1]) annotation(
    Line(points = {{-40, -6}, {-12, -6}, {-12, -6}, {-12, -6}}, color = {191, 0, 0}, thickness = 0.5));

  connect(modelicaUnit1.portConv[6], modelicaEnc.port_con_a[6]) annotation(
    Line(points = {{-40, 6}, {-12, 6}, {-12, 6}, {-12, 6}}, color = {191, 0, 0}, thickness = 0.5));
  connect(modelicaUnit1.portConv[5], modelicaEnc.port_con_a[5]) annotation(
    Line(points = {{-40, 6}, {-12, 6}, {-12, 6}, {-12, 6}}, color = {191, 0, 0}, thickness = 0.5));
  connect(modelicaUnit1.portConv[4], modelicaEnc.port_con_a[4]) annotation(
    Line(points = {{-40, 6}, {-12, 6}, {-12, 6}, {-12, 6}}, color = {191, 0, 0}, thickness = 0.5));
  connect(modelicaUnit1.portConv[3], modelicaEnc.port_con_a[3]) annotation(
    Line(points = {{-40, 6}, {-12, 6}, {-12, 6}, {-12, 6}}, color = {191, 0, 0}, thickness = 0.5));
  connect(modelicaUnit1.portConv[2], modelicaEnc.port_con_a[2]) annotation(
    Line(points = {{-40, 6}, {-12, 6}, {-12, 6}, {-12, 6}}, color = {191, 0, 0}, thickness = 0.5));
  connect(modelicaUnit1.portConv[1], modelicaEnc.port_con_a[1]) annotation(
    Line(points = {{-40, 6}, {-12, 6}, {-12, 6}, {-12, 6}}, color = {191, 0, 0}, thickness = 0.5));
  annotation(
    uses(Modelica(version = "3.2.2")));
end modelica_ENC_Unit_Test;