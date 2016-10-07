with text_io;
use text_io;

with Ada.Numerics.Generic_Elementary_Functions;

package body AdaptiveQuad is

  package flt_io is new float_io(Float);
  use flt_io;

  package FloatFunctions is new Ada.Numerics.Generic_Elementary_Functions(Float);
  use FloatFunctions;

  function SimpsonsRule(A: Float; B: Float) return Float is
    C: Float;
    H3: Float;
  begin
    C := (A + B) / 2.0;
    H3 := abs(B - A) / 6.0;
    return H3*(MyF(A) + 4.0 * MyF(C) + MyF(B));
  end SimpsonsRule;

  function AQuad(A, B, Eps: Float) return Float is
    C: Float;
    Left: Float;
    Right: Float;
    Whole: Float;
    Val: Float;

    Res_A: Float;
    Res_B: Float;
    procedure RecursiveAsr(A, C, B, Eps: Float) is
      task TLeft;
      task TRight;

      task body TLeft is
      begin
        Res_A := AQuad(A, C, Eps/2.0);
        --if AQuad(A, C, Eps/2.0) <= 0.0 then
          -- null;
        --end if;
      end TLeft;

      task body TRight is
      begin
        Res_B := AQuad(C, B, Eps/2.0);
        --if AQuad(C, B, Eps/2.0) <= 0.0 then
          -- null;
        --end if;
      end TRight;

    begin
      Null;
    end RecursiveAsr;

  begin
    C := (A + B) / 2.0;
    --Put_Line("C = " & Float'image(C));
    Left := SimpsonsRule(A, C);
    Right := SimpsonsRule(C, B);
    Whole := SimpsonsRule(A, B);

    if abs(Left + Right - Whole) > (15.0 * Eps) then
      --RecursiveAsr(A, C, B, Eps);
      Val := AQuad(A, C, Eps/2.0) + AQuad(C, B, Eps/2.0);
    else
      Val := Left + Right + (Left + Right - Whole)/15.0;
    end if;
    --Val := Left + Right + (Left + Right - Whole)/15.0;
    return Val;
  end AQuad;

end AdaptiveQuad;
