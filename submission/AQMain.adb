with text_io;
use text_io;

with Ada.Numerics.Generic_Elementary_Functions;

with AdaptiveQuad;

procedure AQMain is
  package FloatFunctions is new Ada.Numerics.Generic_Elementary_Functions(Float);
  use FloatFunctions;

  package int_io is new integer_io(integer);
  use int_io;

  package flt_io is new float_io(Float);
  use flt_io;


  Epsilon: Float := 0.000001;

  --------------------------------

  function MyF(X: Float) return Float is
  Y: Float;
  begin
    Y := X * X;
    return Sin(y);
  end MyF;

  package AQ is new AdaptiveQuad(MyF);
  use AQ;

  --------------------------------

  task ReadPairs;

  task ComputeArea is
    entry Go(A, B: Float);
    entry Done;
  end ComputeArea;

  task PrintResult is
    entry Go(A, B, Ans: Float);
    entry Done;
  end PrintResult;

  --------------------------------

  task body ReadPairs is
    A: Float;
    B: Float;
    Z: Integer := 0;
  begin
    for i in 1..5 loop
      get(A);
      get(B);

      for Y in 1..1000 loop
         Z := Z + Y;
      end loop;

      ComputeArea.Go(A, B);
    end loop;
    ComputeArea.Done;
  end ReadPairs;

  --------------------------------

  task body ComputeArea is
    Finished: Boolean := False;
    Z: Integer := 0;
    Res: Float;
  begin  
    while not Finished loop
      select
        
        accept Go(A, B: Float) do
          Res := AQ.AQuad(A, B, Epsilon);
          PrintResult.Go(A, B, Res);
        end Go;

        for Y in 1..1000 loop
           Z := Z + Y;
        end loop;
      or 
        accept Done;
        Finished := True;
        PrintResult.Done;
      end select;
    end loop;
  end ComputeArea;

  --------------------------------

  task body PrintResult is
    Finished: Boolean := False;
    Z: Integer := 0;
  begin
    while not Finished loop
      select
        
        accept Go(A, B, Ans: Float) do
           Put_Line("The area under sin(x^2) for x = " & Float'image(A) & 
            " to "  & Float'image(B) & " is "  & Float'image(Ans));
        end Go;

        for Y in 1..1000 loop
           Z := Z + Y;
        end loop;
      or 
        accept Done;
        Finished := True; 
          end select;
    end loop;
  end PrintResult;

  --------------------------------  

begin
  null;
end AQMain;
