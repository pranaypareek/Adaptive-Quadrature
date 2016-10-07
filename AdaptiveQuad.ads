generic
  type T is limited private;
  with function MyF(X: float) return float;

package AdaptiveQuad is
  --function Apply(Y: T) return T;
  function AQuad(A, B, Eps: Float) return Float;
end AdaptiveQuad;
