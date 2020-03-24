within NTT;
model ModelicaEnc
  import SI=Modelica.SIunits;
  parameter SI.Length width=1"Width";
  parameter SI.Length height=1"Height";
  parameter SI.Length depth=1"Depth";
  parameter SI.Length thickness=0.002"Thickness";
  parameter SI.ThermalConductivity ke = 50 "Conductivity";
  parameter SI.SpecificHeatCapacity cp = 24 "Specific Heat Capacity";
  parameter SI.Density Ro = 3.75 "Density";
  parameter SI.Emissivity Ein = 0.7 "Inner Emissivity";
  parameter SI.Emissivity Eout = 0.7 "Outer Emissivity";
  parameter SI.Temperature T_st(start=293.15,displayUnit="degC");
  SI.CoefficientOfHeatTransfer hTopIn,hFrontRearIn,hLeftRightIn,hBottomIn;
  SI.CoefficientOfHeatTransfer hTopOut,hFrontRearOut,hLeftRightOut,hBottomOut;
  SI.Area sTop,sFront,sLeft;
  SI.Length RL;
  
  ConductiveBox CBOX(Cp = cp, Depth = depth, Height = height, Thickness = thickness, Tst = T_st, Width = width, k = ke, ro = Ro)  annotation(
    Placement(visible = true, transformation(origin = {-4, -4}, extent = {{-25, -10}, {25, 20}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.Convection convTopIn annotation(
    Placement(visible = true, transformation(origin = {-50, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Thermal.HeatTransfer.Components.BodyRadiation RadTopIn(Gr = Ein * width * depth)  annotation(
    Placement(visible = true, transformation(origin = {-20, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Thermal.HeatTransfer.Components.BodyRadiation RadTopOut(Gr = Eout * width * depth)  annotation(
    Placement(visible = true, transformation(origin = {50, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Thermal.HeatTransfer.Components.Convection convTopOut annotation(
    Placement(visible = true, transformation(origin = {20, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Thermal.HeatTransfer.Components.BodyRadiation RadSideOut[4](Gr = {Eout * width * height,Eout*depth*height,Eout * width * height,Eout*depth*height}) annotation(
    Placement(visible = true, transformation(origin = {80, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.Convection convSideOut[4] annotation(
    Placement(visible = true, transformation(origin = {80, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.Convection convSideIn[4] annotation(
    Placement(visible = true, transformation(origin = {-80, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.BodyRadiation RadSideIn[4](Gr = {Ein * width * height,Ein*depth*height,Ein * width * height,Ein*depth*height}) annotation(
    Placement(visible = true, transformation(origin = {-80, -20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.BodyRadiation RadBottomIn(Gr = Ein * width * depth)  annotation(
    Placement(visible = true, transformation(origin = {-20, -90}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Thermal.HeatTransfer.Components.Convection convBottomIn annotation(
    Placement(visible = true, transformation(origin = {-50, -90}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Thermal.HeatTransfer.Components.Convection convBottomOut annotation(
    Placement(visible = true, transformation(origin = {20, -90}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Thermal.HeatTransfer.Components.BodyRadiation RadBottomOut(Gr = Eout * width * depth)  annotation(
    Placement(visible = true, transformation(origin = {50, -90}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_con_a[6] annotation(
    Placement(visible = true, transformation(origin = {-120, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_rad_a[6] annotation(
    Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_con_b[6] annotation(
    Placement(visible = true, transformation(origin = {120, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_rad_b[6] annotation(
    Placement(visible = true, transformation(origin = {120, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  sTop=width*depth;
  sFront=width*height;
  sLeft=depth*height;

//Convection
  RL=2*width*depth/(width+depth);
  hTopIn=2.51*0.54*(abs(convTopIn.solid.T-convTopIn.fluid.T)/RL)^0.25;
  hTopOut=2.51*0.54*(abs(convTopOut.solid.T-convTopOut.fluid.T)/RL)^0.25;
  hFrontRearIn=2.51*0.56*(abs(convSideIn[1].solid.T-convSideIn[1].fluid.T)/height)^0.25;
  hLeftRightIn=2.51*0.56*(abs(convSideIn[2].solid.T-convSideIn[2].fluid.T)/height)^0.25;
  hFrontRearOut=2.51*0.56*(abs(convSideOut[1].solid.T-convSideOut[1].fluid.T)/height)^0.25;
  hLeftRightOut=2.51*0.56*(abs(convSideOut[2].solid.T-convSideOut[2].fluid.T)/height)^0.25;
  hBottomIn=2.51*0.27*(abs(convBottomIn.solid.T-convBottomIn.fluid.T)/RL)^0.25;
  hBottomOut=2.51*0.27*(abs(convBottomOut.solid.T-convBottomOut.fluid.T)/RL)^0.25;
  convTopIn.Gc=sTop*hTopIn;
  convSideIn[1].Gc=sFront*hFrontRearIn;
  convSideIn[2].Gc=sLeft*hLeftRightIn;
  convSideIn[3].Gc=convSideIn[1].Gc;
  convSideIn[4].Gc=convSideIn[2].Gc;
  convBottomIn.Gc=sTop*hBottomIn;
  convTopOut.Gc=sTop*hTopOut;
  convSideOut[1].Gc=sFront*hFrontRearOut;
  convSideOut[2].Gc=sLeft*hLeftRightOut;
  convSideOut[3].Gc=convSideOut[1].Gc;
  convSideOut[4].Gc=convSideOut[2].Gc;
  convBottomOut.Gc=sTop*hBottomOut;
  
  connect(convBottomOut.fluid, port_con_b[6]) annotation(
    Line(points = {{20, -100}, {20, -100}, {20, -110}, {102, -110}, {102, 60}, {120, 60}, {120, 60}}, color = {191, 0, 0}));
  connect(convSideOut[4].fluid, port_con_b[5]) annotation(
    Line(points = {{90, 20}, {102, 20}, {102, 60}, {120, 60}, {120, 60}}, color = {191, 0, 0}, thickness = 0.5));
  connect(convSideOut[3].fluid, port_con_b[4]) annotation(
    Line(points = {{90, 20}, {102, 20}, {102, 60}, {120, 60}, {120, 60}}, color = {191, 0, 0}, thickness = 0.5));
  connect(convSideOut[2].fluid, port_con_b[3]) annotation(
    Line(points = {{90, 20}, {102, 20}, {102, 60}, {120, 60}, {120, 60}}, color = {191, 0, 0}, thickness = 0.5));
  connect(convSideOut[1].fluid, port_con_b[2]) annotation(
    Line(points = {{90, 20}, {102, 20}, {102, 60}, {120, 60}, {120, 60}}, color = {191, 0, 0}, thickness = 0.5));
  connect(convTopOut.fluid, port_con_b[1]) annotation(
    Line(points = {{20, 100}, {20, 100}, {20, 112}, {102, 112}, {102, 60}, {120, 60}, {120, 60}}, color = {191, 0, 0}));
  connect(RadBottomOut.port_b, port_rad_b[6]) annotation(
    Line(points = {{50, -100}, {50, -100}, {50, -108}, {100, -108}, {100, -60}, {120, -60}, {120, -60}}, color = {191, 0, 0}));
  connect(RadSideOut[4].port_b, port_rad_b[5]) annotation(
    Line(points = {{90, -20}, {100, -20}, {100, -60}, {120, -60}, {120, -60}}, color = {191, 0, 0}, thickness = 0.5));
  connect(RadSideOut[3].port_b, port_rad_b[4]) annotation(
    Line(points = {{90, -20}, {100, -20}, {100, -60}, {120, -60}, {120, -60}}, color = {191, 0, 0}, thickness = 0.5));
  connect(RadSideOut[2].port_b, port_rad_b[3]) annotation(
    Line(points = {{90, -20}, {100, -20}, {100, -60}, {120, -60}, {120, -60}}, color = {191, 0, 0}, thickness = 0.5));
  connect(RadSideOut[1].port_b, port_rad_b[2]) annotation(
    Line(points = {{90, -20}, {100, -20}, {100, -60}, {120, -60}, {120, -60}}, color = {191, 0, 0}, thickness = 0.5));
  connect(RadTopOut.port_b, port_rad_b[1]) annotation(
    Line(points = {{50, 100}, {50, 100}, {50, 110}, {100, 110}, {100, -60}, {120, -60}, {120, -60}}, color = {191, 0, 0}));
  connect(RadBottomIn.port_b, port_rad_a[6]) annotation(
    Line(points = {{-20, -100}, {-18, -100}, {-18, -110}, {-102, -110}, {-102, -60}, {-120, -60}, {-120, -60}}, color = {191, 0, 0}));
  connect(RadSideIn[4].port_b, port_rad_a[5]) annotation(
    Line(points = {{-90, -20}, {-102, -20}, {-102, -60}, {-120, -60}, {-120, -60}}, color = {191, 0, 0}, thickness = 0.5));
  connect(RadSideIn[3].port_b, port_rad_a[4]) annotation(
    Line(points = {{-90, -20}, {-102, -20}, {-102, -60}, {-120, -60}, {-120, -60}}, color = {191, 0, 0}, thickness = 0.5));
  connect(RadSideIn[2].port_b, port_rad_a[3]) annotation(
    Line(points = {{-90, -20}, {-102, -20}, {-102, -60}, {-120, -60}, {-120, -60}}, color = {191, 0, 0}, thickness = 0.5));
  connect(RadSideIn[1].port_b, port_rad_a[2]) annotation(
    Line(points = {{-90, -20}, {-102, -20}, {-102, -60}, {-120, -60}, {-120, -60}}, color = {191, 0, 0}, thickness = 0.5));
  connect(RadTopIn.port_b, port_rad_a[1]) annotation(
    Line(points = {{-20, 100}, {-20, 100}, {-20, 112}, {-102, 112}, {-102, -60}, {-120, -60}, {-120, -60}}, color = {191, 0, 0}));
  connect(convBottomIn.fluid, port_con_a[6]) annotation(
    Line(points = {{-50, -100}, {-50, -100}, {-50, -108}, {-100, -108}, {-100, 60}, {-120, 60}, {-120, 60}}, color = {191, 0, 0}));
  connect(convSideIn[4].fluid, port_con_a[5]) annotation(
    Line(points = {{-90, 20}, {-100, 20}, {-100, 60}, {-120, 60}, {-120, 60}}, color = {191, 0, 0}, thickness = 0.5));
  connect(convSideIn[3].fluid, port_con_a[4]) annotation(
    Line(points = {{-90, 20}, {-100, 20}, {-100, 60}, {-120, 60}, {-120, 60}}, color = {191, 0, 0}, thickness = 0.5));
  connect(convSideIn[2].fluid, port_con_a[3]) annotation(
    Line(points = {{-90, 20}, {-100, 20}, {-100, 60}, {-120, 60}, {-120, 60}}, color = {191, 0, 0}, thickness = 0.5));
  connect(convSideIn[1].fluid, port_con_a[2]) annotation(
    Line(points = {{-90, 20}, {-100, 20}, {-100, 60}, {-120, 60}, {-120, 60}}, color = {191, 0, 0}, thickness = 0.5));
  connect(convTopIn.fluid, port_con_a[1]) annotation(
    Line(points = {{-50, 100}, {-50, 100}, {-50, 110}, {-100, 110}, {-100, 60}, {-120, 60}, {-120, 60}}, color = {191, 0, 0}));
  connect(CBOX.port_11, RadBottomOut.port_a) annotation(
    Line(points = {{14, -10}, {50, -10}, {50, -80}, {50, -80}}, color = {191, 0, 0}));
  connect(CBOX.port_11, convBottomOut.solid) annotation(
    Line(points = {{14, -10}, {20, -10}, {20, -80}, {20, -80}}, color = {191, 0, 0}));
  connect(RadSideOut[4].port_a, CBOX.port_10) annotation(
    Line(points = {{70, -20}, {60, -20}, {60, -6}, {14, -6}, {14, -6}}, color = {191, 0, 0}, thickness = 0.5));
  connect(RadSideOut[3].port_a, CBOX.port_8) annotation(
    Line(points = {{70, -20}, {60, -20}, {60, 2}, {14, 2}, {14, 2}}, color = {191, 0, 0}, thickness = 0.5));
  connect(RadSideOut[2].port_a, CBOX.port_9) annotation(
    Line(points = {{70, -20}, {60, -20}, {60, -2}, {14, -2}, {14, -2}}, color = {191, 0, 0}, thickness = 0.5));
  connect(RadSideOut[1].port_a, CBOX.port_7) annotation(
    Line(points = {{70, -20}, {60, -20}, {60, 6}, {14, 6}, {14, 6}}, color = {191, 0, 0}, thickness = 0.5));
  connect(convSideOut[4].solid, CBOX.port_10) annotation(
    Line(points = {{70, 20}, {60, 20}, {60, -6}, {14, -6}, {14, -6}}, color = {191, 0, 0}, thickness = 0.5));
  connect(convSideOut[3].solid, CBOX.port_8) annotation(
    Line(points = {{70, 20}, {60, 20}, {60, 2}, {14, 2}, {14, 2}}, color = {191, 0, 0}, thickness = 0.5));
  connect(convSideOut[2].solid, CBOX.port_9) annotation(
    Line(points = {{70, 20}, {60, 20}, {60, -2}, {14, -2}, {14, -2}}, color = {191, 0, 0}, thickness = 0.5));
  connect(convSideOut[1].solid, CBOX.port_7) annotation(
    Line(points = {{70, 20}, {60, 20}, {60, 6}, {14, 6}, {14, 6}}, color = {191, 0, 0}, thickness = 0.5));
  connect(CBOX.port_6, RadTopOut.port_a) annotation(
    Line(points = {{14, 10}, {50, 10}, {50, 80}, {50, 80}}, color = {191, 0, 0}));
  connect(CBOX.port_6, convTopOut.solid) annotation(
    Line(points = {{14, 10}, {20, 10}, {20, 80}, {20, 80}}, color = {191, 0, 0}));
  connect(RadSideIn[4].port_a, CBOX.port_4) annotation(
    Line(points = {{-70, -20}, {-60, -20}, {-60, -6}, {-12, -6}, {-12, -6}}, color = {191, 0, 0}, thickness = 0.5));
  connect(RadSideIn[3].port_a, CBOX.port_2) annotation(
    Line(points = {{-70, -20}, {-60, -20}, {-60, 2}, {-12, 2}, {-12, 2}}, color = {191, 0, 0}, thickness = 0.5));
  connect(RadSideIn[2].port_a, CBOX.port_3) annotation(
    Line(points = {{-70, -20}, {-60, -20}, {-60, -2}, {-12, -2}, {-12, -2}}, color = {191, 0, 0}, thickness = 0.5));
  connect(RadSideIn[1].port_a, CBOX.port_1) annotation(
    Line(points = {{-70, -20}, {-60, -20}, {-60, 6}, {-12, 6}, {-12, 6}}, color = {191, 0, 0}, thickness = 0.5));
  connect(convSideIn[4].solid, CBOX.port_4) annotation(
    Line(points = {{-70, 20}, {-60, 20}, {-60, -6}, {-12, -6}, {-12, -6}}, color = {191, 0, 0}, thickness = 0.5));
  connect(convSideIn[3].solid, CBOX.port_2) annotation(
    Line(points = {{-70, 20}, {-60, 20}, {-60, 2}, {-12, 2}, {-12, 2}}, color = {191, 0, 0}, thickness = 0.5));
  connect(convSideIn[2].solid, CBOX.port_3) annotation(
    Line(points = {{-70, 20}, {-60, 20}, {-60, -2}, {-12, -2}, {-12, -2}}, color = {191, 0, 0}, thickness = 0.5));
  connect(convSideIn[1].solid, CBOX.port_1) annotation(
    Line(points = {{-70, 20}, {-60, 20}, {-60, 6}, {-12, 6}, {-12, 6}}, color = {191, 0, 0}, thickness = 0.5));
  connect(CBOX.port_5, convBottomIn.solid) annotation(
    Line(points = {{-12, -10}, {-50, -10}, {-50, -80}}, color = {191, 0, 0}));
  connect(CBOX.port_5, RadBottomIn.port_a) annotation(
    Line(points = {{-12, -10}, {-20, -10}, {-20, -80}}, color = {191, 0, 0}));
  connect(CBOX.port_0, RadTopIn.port_a) annotation(
    Line(points = {{-12, 10}, {-20, 10}, {-20, 80}}, color = {191, 0, 0}));
  connect(CBOX.port_0, convTopIn.solid) annotation(
    Line(points = {{-12, 10}, {-50, 10}, {-50, 80}}, color = {191, 0, 0}));
  annotation(
    uses(Modelica(version = "3.2.2")),
    Diagram(coordinateSystem(extent = {{-120, -120}, {120, 120}})),
    Icon(coordinateSystem(extent = {{-120, -120}, {120, 120}}, initialScale = 0.1), graphics = {Rectangle(origin = {0, -1}, extent = {{-120, 121}, {120, -119}}), Text(origin = {-35, 65}, extent = {{-45, 15}, {115, -25}}, textString = "Convection"), Line(origin = {-95, 60}, points = {{-15, 0}, {15, 0}}, thickness = 1), Line(origin = {95.3236, 59.0397}, points = {{-15, 0}, {15, 0}}, thickness = 1), Line(origin = {95.1461, -60.9185}, points = {{-15, 0}, {15, 0}}, thickness = 1), Line(origin = {-95.1775, -59.9582}, points = {{-15, 0}, {15, 0}}, thickness = 1), Text(origin = {-35, -55}, extent = {{-45, 15}, {115, -25}}, textString = "Radiation"), Text(origin = {-90, 10}, extent = {{-30, 10}, {10, -30}}, textString = "In"), Text(origin = {90, 10}, extent = {{-50, 10}, {10, -30}}, textString = "Out"), Text(origin = {0, 100}, extent = {{-120, 20}, {120, -20}}, textString = "Enclosure-M")}),
    version = "",
    __OpenModelica_commandLineOptions = "");
end ModelicaEnc;
