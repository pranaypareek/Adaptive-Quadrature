generic
  type T is limited private;
  with function F(A: T; B: T; Eps: T) return T;

package AdaptiveQuad is
  function AQuad(A: T; B: T; Eps: T) return T;
end AdaptiveQuad;