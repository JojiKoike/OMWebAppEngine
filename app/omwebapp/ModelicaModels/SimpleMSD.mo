model SimpleMSD

  annotation(experiment(StopTime=10));
  parameter Real m(quantity="Mass", unit="kg") = 1.0 "mass";
  parameter Real k(quantity="Spring Constant", unit="N/m") = 2.0 "spring coefficient";
  parameter Real c(quantity="Dumping Coefficient", unit="kg/s") = 1.0 "viscos friction coefficient";
  parameter Real v0(quantity="Initial Velocity", unit="m/s") = 5.0 "initial velocity of point mass";
  
  Real x(start=0, quantity="Displacement", unit="m") "displacement of point mass";
  Real v(start=v0, quantity="Velocity", unit="m/s") "Velocity";
  
    
equation
  
  der(x) = v;
  der(v) = (-c/m)*v-(k/m)*x;
    
end SimpleMSD;
