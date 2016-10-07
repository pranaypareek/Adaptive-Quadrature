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

  function MyF(x: Float) return Float is
  y: Float;
  begin
    y := x * x;
    return Sin(y);
  end MyF;

  package AQ is new AdaptiveQuad(Float, MyF);
  use AQ;

  --------------------------------

  task ReadPairs;

  task ComputeArea is
    entry Go(a, b: Float);
    entry Done;
  end ComputeArea;

  task PrintResult is
    entry Go(a, b, ans: Float);
    entry Done;
  end PrintResult;

  --------------------------------

  task body ReadPairs is
    a: Float;
    b: Float;
    Z: Integer := 0;
  begin
    for i in 1..5 loop
      get(a);
      get(b);

      for Y in 1..1000 loop
         Z := Z + Y;
      end loop;

      ComputeArea.Go(a, b);
    end loop;
    ComputeArea.Done;
  end ReadPairs;

  --------------------------------

  task body ComputeArea is
    Finished: Boolean := False;
    Z: Integer := 0;
    res: Float;
  begin  
    while not Finished loop
      select
        
        accept Go(a, b: Float) do
           res := AQ.AQuad(a, b, Epsilon);
           PrintResult.Go(a, b, res);
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
        
        accept Go(a, b, ans: Float) do
           Put_Line("The area under sin(x^2) for x = " & Float'image(a) & 
            " to "  & Float'image(b) & " is "  & Float'image(ans));
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
