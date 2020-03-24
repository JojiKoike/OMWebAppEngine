within NTT;

model Enclosure
  import SI = Modelica.SIunits;
  parameter SI.Length width = 0.1 "Enc Width";
  parameter SI.Length depth = 0.1 "Enc Depth";
  parameter SI.Length height = 0.1 "Enc Height";
  parameter SI.Length thickness = 0.002 "Enc Thickness";
  parameter SI.ThermalConductivity ke = 50 "Enc Conductivity";
  parameter SI.SpecificHeatCapacity cp = 24 "Enc Specific Heat Capacity";
  parameter SI.Density Ro = 3.75 "Enc Density";
  parameter SI.Emissivity Ein = 0.7 "Enc Inner Emissivity";
  parameter SI.Emissivity Eout = 0.7 "Enc Outer Emissivity";
  parameter SI.Temperature T_st = 293.15 "Enc Start Temperature";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_con_a[6] annotation(
    Placement(visible = true, transformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_con_b[6] annotation(
    Placement(visible = true, transformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_rad_a[6] annotation(
    Placement(visible = true, transformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_rad_b[6] annotation(
    Placement(visible = true, transformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  NTT.ConductiveBox conductiveBox1(Cp = cp, Depth = depth, Height = height, Thickness = thickness, Tst = T_st, Width = width, k = ke, ro = Ro) annotation(
    Placement(visible = true, transformation(origin = {-6, -6}, extent = {{-25, -10}, {25, 20}}, rotation = 0)));
  NTT.NaturanConvection_Top1 ConvTopIn(depth = depth, width = width) annotation(
    Placement(visible = true, transformation(origin = {-40, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  NTT.NaturanConvection_Bottom1 ConBottomIn(depth = depth, width = width) annotation(
    Placement(visible = true, transformation(origin = {-40, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  NTT.Radiative radTopIn(E = Ein, area = width * depth) annotation(
    Placement(visible = true, transformation(origin = {-20, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  NTT.Radiative radBottomIn(E = Ein, area = width * depth) annotation(
    Placement(visible = true, transformation(origin = {-20, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  NTT.Radiative radTopOut(E = Eout, area = width * depth) annotation(
    Placement(visible = true, transformation(origin = {40, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  NTT.NaturanConvection_Top1 ConTopOut(depth = depth, width = width) annotation(
    Placement(visible = true, transformation(origin = {20, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  NTT.Radiative radBottomOut(E = Eout, area = width * depth) annotation(
    Placement(visible = true, transformation(origin = {40, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  NTT.NaturanConvection_Bottom1 ConBottomOut(depth = depth, width = width) annotation(
    Placement(visible = true, transformation(origin = {20, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  NTT.Radiative radFrontRearIn[2](each E = Ein, each area = width * height) annotation(
    Placement(visible = true, transformation(origin = {-60, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  NTT.Radiative radFrontRearOut[2](each E = Eout, each area = width * height) annotation(
    Placement(visible = true, transformation(origin = {60, 50}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
  NTT.NaturanConvection_Side ConvFrontRearOut[2](each area = width * height, each height = height) annotation(
    Placement(visible = true, transformation(origin = {60, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  NTT.NaturanConvection_Side ConvFrontRearIn[2](each area = width * height, each height = height) annotation(
    Placement(visible = true, transformation(origin = {-60, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  NTT.NaturanConvection_Side ConvLeftRightIn[2](each area = depth * height, each height = height) annotation(
    Placement(visible = true, transformation(origin = {-60, -50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  NTT.Radiative radLeftRightIn[2](each E = Ein, each area = depth * height) annotation(
    Placement(visible = true, transformation(origin = {-60, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  NTT.NaturanConvection_Side ConvLeftRightOut[2](each area = depth * height, each height = height) annotation(
    Placement(visible = true, transformation(origin = {60, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  NTT.Radiative radLeftRightOut[2](each E = Eout, each area = depth * height) annotation(
    Placement(visible = true, transformation(origin = {60, -30}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
equation
  connect(radLeftRightOut[2].fluid, port_rad_b[5]) annotation(
    Line(points = {{64, -30}, {80, -30}, {80, -40}, {100, -40}, {100, -40}}, color = {191, 0, 0}, thickness = 0.5));
  connect(radLeftRightOut[1].fluid, port_rad_b[4]) annotation(
    Line(points = {{64, -30}, {80, -30}, {80, -40}, {100, -40}, {100, -40}}, color = {191, 0, 0}, thickness = 0.5));
  connect(radFrontRearOut[2].fluid, port_rad_b[3]) annotation(
    Line(points = {{64, 50}, {80, 50}, {80, -40}, {100, -40}, {100, -40}}, color = {191, 0, 0}, thickness = 0.5));
  connect(radFrontRearOut[1].fluid, port_rad_b[2]) annotation(
    Line(points = {{64, 50}, {80, 50}, {80, -40}, {100, -40}, {100, -40}}, color = {191, 0, 0}, thickness = 0.5));
  connect(ConvLeftRightOut[2].fluid, port_con_b[5]) annotation(
    Line(points = {{68, -50}, {82, -50}, {82, 40}, {100, 40}, {100, 40}}, color = {191, 0, 0}, thickness = 0.5));
  connect(ConvLeftRightOut[1].fluid, port_con_b[4]) annotation(
    Line(points = {{68, -50}, {82, -50}, {82, 40}, {100, 40}, {100, 40}}, color = {191, 0, 0}, thickness = 0.5));
  connect(ConvFrontRearOut[2].fluid, port_con_b[3]) annotation(
    Line(points = {{68, 30}, {82, 30}, {82, 40}, {100, 40}, {100, 40}}, color = {191, 0, 0}, thickness = 0.5));
  connect(ConvFrontRearOut[1].fluid, port_con_b[2]) annotation(
    Line(points = {{68, 30}, {82, 30}, {82, 40}, {100, 40}, {100, 40}}, color = {191, 0, 0}, thickness = 0.5));
  connect(radLeftRightIn[2].fluid, port_rad_a[5]) annotation(
    Line(points = {{-64, -30}, {-82, -30}, {-82, -40}, {-100, -40}, {-100, -40}}, color = {191, 0, 0}, thickness = 0.5));
  connect(radLeftRightIn[1].fluid, port_rad_a[4]) annotation(
    Line(points = {{-64, -30}, {-82, -30}, {-82, -40}, {-100, -40}, {-100, -40}}, color = {191, 0, 0}, thickness = 0.5));
  connect(radFrontRearIn[2].fluid, port_rad_a[3]) annotation(
    Line(points = {{-64, 50}, {-82, 50}, {-82, -40}, {-100, -40}, {-100, -40}}, color = {191, 0, 0}, thickness = 0.5));
  connect(radFrontRearIn[1].fluid, port_rad_a[2]) annotation(
    Line(points = {{-64, 50}, {-82, 50}, {-82, -40}, {-100, -40}, {-100, -40}}, color = {191, 0, 0}, thickness = 0.5));
  connect(ConvLeftRightIn[2].fluid, port_con_a[5]) annotation(
    Line(points = {{-68, -50}, {-80, -50}, {-80, 40}, {-100, 40}, {-100, 40}}, color = {191, 0, 0}, thickness = 0.5));
  connect(ConvLeftRightIn[1].fluid, port_con_a[4]) annotation(
    Line(points = {{-68, -50}, {-80, -50}, {-80, 40}, {-100, 40}, {-100, 40}}, color = {191, 0, 0}, thickness = 0.5));
  connect(ConvFrontRearIn[2].fluid, port_con_a[3]) annotation(
    Line(points = {{-68, 30}, {-80, 30}, {-80, 40}, {-100, 40}, {-100, 40}}, color = {191, 0, 0}, thickness = 0.5));
  connect(ConvFrontRearIn[1].fluid, port_con_a[2]) annotation(
    Line(points = {{-68, 30}, {-80, 30}, {-80, 40}, {-100, 40}, {-100, 40}}, color = {191, 0, 0}, thickness = 0.5));
  connect(conductiveBox1.port_10, ConvLeftRightOut[2].solid) annotation(
    Line(points = {{12, -8}, {46, -8}, {46, -50}, {52, -50}, {52, -50}}, color = {191, 0, 0}));
  connect(conductiveBox1.port_8, ConvLeftRightOut[1].solid) annotation(
    Line(points = {{12, 0}, {46, 0}, {46, -50}, {52, -50}, {52, -50}}, color = {191, 0, 0}));
  connect(conductiveBox1.port_10, radLeftRightOut[2].solid) annotation(
    Line(points = {{12, -8}, {44, -8}, {44, -30}, {54, -30}, {54, -30}}, color = {191, 0, 0}));
  connect(conductiveBox1.port_8, radLeftRightOut[1].solid) annotation(
    Line(points = {{12, 0}, {44, 0}, {44, -30}, {54, -30}, {54, -30}}, color = {191, 0, 0}));
  connect(conductiveBox1.port_9, ConvFrontRearOut[2].solid) annotation(
    Line(points = {{12, -4}, {46, -4}, {46, 30}, {52, 30}, {52, 30}}, color = {191, 0, 0}));
  connect(conductiveBox1.port_7, ConvFrontRearOut[1].solid) annotation(
    Line(points = {{12, 4}, {46, 4}, {46, 30}, {52, 30}, {52, 30}}, color = {191, 0, 0}));
  connect(conductiveBox1.port_9, radFrontRearOut[2].solid) annotation(
    Line(points = {{12, -4}, {44, -4}, {44, 50}, {54, 50}, {54, 50}}, color = {191, 0, 0}));
  connect(conductiveBox1.port_7, radFrontRearOut[1].solid) annotation(
    Line(points = {{12, 4}, {44, 4}, {44, 50}, {54, 50}, {54, 50}}, color = {191, 0, 0}));
  connect(conductiveBox1.port_4, ConvLeftRightIn[2].solid) annotation(
    Line(points = {{-12, -8}, {-46, -8}, {-46, -50}, {-52, -50}, {-52, -50}}, color = {191, 0, 0}));
  connect(conductiveBox1.port_2, ConvLeftRightIn[1].solid) annotation(
    Line(points = {{-12, 0}, {-46, 0}, {-46, -50}, {-52, -50}, {-52, -50}}, color = {191, 0, 0}));
  connect(conductiveBox1.port_3, ConvFrontRearIn[2].solid) annotation(
    Line(points = {{-12, -4}, {-46, -4}, {-46, 30}, {-52, 30}, {-52, 30}}, color = {191, 0, 0}));
  connect(conductiveBox1.port_1, ConvFrontRearIn[1].solid) annotation(
    Line(points = {{-12, 4}, {-46, 4}, {-46, 30}, {-52, 30}, {-52, 30}}, color = {191, 0, 0}));
  connect(conductiveBox1.port_4, radLeftRightIn[2].solid) annotation(
    Line(points = {{-12, -8}, {-44, -8}, {-44, -30}, {-54, -30}, {-54, -30}}, color = {191, 0, 0}));
  connect(conductiveBox1.port_2, radLeftRightIn[1].solid) annotation(
    Line(points = {{-12, 0}, {-44, 0}, {-44, -30}, {-54, -30}, {-54, -30}}, color = {191, 0, 0}));
  connect(conductiveBox1.port_3, radFrontRearIn[2].solid) annotation(
    Line(points = {{-12, -4}, {-44, -4}, {-44, 50}, {-54, 50}, {-54, 50}}, color = {191, 0, 0}));
  connect(conductiveBox1.port_1, radFrontRearIn[1].solid) annotation(
    Line(points = {{-12, 4}, {-44, 4}, {-44, 50}, {-54, 50}, {-54, 50}}, color = {191, 0, 0}));
  connect(radBottomOut.fluid, port_rad_b[6]) annotation(
    Line(points = {{40, -70}, {40, -70}, {40, -80}, {80, -80}, {80, -40}, {100, -40}, {100, -40}}, color = {191, 0, 0}));
  connect(radTopOut.fluid, port_rad_b[1]) annotation(
    Line(points = {{40, 70}, {40, 70}, {40, 80}, {80, 80}, {80, -40}, {100, -40}, {100, -40}}, color = {191, 0, 0}));
  connect(ConBottomOut.fluid, port_con_b[6]) annotation(
    Line(points = {{20, -74}, {20, -74}, {20, -82}, {82, -82}, {82, 40}, {100, 40}, {100, 40}}, color = {191, 0, 0}));
  connect(ConTopOut.fluid, port_con_b[1]) annotation(
    Line(points = {{20, 72}, {20, 72}, {20, 82}, {82, 82}, {82, 40}, {100, 40}, {100, 40}}, color = {191, 0, 0}));
  connect(radBottomIn.fluid, port_rad_a[6]) annotation(
    Line(points = {{-20, -70}, {-20, -70}, {-20, -82}, {-82, -82}, {-82, -40}, {-100, -40}, {-100, -40}}, color = {191, 0, 0}));
  connect(radTopIn.fluid, port_rad_a[1]) annotation(
    Line(points = {{-20, 70}, {-20, 70}, {-20, 82}, {-82, 82}, {-82, -40}, {-100, -40}, {-100, -40}}, color = {191, 0, 0}));
  connect(ConBottomIn.fluid, port_con_a[6]) annotation(
    Line(points = {{-40, -74}, {-40, -74}, {-40, -80}, {-80, -80}, {-80, 40}, {-100, 40}, {-100, 40}}, color = {191, 0, 0}));
  connect(ConvTopIn.fluid, port_con_a[1]) annotation(
    Line(points = {{-40, 72}, {-40, 72}, {-40, 80}, {-80, 80}, {-80, 40}, {-100, 40}, {-100, 40}}, color = {191, 0, 0}));
  connect(conductiveBox1.port_11, radBottomOut.solid) annotation(
    Line(points = {{12, -12}, {40, -12}, {40, -60}, {40, -60}}, color = {191, 0, 0}));
  connect(conductiveBox1.port_11, ConBottomOut.solid) annotation(
    Line(points = {{12, -12}, {20, -12}, {20, -60}, {20, -60}}, color = {191, 0, 0}));
  connect(conductiveBox1.port_6, radTopOut.solid) annotation(
    Line(points = {{12, 8}, {40, 8}, {40, 60}, {40, 60}}, color = {191, 0, 0}));
  connect(conductiveBox1.port_6, ConTopOut.solid) annotation(
    Line(points = {{12, 8}, {20, 8}, {20, 60}, {20, 60}}, color = {191, 0, 0}));
  connect(conductiveBox1.port_5, radBottomIn.solid) annotation(
    Line(points = {{-12, -12}, {-20, -12}, {-20, -60}, {-20, -60}}, color = {191, 0, 0}));
  connect(conductiveBox1.port_5, ConBottomIn.solid) annotation(
    Line(points = {{-12, -12}, {-40, -12}, {-40, -60}, {-40, -60}}, color = {191, 0, 0}));
  connect(conductiveBox1.port_0, radTopIn.solid) annotation(
    Line(points = {{-12, 8}, {-20, 8}, {-20, 60}, {-20, 60}}, color = {191, 0, 0}));
  connect(conductiveBox1.port_0, ConvTopIn.solid) annotation(
    Line(points = {{-12, 8}, {-40, 8}, {-40, 60}, {-40, 60}}, color = {191, 0, 0}));
  annotation(
    uses(Modelica(version = "3.2.2")),
    Icon(graphics = {Text(origin = {-22, 9}, extent = {{-78, 31}, {122, -49}}, textString = "Enclosure"), Text(origin = {-32, 52}, extent = {{-28, 8}, {92, -32}}, textString = "Convection[6]"), Text(origin = {22, -48}, extent = {{-78, 28}, {34, -12}}, textString = "Radiation[6]"), Rectangle(fillColor = {170, 255, 255}, extent = {{-100, 100}, {100, -100}}), Text(origin = {-79, 80}, extent = {{-11, 20}, {9, -20}}, textString = "In"), Text(origin = {81, 80}, extent = {{-25, 20}, {9, -20}}, textString = "Out"), Line(origin = {-75, 40}, points = {{-15, 0}, {15, 0}}, thickness = 1), Line(origin = {75.1877, 39.3029}, points = {{-15, 0}, {15, 0}}, thickness = 1), Line(origin = {74.866, -40.5899}, points = {{-15, 0}, {15, 0}}, thickness = 1), Line(origin = {-75.0268, -40.3486}, points = {{-15, 0}, {15, 0}}, thickness = 1)}, coordinateSystem(initialScale = 0.1)),
    Diagram,
    version = "",
    __OpenModelica_commandLineOptions = "");
end Enclosure;
