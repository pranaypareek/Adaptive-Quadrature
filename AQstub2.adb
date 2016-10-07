with text_io;
use text_io;

with Ada.Numerics.Generic_Elementary_Functions;

procedure AQstub2 is
  package FloatFunctions is new Ada.Numerics.Generic_Elementary_Functions(Float);
  use FloatFunctions;

  package int_io is new integer_io(integer);
  use int_io;

  package flt_io is new float_io(float);
  use flt_io;

  Epsilon: float := 0.000001;
  Val: float;

  --------------------------------

  function MyF(x: float) return float is
  y: float;
  begin
    y := x * x;
    return Sin(y);
  end MyF;


  task ReadPairs;

  task ComputeArea is
    entry Go(a, b: float);
    entry Done;
  end ComputeArea;

  task PrintResult is
    entry Go(a, b, ans: float);
    entry Done;
  end PrintResult;

  --------------------------------

  task body ReadPairs is
    a: float;
    b: float;
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
        
        accept Go(a, b: float) do
           Put_Line("Value a = " & float'image(a));New_line;
           Put_Line("Value b = " & float'image(b));
           res := a * b;
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
        
        accept Go(a, b, ans: float) do
           Put_Line("The area under sin(x^2) for x = " & float'image(a) & 
            " to "  & float'image(b) & " is "  & float'image(ans));
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
  Val := MyF(0.45);
  Put_Line("Value = " & float'image(Val));
end AQstub2;
