program Triangulation;

uses
  System.StartUpCopy,
  FMX.Forms,
  Main in 'Main.pas' {Form1},
  LUX.D1 in '_LIBRARY\LUXOPHIA\LUX\LUX.D1.pas',
  LUX.D2 in '_LIBRARY\LUXOPHIA\LUX\LUX.D2.pas',
  LUX in '_LIBRARY\LUXOPHIA\LUX\LUX.pas',
  LUX.Brep in '_LIBRARY\LUXOPHIA\LUX.Brep\LUX.Brep.pas',
  LUX.Brep.Poin in '_LIBRARY\LUXOPHIA\LUX.Brep\LUX.Brep.Poin.pas',
  LUX.Brep.Face.TriFlip in '_LIBRARY\LUXOPHIA\LUX.Brep\LUX.Brep.Face.TriFlip.pas',
  LUX.Graph.Tree in '_LIBRARY\LUXOPHIA\LUX.Graph\LUX.Graph.Tree.pas',
  LUX.Graph in '_LIBRARY\LUXOPHIA\LUX.Graph\LUX.Graph.pas',
  LUX.D3 in '_LIBRARY\LUXOPHIA\LUX\LUX.D3.pas',
  LUX.Geometry in '_LIBRARY\LUXOPHIA\LUX.Geometry\LUX.Geometry.pas',
  LUX.Geometry.D2 in '_LIBRARY\LUXOPHIA\LUX.Geometry\LUX.Geometry.D2.pas',
  LUX.Geometry.D3 in '_LIBRARY\LUXOPHIA\LUX.Geometry\LUX.Geometry.D3.pas',
  LUX.Brep.Face.TriFlip.D2 in '_LIBRARY\LUXOPHIA\LUX.Brep\LUX.Brep.Face.TriFlip.D2.pas',
  LUX.Brep.Face.TriFlip.D2.Delaunay in '_LIBRARY\LUXOPHIA\LUX.Brep\LUX.Brep.Face.TriFlip.D2.Delaunay.pas',
  Core in 'Core.pas',
  LUX.Brep.Face.TriFlip.D2.Triangulation in '_LIBRARY\LUXOPHIA\LUX.Brep\LUX.Brep.Face.TriFlip.D2.Triangulation.pas',
  LUX.D4.M4 in '_LIBRARY\LUXOPHIA\LUX\LUX.D4.M4.pas',
  LUX.D4 in '_LIBRARY\LUXOPHIA\LUX\LUX.D4.pas',
  LUX.D4.V4 in '_LIBRARY\LUXOPHIA\LUX\LUX.D4.V4.pas',
  LUX.M2 in '_LIBRARY\LUXOPHIA\LUX\LUX.M2.pas',
  LUX.M3 in '_LIBRARY\LUXOPHIA\LUX\LUX.M3.pas',
  LUX.M4 in '_LIBRARY\LUXOPHIA\LUX\LUX.M4.pas',
  LUX.D2.M4 in '_LIBRARY\LUXOPHIA\LUX\LUX.D2.M4.pas',
  LUX.D2.V4 in '_LIBRARY\LUXOPHIA\LUX\LUX.D2.V4.pas',
  LUX.D3.M4 in '_LIBRARY\LUXOPHIA\LUX\LUX.D3.M4.pas',
  LUX.D3.V4 in '_LIBRARY\LUXOPHIA\LUX\LUX.D3.V4.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
