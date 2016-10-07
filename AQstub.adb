with text_io;
use text_io;

procedure AQstub is
  package int_io is new integer_io(integer);
  use int_io;

  index: integer;
  procedure Rec(X: in integer) is
  Y: integer;
  begin
    put("the value of X now is: ");
    put(X); New_line;
    Y := X - 1;
    if Y > 0 then
      Rec(Y);
    end if;
  end Rec;

begin
  index := 10;
  put("Making Rec call"); New_line;
  Rec(index);
end AQstub;
