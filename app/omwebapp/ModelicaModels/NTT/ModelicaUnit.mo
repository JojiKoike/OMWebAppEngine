within NTT;
model ModelicaUnit
  import SI=Modelica.SIunits;
  parameter SI.Length width=0.1"Width";
  parameter SI.Length height=0.1"Height";
  parameter SI.Length depth=0.1"Depth";
  parameter SI.HeatFlowRate Power=1;
  parameter SI.SpecificHeatCapacity cp = 24 "Specific Heat Capacity";
  parameter SI.Emissivity E = 0.7 "Emissivity";
  parameter SI.Temperature T_st(start=293.15,displayUnit="degC");
  SI.CoefficientOfHeatTransfer hTop,hFrontRear,hLeftRight,hBottom;
  SI.Area sTop,sFront,sLeft;
  SI.Length RL;

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor UnitCap(C = cp, T(fixed = true, start = T_st))  annotation(
    Placement(visible = true, transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow UnitHeater(Q_flow = Power)  annotation(
    Placement(visible = true, transformation(origin = {-60, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Thermal.HeatTransfer.Components.Convection convTop annotation(
    Placement(visible = true, transformation(origin = {-40, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Thermal.HeatTransfer.Components.Convection convSide[4] annotation(
    Placement(visible = true, transformation(origin = {40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.Convection convBottom annotation(
    Placement(visible = true, transformation(origin = {-40, -60}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Thermal.HeatTransfer.Components.BodyRadiation RadTop(Gr = E * width * depth) annotation(
    Placement(visible = true, transformation(origin = {0, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Thermal.HeatTransfer.Components.BodyRadiation RadSide[4](Gr = {E * width * height,E*depth*height,E * width * height,E*depth*height}) annotation(
    Placement(visible = true, transformation(origin = {40, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.BodyRadiation RadBottom(Gr = E * width * depth) annotation(
    Placement(visible = true, transformation(origin = {0, -60}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a portConv[6] annotation(
    Placement(visible = true, transformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a portEmi[6] annotation(
    Placement(visible = true, transformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation

  sTop=width*depth;
  sFront=width*height;
  sLeft=depth*height;

//Convection
  RL=2*width*depth/(width+depth);
  hTop=2.51*0.54*(abs(convTop.solid.T-convTop.fluid.T)/RL)^0.25;
  hFrontRear=2.51*0.56*(abs(convSide[1].solid.T-convSide[1].fluid.T)/height)^0.25;
  hLeftRight=2.51*0.56*(abs(convSide[2].solid.T-convSide[2].fluid.T)/height)^0.25;
  hBottom=2.51*0.27*(abs(convBottom.solid.T-convBottom.fluid.T)/RL)^0.25;
  convTop.Gc=sTop*hTop;
  convSide[1].Gc=sFront*hFrontRear;
  convSide[2].Gc=sLeft*hLeftRight;
  convSide[3].Gc=convSide[1].Gc;
  convSide[4].Gc=convSide[2].Gc;
  convBottom.Gc=sTop*hBottom;

  connect(convBottom.fluid, portConv[6]) annotation(
    Line(points = {{-40, -70}, {-40, -70}, {-40, -82}, {62, -82}, {62, 60}, {100, 60}, {100, 60}}, color = {191, 0, 0}));
  connect(RadBottom.port_b, portEmi[6]) annotation(
    Line(points = {{0, -70}, {0, -70}, {0, -80}, {60, -80}, {60, -40}, {100, -40}, {100, -40}}, color = {191, 0, 0}));
  connect(RadSide[4].port_b, portEmi[5]) annotation(
    Line(points = {{50, -20}, {60, -20}, {60, -40}, {100, -40}, {100, -40}}, color = {191, 0, 0}, thickness = 0.5));
  connect(RadSide[3].port_b, portEmi[4]) annotation(
    Line(points = {{50, -20}, {60, -20}, {60, -40}, {100, -40}, {100, -40}}, color = {191, 0, 0}, thickness = 0.5));
  connect(RadSide[2].port_b, portEmi[3]) annotation(
    Line(points = {{50, -20}, {60, -20}, {60, -40}, {100, -40}, {100, -40}}, color = {191, 0, 0}, thickness = 0.5));
  connect(RadSide[1].port_b, portEmi[2]) annotation(
    Line(points = {{50, -20}, {60, -20}, {60, -40}, {100, -40}, {100, -40}}, color = {191, 0, 0}, thickness = 0.5));
  connect(convSide[4].fluid, portConv[5]) annotation(
    Line(points = {{50, 20}, {62, 20}, {62, 60}, {100, 60}, {100, 60}}, color = {191, 0, 0}, thickness = 0.5));
  connect(convSide[3].fluid, portConv[4]) annotation(
    Line(points = {{50, 20}, {62, 20}, {62, 60}, {100, 60}, {100, 60}}, color = {191, 0, 0}, thickness = 0.5));
  connect(convSide[2].fluid, portConv[3]) annotation(
    Line(points = {{50, 20}, {62, 20}, {62, 60}, {100, 60}, {100, 60}}, color = {191, 0, 0}, thickness = 0.5));
  connect(convSide[1].fluid, portConv[2]) annotation(
    Line(points = {{50, 20}, {62, 20}, {62, 60}, {100, 60}, {100, 60}}, color = {191, 0, 0}, thickness = 0.5));
  connect(convTop.fluid, portConv[1]) annotation(
    Line(points = {{-40, 70}, {-40, 70}, {-40, 82}, {62, 82}, {62, 60}, {100, 60}, {100, 60}}, color = {191, 0, 0}));
  connect(RadTop.port_b, portEmi[1]) annotation(
    Line(points = {{0, 70}, {0, 70}, {0, 80}, {60, 80}, {60, -40}, {100, -40}, {100, -40}}, color = {191, 0, 0}));
  connect(UnitCap.port, convBottom.solid) annotation(
    Line(points = {{-60, 0}, {-40, 0}, {-40, -50}}, color = {191, 0, 0}));
  connect(UnitCap.port, RadBottom.port_a) annotation(
    Line(points = {{-60, 0}, {0, 0}, {0, -50}}, color = {191, 0, 0}));
  connect(UnitCap.port, RadTop.port_a) annotation(
    Line(points = {{-60, 0}, {0, 0}, {0, 50}}, color = {191, 0, 0}));
  connect(UnitCap.port, convTop.solid) annotation(
    Line(points = {{-60, 0}, {-40, 0}, {-40, 50}}, color = {191, 0, 0}));
  connect(UnitHeater.port, UnitCap.port) annotation(
    Line(points = {{-60, -20}, {-60, -20}, {-60, 0}, {-60, 0}}, color = {191, 0, 0}));
  connect(UnitCap.port, RadSide[4].port_a) annotation(
    Line(points = {{-60, 0}, {30, 0}, {30, -20}, {30, -20}}, color = {191, 0, 0}));
  connect(UnitCap.port, RadSide[3].port_a) annotation(
    Line(points = {{-60, 0}, {30, 0}, {30, -20}, {30, -20}}, color = {191, 0, 0}));
  connect(UnitCap.port, RadSide[2].port_a) annotation(
    Line(points = {{-60, 0}, {30, 0}, {30, -20}, {30, -20}}, color = {191, 0, 0}));
  connect(UnitCap.port, RadSide[1].port_a) annotation(
    Line(points = {{-60, 0}, {30, 0}, {30, -20}, {30, -20}}, color = {191, 0, 0}));
  connect(UnitCap.port, convSide[4].solid) annotation(
    Line(points = {{-60, 0}, {30, 0}, {30, 20}, {30, 20}}, color = {191, 0, 0}));
  connect(UnitCap.port, convSide[3].solid) annotation(
    Line(points = {{-60, 0}, {30, 0}, {30, 20}, {30, 20}}, color = {191, 0, 0}));
  connect(UnitCap.port, convSide[2].solid) annotation(
    Line(points = {{-60, 0}, {30, 0}, {30, 20}, {30, 20}}, color = {191, 0, 0}));
  connect(UnitCap.port, convSide[1].solid) annotation(
    Line(points = {{-60, 0}, {30, 0}, {30, 20}, {30, 20}}, color = {191, 0, 0}));
  annotation(
    uses(Modelica(version = "3.2.2")),
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {24, 60}, extent = {{-60, 20}, {60, -20}}, textString = "Convection"), Text(origin = {24, -56}, extent = {{-36, 14}, {60, -20}}, textString = "Radiation"), Text(extent = {{-100, 40}, {100, -40}}, textString = "Unit-M")}));
end ModelicaUnit;
