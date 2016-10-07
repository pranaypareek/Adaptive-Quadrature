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

  --------------------------------

  task body ReadPairs is
  a: float;
  b: float;
  Z: Integer := 0;
  begin
    for i in 1..5 loop
      --put("ReadPairs get a: ");New_line;
      get(a);
      --put("ReadPairs get b: ");New_line;
      get(b);

      for Y in 1..1000 loop   -- just code to take some time.
         Z := Z + Y;          -- it can execute while Consumer
      end loop;               -- is consuming the previous produced value.

      ComputeArea.Go(a, b);
    end loop;
    ComputeArea.Done;  -- entry call signalling producing is done.
  end ReadPairs;

  --------------------------------

  task body ComputeArea is
    Finished: Boolean := False;
    Z: Integer := 0;
  begin  
    while not Finished loop
      select    -- allows waiting for one of multiple entry calls
        
        accept Go(a, b: float) do  -- if this entry call comes in, 
           Put_Line("Value a = " & float'image(a));New_line;         -- then continue computing
           Put_Line("Value b = " & float'image(b));
        end Go;

        for Y in 1..1000 loop   -- more code to take some time
           Z := Z + Y;          -- it can execute while Producer
        end loop;               -- is executing.
      or 
        accept Done;      -- if this entry call comes in, we're done.
        Finished := True; 
          end select;
    end loop;
  end ComputeArea;

  --------------------------------

begin
  Val := MyF(0.45);
  Put_Line("Value = " & float'image(Val));
end AQstub2;
