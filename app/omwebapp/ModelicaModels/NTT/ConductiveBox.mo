within NTT;
model ConductiveBox
  import SI = Modelica.SIunits;
  parameter SI.Length Width = 0.1 ;
  parameter SI.Length Depth = 0.1;
  parameter SI.Length Height = 0.1;
  parameter SI.Length Thickness = 0.002;
  parameter SI.ThermalConductivity k = 50;
  parameter SI.SpecificHeatCapacity Cp = 24;
  parameter SI.Density ro = 3.75;
  parameter SI.Temperature Tst=293.15;
  parameter Real Rx = k * Thickness / (Width * Height);
  parameter Real Ry = k * Thickness / (Depth * Height);
  parameter Real Rz = k * Thickness / (Width * Depth);
  parameter Real Cvx = Width * Height * Thickness * ro * Cp;
  parameter Real Cvy = Depth * Height * Thickness * ro * Cp;
  parameter Real Cvz = Width * Depth * Thickness * ro * Cp;
  parameter Real Rxz = k * 0.5 * (Depth + Height) / (Width * Thickness);
  parameter Real Ryz = k * 0.5 * (Width + Height) / (Depth * Thickness);
  parameter Real Rxy = k * 0.5 * (Width + Height) / (Height * Thickness);
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_1 annotation(
    Placement(visible = true, transformation(origin = {-220, 120}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-70, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_2 annotation(
    Placement(visible = true, transformation(origin = {-220, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-70, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_3 annotation(
    Placement(visible = true, transformation(origin = {-220, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-70, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_4 annotation(
    Placement(visible = true, transformation(origin = {-220, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-70, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_5 annotation(
    Placement(visible = true, transformation(origin = {-220, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-70, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_0 annotation(
    Placement(visible = true, transformation(origin = {-220, 160}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-70, 140}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor R1_7(R = Ry) annotation(
    Placement(visible = true, transformation(origin = {100, 120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor R2_8(R = Rx) annotation(
    Placement(visible = true, transformation(origin = {100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor R3_9(R = Ry) annotation(
    Placement(visible = true, transformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor R4_10(R = Rx) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor R0_6(R = Rz) annotation(
    Placement(visible = true, transformation(origin = {100, 160}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor R5_11(R = Rz) annotation(
    Placement(visible = true, transformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor R1_2(R = Rxy) annotation(
    Placement(visible = true, transformation(origin = {-80, 122}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor R2_3(R = Rxy) annotation(
    Placement(visible = true, transformation(origin = {-80, 80}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor R3_4(R = Rxy) annotation(
    Placement(visible = true, transformation(origin = {-80, 40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor RR4_1(R = Rxy) annotation(
    Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor R0_1(R = Ryz) annotation(
    Placement(visible = true, transformation(origin = {-26, 122}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor R1_5(R = Ryz) annotation(
    Placement(visible = true, transformation(origin = {-26, 80}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor R5_3(R = Ryz) annotation(
    Placement(visible = true, transformation(origin = {-26, 40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor R3_0(R = Ryz) annotation(
    Placement(visible = true, transformation(origin = {-26, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor R2_0(R = Rxz) annotation(
    Placement(visible = true, transformation(origin = {34, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor R5_2(R = Rxz) annotation(
    Placement(visible = true, transformation(origin = {34, 40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor R4_5(R = Rxz) annotation(
    Placement(visible = true, transformation(origin = {34, 80}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor R0_4(R = Rxz) annotation(
    Placement(visible = true, transformation(origin = {34, 122}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_6 annotation(
    Placement(visible = true, transformation(origin = {140, 160}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {170, 140}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_7 annotation(
    Placement(visible = true, transformation(origin = {140, 120}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {170, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_8 annotation(
    Placement(visible = true, transformation(origin = {140, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {170, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_9 annotation(
    Placement(visible = true, transformation(origin = {140, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {170, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_10 annotation(
    Placement(visible = true, transformation(origin = {140, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {170, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_11 annotation(
    Placement(visible = true, transformation(origin = {140, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {170, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor C0(C = Cvz, T(fixed = true, start = Tst)) annotation(
    Placement(visible = true, transformation(origin = {-140, 170}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor C1(C = Cvy, T(fixed = true, start = Tst)) annotation(
    Placement(visible = true, transformation(origin = {-140, 130}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor C2(C = Cvx, T(fixed = true, start = Tst)) annotation(
    Placement(visible = true, transformation(origin = {-140, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor C5(C = Cvz, T(fixed = true, start = Tst)) annotation(
    Placement(visible = true, transformation(origin = {-140, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor C4(C = Cvx, T(fixed = true, start = Tst)) annotation(
    Placement(visible = true, transformation(origin = {-140, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor C3(C = Cvy, T(fixed = true, start = Tst)) annotation(
    Placement(visible = true, transformation(origin = {-140, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor R12_0(R = Rz) annotation(
    Placement(visible = true, transformation(origin = {-180, 160}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor R13_1(R = Ry) annotation(
    Placement(visible = true, transformation(origin = {-180, 120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor R14_2(R = Rx) annotation(
    Placement(visible = true, transformation(origin = {-180, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor R15_3(R = Ry) annotation(
    Placement(visible = true, transformation(origin = {-180, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor R16_4(R = Rx) annotation(
    Placement(visible = true, transformation(origin = {-180, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor R17_5(R = Rz) annotation(
    Placement(visible = true, transformation(origin = {-180, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(R5_11.port_b, port_11) annotation(
    Line(points = {{110, -40}, {140, -40}, {140, -40}, {140, -40}}, color = {191, 0, 0}));
  connect(R4_10.port_b, port_10) annotation(
    Line(points = {{110, 0}, {138, 0}, {138, 0}, {140, 0}}, color = {191, 0, 0}));
  connect(R3_9.port_b, port_9) annotation(
    Line(points = {{110, 40}, {140, 40}, {140, 40}, {140, 40}}, color = {191, 0, 0}));
  connect(R2_8.port_b, port_8) annotation(
    Line(points = {{110, 80}, {140, 80}, {140, 80}, {140, 80}}, color = {191, 0, 0}));
  connect(R1_7.port_b, port_7) annotation(
    Line(points = {{110, 120}, {140, 120}}, color = {191, 0, 0}));
  connect(R0_6.port_b, port_6) annotation(
    Line(points = {{110, 160}, {142, 160}, {142, 160}, {140, 160}}, color = {191, 0, 0}));
  connect(R2_8.port_a, R5_2.port_b) annotation(
    Line(points = {{90, 80}, {72, 80}, {72, 30}, {34, 30}, {34, 30}}, color = {191, 0, 0}));
  connect(R5_11.port_a, R5_2.port_a) annotation(
    Line(points = {{90, -40}, {66, -40}, {66, 56}, {34, 56}, {34, 50}, {34, 50}}, color = {191, 0, 0}));
  connect(R4_10.port_a, R4_5.port_a) annotation(
    Line(points = {{90, 0}, {60, 0}, {60, 96}, {34, 96}, {34, 90}, {34, 90}}, color = {191, 0, 0}));
  connect(C0.port, R0_4.port_a) annotation(
    Line(points = {{-140, 160}, {34, 160}, {34, 132}, {34, 132}}, color = {191, 0, 0}));
  connect(C3.port, R5_3.port_b) annotation(
    Line(points = {{-140, 40}, {-120, 40}, {-120, 26}, {-26, 26}, {-26, 30}, {-26, 30}}, color = {191, 0, 0}));
  connect(C5.port, R5_3.port_a) annotation(
    Line(points = {{-140, -40}, {-40, -40}, {-40, 54}, {-26, 54}, {-26, 50}, {-26, 50}}, color = {191, 0, 0}));
  connect(R1_2.port_a, R0_1.port_b) annotation(
    Line(points = {{-80, 132}, {-80, 132}, {-80, 138}, {-40, 138}, {-40, 112}, {-26, 112}, {-26, 112}}, color = {191, 0, 0}));
  connect(C0.port, R0_1.port_a) annotation(
    Line(points = {{-140, 160}, {-26, 160}, {-26, 132}, {-26, 132}}, color = {191, 0, 0}));
  connect(C4.port, RR4_1.port_a) annotation(
    Line(points = {{-140, 0}, {-120, 0}, {-120, 20}, {-80, 20}, {-80, 10}, {-80, 10}}, color = {191, 0, 0}));
  connect(C3.port, R3_4.port_a) annotation(
    Line(points = {{-140, 40}, {-120, 40}, {-120, 60}, {-80, 60}, {-80, 50}, {-80, 50}}, color = {191, 0, 0}));
  connect(C2.port, R2_3.port_a) annotation(
    Line(points = {{-140, 80}, {-120, 80}, {-120, 100}, {-80, 100}, {-80, 90}, {-80, 90}}, color = {191, 0, 0}));
  connect(C1.port, R1_2.port_a) annotation(
    Line(points = {{-140, 120}, {-120, 120}, {-120, 138}, {-80, 138}, {-80, 132}, {-80, 132}}, color = {191, 0, 0}));
  connect(C5.port, R5_11.port_a) annotation(
    Line(points = {{-140, -40}, {90, -40}, {90, -40}, {90, -40}}, color = {191, 0, 0}));
  connect(C4.port, R4_10.port_a) annotation(
    Line(points = {{-140, 0}, {-120, 0}, {-120, 20}, {80, 20}, {80, 0}, {90, 0}, {90, 0}}, color = {191, 0, 0}));
  connect(C3.port, R3_9.port_a) annotation(
    Line(points = {{-140, 40}, {-120, 40}, {-120, 60}, {80, 60}, {80, 40}, {90, 40}, {90, 40}}, color = {191, 0, 0}));
  connect(C2.port, R2_8.port_a) annotation(
    Line(points = {{-140, 80}, {-120, 80}, {-120, 100}, {80, 100}, {80, 80}, {90, 80}, {90, 80}, {90, 80}}, color = {191, 0, 0}));
  connect(C1.port, R1_7.port_a) annotation(
    Line(points = {{-140, 120}, {-120, 120}, {-120, 154}, {80, 154}, {80, 120}, {90, 120}, {90, 120}}, color = {191, 0, 0}));
  connect(C0.port, R0_6.port_a) annotation(
    Line(points = {{-140, 160}, {90, 160}, {90, 160}, {90, 160}}, color = {191, 0, 0}));
  connect(R1_5.port_b, R4_5.port_b) annotation(
    Line(points = {{-26, 70}, {34, 70}}, color = {191, 0, 0}));
  connect(R4_5.port_b, R5_2.port_a) annotation(
    Line(points = {{34, 70}, {34, 50}}, color = {191, 0, 0}));
  connect(R0_4.port_b, R4_5.port_a) annotation(
    Line(points = {{34, 112}, {34, 90}}, color = {191, 0, 0}));
  connect(R0_1.port_b, R1_5.port_a) annotation(
    Line(points = {{-26, 112}, {-26, 90}}, color = {191, 0, 0}));
  connect(R1_5.port_b, R5_3.port_a) annotation(
    Line(points = {{-26, 70}, {-26, 50}}, color = {191, 0, 0}));
  connect(R3_4.port_b, RR4_1.port_a) annotation(
    Line(points = {{-80, 30}, {-80, 30}, {-80, 10}, {-80, 10}}, color = {191, 0, 0}));
  connect(R2_3.port_b, R3_4.port_a) annotation(
    Line(points = {{-80, 70}, {-80, 70}, {-80, 50}, {-80, 50}}, color = {191, 0, 0}));
  connect(R1_2.port_b, R2_3.port_a) annotation(
    Line(points = {{-80, 112}, {-80, 112}, {-80, 90}, {-80, 90}}, color = {191, 0, 0}));
  connect(R17_5.port_b, C5.port) annotation(
    Line(points = {{-170, -40}, {-140, -40}, {-140, -40}, {-140, -40}}, color = {191, 0, 0}));
  connect(R16_4.port_b, C4.port) annotation(
    Line(points = {{-170, 0}, {-140, 0}, {-140, 0}, {-140, 0}}, color = {191, 0, 0}));
  connect(R15_3.port_b, C3.port) annotation(
    Line(points = {{-170, 40}, {-140, 40}, {-140, 40}, {-140, 40}}, color = {191, 0, 0}));
  connect(R14_2.port_b, C2.port) annotation(
    Line(points = {{-170, 80}, {-140, 80}, {-140, 80}, {-140, 80}}, color = {191, 0, 0}));
  connect(R13_1.port_b, C1.port) annotation(
    Line(points = {{-170, 120}, {-140, 120}, {-140, 120}, {-140, 120}}, color = {191, 0, 0}));
  connect(R12_0.port_b, C0.port) annotation(
    Line(points = {{-170, 160}, {-140, 160}, {-140, 160}, {-140, 160}}, color = {191, 0, 0}));
  connect(port_5, R17_5.port_a) annotation(
    Line(points = {{-220, -40}, {-190, -40}, {-190, -40}, {-190, -40}}, color = {191, 0, 0}));
  connect(port_4, R16_4.port_a) annotation(
    Line(points = {{-220, 0}, {-190, 0}, {-190, 0}, {-190, 0}}, color = {191, 0, 0}));
  connect(port_3, R15_3.port_a) annotation(
    Line(points = {{-220, 40}, {-190, 40}, {-190, 40}, {-190, 40}}, color = {191, 0, 0}));
  connect(port_2, R14_2.port_a) annotation(
    Line(points = {{-220, 80}, {-190, 80}, {-190, 80}, {-190, 80}}, color = {191, 0, 0}));
  connect(port_1, R13_1.port_a) annotation(
    Line(points = {{-220, 120}, {-190, 120}, {-190, 120}, {-190, 120}}, color = {191, 0, 0}));
  connect(port_0, R12_0.port_a) annotation(
    Line(points = {{-220, 160}, {-190, 160}, {-190, 160}, {-190, 160}}, color = {191, 0, 0}));
  connect(R2_0.port_b, R0_4.port_a) annotation(
    Line(points = {{34, -10}, {34, -10}, {34, -10}, {34, -10}, {34, -16}, {54, -16}, {54, 138}, {34, 138}, {34, 132}, {34, 132}, {34, 132}, {34, 132}}, color = {191, 0, 0}));
  connect(R5_2.port_b, R2_0.port_a) annotation(
    Line(points = {{34, 30}, {34, 30}, {34, 30}, {34, 30}, {34, 10}, {34, 10}, {34, 10}, {34, 10}}, color = {191, 0, 0}));
  connect(R3_0.port_b, R0_1.port_a) annotation(
    Line(points = {{-26, -10}, {-26, -10}, {-26, -16}, {-6, -16}, {-6, 138}, {-26, 138}, {-26, 132}, {-26, 132}}, color = {191, 0, 0}));
  connect(R5_3.port_b, R3_0.port_a) annotation(
    Line(points = {{-26, 30}, {-26, 20}, {-26, 20}, {-26, 10}, {-27, 10}, {-27, 10}, {-26, 10}}, color = {191, 0, 0}));
  connect(RR4_1.port_b, R1_2.port_a) annotation(
    Line(points = {{-80, -10}, {-79.5, -10}, {-79.5, -10}, {-79, -10}, {-79, -10}, {-80, -10}, {-80, -16}, {-66, -16}, {-66, 138}, {-80, 138}, {-80, 132}, {-80, 132}, {-80, 132}, {-80, 132}}, color = {191, 0, 0}));
  annotation(
    uses(Modelica(version = "3.2.2")),
    Diagram(coordinateSystem(extent = {{-250, -100}, {250, 200}})),
    Icon(coordinateSystem(extent = {{-250, -100}, {250, 200}}, initialScale = 0.1), graphics = {Rectangle(origin = {50, 40}, extent = {{-120, 120}, {120, -120}}), Text(origin = {-65, 170}, extent = {{-19, 18}, {19, -12}}, textString = "Inner"), Text(origin = {167, 168}, extent = {{-21, 18}, {19, -12}}, textString = "Outer"), Text(origin = {47, 142}, extent = {{-15, 8}, {19, -12}}, textString = "Top"), Text(origin = {37, 106}, extent = {{-15, 8}, {35, -18}}, textString = "Front"), Text(origin = {27, 66}, extent = {{-15, 8}, {63, -16}}, textString = "LeftSide"), Text(origin = {41, 24}, extent = {{-15, 8}, {29, -14}}, textString = "Rear"), Text(origin = {21, -16}, extent = {{-15, 8}, {77, -14}}, textString = "RightSide"), Text(origin = {35, -52}, extent = {{-15, 8}, {47, -24}}, textString = "Bottom"), Line(origin = {-10, 140}, points = {{-30, 0}, {30, 0}, {30, 0}}), Line(origin = {110.545, 140.196}, points = {{-30, 0}, {30, 0}, {30, 0}}), Line(origin = {110.741, 99.8252}, points = {{-30, 0}, {30, 0}, {30, 0}}), Line(origin = {-9.80371, 99.6292}, points = {{-30, 0}, {30, 0}, {30, 0}}), Line(origin = {-9.94548, 20.3817}, points = {{-30, 0}, {30, 0}, {30, 0}}), Line(origin = {110.599, 20.5777}, points = {{-30, 0}, {30, 0}, {30, 0}}), Line(origin = {-20, -20}, points = {{-20, 0}, {20, 0}}), Line(origin = {120, -20}, points = {{20, 0}, {-20, 0}}), Line(origin = {-20, 60}, points = {{-20, 0}, {20, 0}}), Line(origin = {120, 60}, points = {{-20, 0}, {20, 0}}), Line(origin = {-15, -60}, points = {{-25, 0}, {25, 0}}), Line(origin = {115.011, -60.4798}, points = {{-25, 0}, {25, 0}}), Text(origin = {48, 176}, extent = {{-48, 18}, {48, -18}}, textString = "%name")}),
    version = "",
    __OpenModelica_commandLineOptions = "");
end ConductiveBox;
