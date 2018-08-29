unit Main;

interface //#################################################################### ■

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Math.Vectors,
  FMX.Objects,
  LUX, LUX.D2,
  Core;

type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject; Canvas: TCanvas);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
  private
    { private 宣言 }
    _MouseState :TShiftState;
    ///// メソッド
    function ScrToPos( const S_:TPointF ) :TSingle2D;
    function PosToScr( const P_:TSingle2D ) :TPointF;
    procedure DrawPoin( const Canvas_:TCanvas; const Radius_:Single );
    procedure DrawFace( const Canvas_:TCanvas; const Thickness_:Single );
    procedure DrawCurv( const Canvas_:TCanvas; const Thickness_:Single );
  public
    { public 宣言 }
    _TriMesh   :TMyModel;
    _CurvPoins :TArray<TSingle2D>;
  end;

var
  Form1: TForm1;

implementation //############################################################### ■

{$R *.fmx}

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

function TForm1.ScrToPos( const S_:TPointF ) :TSingle2D;
begin
     Result.X := S_.X - PaintBox1.Width  / 2       ;
     Result.Y :=        PaintBox1.Height / 2 - S_.Y;
end;

function TForm1.PosToScr( const P_:TSingle2D ) :TPointF;
begin
     Result.X := P_.X + PaintBox1.Width  / 2       ;
     Result.Y :=        PaintBox1.Height / 2 - P_.Y;
end;

//------------------------------------------------------------------------------

procedure TForm1.DrawPoin( const Canvas_:TCanvas; const Radius_:Single );
var
   I :Integer;
begin
     with Canvas_ do
     begin
          with Fill do
          begin
               Kind      := TBrushKind.Solid;
               Color     := TAlphaColorRec.Red;
          end;

          for I := 0 to _TriMesh.PoinModel.ChildsN-1 do
          begin
               with PosToScr( _TriMesh.PoinModel.Childs[ I ].Pos ) do
               begin
                    FillEllipse( TRectF.Create( X-Radius_, Y-Radius_,
                                                X+Radius_, Y+Radius_ ), 1 );
               end;
          end;
     end;
end;

procedure TForm1.DrawFace( const Canvas_:TCanvas; const Thickness_:Single );
var
   I :Integer;
   Ps :TPolygon;
begin
     SetLength( Ps, 3 );

     with Canvas_ do
     begin
          with Stroke do
          begin
               Kind      := TBrushKind.Solid;
               Color     := TAlphaColorRec.White;
               Thickness := Thickness_;
               Join      := TStrokeJoin.Round;
          end;
          with Fill do
          begin
               Kind      := TBrushKind.Solid;
               Color     := TAlphaColorRec.Lime;
          end;

          for I := 0 to _TriMesh.ChildsN-1 do
          begin
               with _TriMesh.Childs[ I ] do
               begin
                    Ps[ 0 ] := PosToScr( Poin[ 1 ].Pos );
                    Ps[ 1 ] := PosToScr( Poin[ 2 ].Pos );
                    Ps[ 2 ] := PosToScr( Poin[ 3 ].Pos );

                    FillPolygon( Ps, 1 );
                    DrawPolygon( Ps, 1 );
               end;
          end;
     end;
end;

//------------------------------------------------------------------------------

procedure TForm1.DrawCurv( const Canvas_:TCanvas; const Thickness_:Single );
var
   N, I :Integer;
   Vs :TPolygon;
begin
     if Assigned( _CurvPoins ) then
     begin
          N := Length( _CurvPoins );

          SetLength( Vs, N );

          for I := 0 to N-1 do Vs[ I ] := PosToScr( _CurvPoins[ I ] );

          with Canvas_ do
          begin
               with Stroke do
               begin
                    Kind      := TBrushKind.Solid;
                    Color     := TAlphaColorRec.Red;
                    Thickness := Thickness_;
                    Join      := TStrokeJoin.Round;
               end;

               DrawPolygon( Vs, 1 );
          end;
     end;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

procedure TForm1.FormCreate(Sender: TObject);
begin
     _MouseState := [];

     _TriMesh := TMyModel.Create;

     _TriMesh.Radius := 20;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
     _TriMesh.Free;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.PaintBox1Paint(Sender: TObject; Canvas: TCanvas);
begin
     Canvas.Clear( TAlphaColorRec.White );

     DrawFace( Canvas, 2 );

     DrawPoin( Canvas, 3 );

     DrawCurv( Canvas, 4 );
end;

//------------------------------------------------------------------------------

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
     _MouseState := Shift;

     _TriMesh.DeleteChilds;

     _CurvPoins := [ ScrToPos( TPointF.Create( X, Y ) ) ];
end;

procedure TForm1.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
begin
     if ssLeft in _MouseState then
     begin
          _CurvPoins := _CurvPoins + [ ScrToPos( TPointF.Create( X, Y ) ) ];

          PaintBox1.Repaint;
     end;
end;

procedure TForm1.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
     if ssLeft in _MouseState then
     begin
          _CurvPoins := _CurvPoins + [ ScrToPos( TPointF.Create( X, Y ) ) ];

          if Length( _CurvPoins ) > 2 then
          begin
               _TriMesh.MakeMesh( _CurvPoins );

               _TriMesh.FairMesh;  //輪郭外の不要な三角形を消す。
          end;

          _CurvPoins := [];

          PaintBox1.Repaint;

          _MouseState := [];
     end;
end;

end. //######################################################################### ■
