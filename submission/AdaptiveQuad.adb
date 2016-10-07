package body AdaptiveQuad is

  function SimpsonsRule(A: Float; B: Float) return Float is
    C: Float;
    H3: Float;
  begin
    C := (A + B) / 2.0;
    H3 := abs(B - A) / 6.0;
    return H3*(MyF(A) + 4.0 * MyF(C) + MyF(B));
  end SimpsonsRule;

  --------------------------------

  function AQuad(A, B, Eps: Float) return Float is
    C: Float;
    Left: Float;
    Right: Float;
    Whole: Float;

    Val: Float;

    ResA: Float;
    ResB: Float;

    procedure RecursiveAsr(A, C, B, Eps: Float) is
      task TLeft;
      task TRight;

      task body TLeft is
      begin
        ResA := AQuad(A, C, Eps/2.0);
      end TLeft;

      task body TRight is
      begin
        ResB := AQuad(C, B, Eps/2.0);
      end TRight;

    begin
      Null;
    end RecursiveAsr;

  begin
    C := (A + B) / 2.0;
    Left := SimpsonsRule(A, C);
    Right := SimpsonsRule(C, B);
    Whole := SimpsonsRule(A, B);

    if abs(Left + Right - Whole) > (15.0 * Eps) then
      RecursiveAsr(A, C, B, Eps);
      Val := ResA + ResB;
    else
      Val := Left + Right + (Left + Right - Whole)/15.0;
    end if;
    return Val;
  end AQuad;

end AdaptiveQuad;
