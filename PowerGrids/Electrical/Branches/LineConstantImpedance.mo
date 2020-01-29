within PowerGrids.Electrical.Branches;

model LineConstantImpedance "Transmission line with constant impedance"
  extends BaseClasses.PiNetwork(
    final UNomA = UNom, 
    final UNomB = UNom);
  extends Icons.Line;

  parameter Types.Voltage UNom "Nominal/rated voltage";
  parameter Types.Resistance R "Series resistance";
  parameter Types.Resistance X "Series reactance";
  parameter Types.Conductance G = 0  "Shunt conductance";
  parameter Types.Conductance B = 0 "Shunt susceptance";
equation
  k = Complex(1);
  Y = 1/Complex(R, X);
  YA = Complex(G/2, B/2);
  YB = Complex(G/2, B/2);
annotation(
    Documentation(info = "<html>
<p>Transmission line with constant series impedance R+jX and constant shunt admittance G+jB. </p>
<p>Implemented as a child class of <a href=\"modelica://PowerGrids.Electrical.Branches.BaseClasses.PiNetwork\">PiNetwork</a>, where Ya=Yb=(G+jB)/2 and k = 1, see the corresponding documentation.</p>
</html>"));
end LineConstantImpedance;
