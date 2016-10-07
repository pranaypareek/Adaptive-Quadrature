package body AdaptiveQuad is

  --function Apply(Y: T) return T is
  --begin
    --return MyF(Y);
  --end Apply;

  function SimpsonsRule(A: Float; B: Float) return Float is
  C: Float := 0.0;
  H3: Float := 0.0;
  Val: Float;
  begin
    C := (A + B) / 2.0;
    H3 := abs(B - A) / 6.0;
    Val := A + (4.0 * C) + B;
    return Val;
  end SimpsonsRule;

  --function RecAQuad()
  --function AQuad(A: T; B: T; Eps: T) return T is
  --begin
    --return F(A, B, Eps);
  --end AQuad;

  function AQuad(A, B, Eps: Float) return Float is
  SinVal: float;
  begin
    SinVal := MyF(0.45);
    --Put_Line("SinVal = " & float'image(SinVal));
    return(A * B * SinVal);
  end AQuad;

end AdaptiveQuad;
