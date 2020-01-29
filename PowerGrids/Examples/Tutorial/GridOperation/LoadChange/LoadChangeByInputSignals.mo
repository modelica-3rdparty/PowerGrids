within PowerGrids.Examples.Tutorial.GridOperation.LoadChange;
model LoadChangeByInputSignals "Load step response specified by input signals"
  extends Modelica.Icons.Example;
  inner PowerGrids.Electrical.System systemPowerGrids annotation(
    Placement(visible = true, transformation(origin = {130, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGrids.Electrical.Machines.SynchronousMachine4Windings GEN(H = 4, PStart = -4.75e+08, QStart = -1.56e+08,SNom = 5e+08, Tpd0 = 5.143, Tppd0 = 0.042, Tppq0 = 0.083, Tpq0 = 2.16, UNom = 21000, UPhaseStart = 0.161156, UStart = 21e3 * 0.9917, portVariablesPhases = true, raPu = 0, xdPu = 2, xlPu = 0.15, xpdPu = 0.35, xppdPu = 0.25, xppqPu = 0.3, xpqPu = 0.5, xqPu = 1.8)  annotation(
    Placement(visible = true, transformation(origin = {-26, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGrids.Electrical.Buses.Bus NTLV(SNom = 5e+08, UNom = 21000, portVariablesPhases = true, portVariablesPu = true)  annotation(
    Placement(visible = true, transformation(origin = {24, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PowerGrids.Electrical.Buses.BusFault NTHV(R = 0.05,SNom = 5e+08, UNom = 380000, UPhaseStart = 0, UStart = 1.050 * 380e3,portVariablesPhases = true, portVariablesPu = true, startTime = 1e10, stopTime = 1e10)  annotation(
    Placement(visible = true, transformation(origin = {84, -20}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
  PowerGrids.Electrical.Branches.TransformerFixedRatio TGEN(PStartA = 4.75e+08, PStartB = -4.75e+08, QStartA = 1.56e+08, QStartB = -7.6e+07, R = 0.15e-2 * 419 ^ 2 / 500, SNom = 5e+08, UNomA = 21000, UNomB = 419000, UPhaseStartA = 0.161156, UPhaseStartB = 0, UStartA = 0.9917 * 21e3, UStartB = 0.95227 * 380e3, X = 16e-2 * 419 ^ 2 / 500, portVariablesPhases = true, portVariablesPu = true, rFixed = 419 / 21)  annotation(
    Placement(visible = true, transformation(origin = {54, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGrids.Electrical.Buses.EquivalentGrid GRID(R_X = 1 / 10, SNom = 5e+08, SSC = 2.5e+09, UNom = 380000, URef = 1.05 * 380e3, c = 1.1, portVariablesPhases = true, portVariablesPu = true)  annotation(
    Placement(visible = true, transformation(origin = {110, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGrids.Electrical.Loads.LoadImpedancePQInputs GRIDL(SNom = 5e+08, UNom = 380000, URef = 1.05 * 380e3, portVariablesPhases = true, portVariablesPu = true)  annotation(
    Placement(visible = true, transformation(origin = {104, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Sources.RealExpression PmPu(y = -GEN.PStart / GEN.SNom)  annotation(
    Placement(visible = true, transformation(origin = {-60, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression ufPuIn(y = GEN.ufPuInStart)  annotation(
    Placement(visible = true, transformation(origin = {-60, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step PRef(height = 475e6 * 0.05, offset = 475e6, startTime = 2)  annotation(
    Placement(visible = true, transformation(origin = {50, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step QRef(height = 76e6 * 0.04, offset = 76e6, startTime = 2) annotation(
    Placement(visible = true, transformation(origin = {50, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(PmPu.y, GEN.PmPu) annotation(
    Line(points = {{-48, 4}, {-36, 4}, {-36, 4}, {-36, 4}}, color = {0, 0, 127}));
  connect(ufPuIn.y, GEN.ufPuIn) annotation(
    Line(points = {{-48, -20}, {-44, -20}, {-44, -4}, {-36, -4}, {-36, -4}}, color = {0, 0, 127}));
  connect(GEN.terminal, NTLV.terminal) annotation(
    Line(points = {{-26, 0}, {-26, 0}, {-26, -20}, {24, -20}, {24, -20}}));
  connect(NTLV.terminal, TGEN.terminalA) annotation(
    Line(points = {{24, -20}, {44, -20}, {44, -20}, {44, -20}}));
  connect(TGEN.terminalB, NTHV.terminal) annotation(
    Line(points = {{64, -20}, {82, -20}, {82, -20}, {84, -20}}));
  connect(NTHV.terminal, GRID.terminal) annotation(
    Line(points = {{84, -20}, {90, -20}, {90, -10}, {110, -10}, {110, -10}}));
  connect(NTHV.terminal, GRIDL.terminal) annotation(
    Line(points = {{84, -20}, {90, -20}, {90, -32}, {104, -32}, {104, -32}}));
  connect(PRef.y, GRIDL.PRefIn) annotation(
    Line(points = {{62, -50}, {108, -50}, {108, -42}, {108, -42}}, color = {0, 0, 127}));
  connect(QRef.y, GRIDL.QRefIn) annotation(
    Line(points = {{62, -80}, {114, -80}, {114, -42}, {114, -42}}, color = {0, 0, 127}));

annotation(
    experiment(StartTime = 0, StopTime = 4, Tolerance = 1e-6, Interval = 0.008),
    __OpenModelica_commandLineOptions = "--daeMode --tearingMethod=minimalTearing",
    __OpenModelica_simulationFlags(nls="kinsol", lv="LOG_INIT_HOMOTOPY", homotopyOnFirstTry="()"),  Diagram(coordinateSystem(extent = {{-100, -100}, {160, 100}})));
    
end LoadChangeByInputSignals;
