with text_io;
use text_io;

procedure AQstub is
  package int_io is new integer_io(integer);
  use int_io;

  index: integer;
  tree_num: integer;
  procedure Rec(X, tree_num: in integer) is
    Y: integer;
    N: integer;
    task t1;
    task t2;

    task body t1 is
    begin
      put("t1 tree number is: ");
      put(tree_num);

      N := tree_num + 1;
      put("task t1 x val is: ");
      put(X);
      New_line;
      Y := X - 1;
      if Y > 0 then
        Rec(Y, N);
      end if;  
    end t1;

    task body t2 is
    begin
      put("t2 tree number is: ");
      put(tree_num);

      N := tree_num + 1;
      put("task t2 x val is: ");
      put(X);
      New_line;
      Y := X - 1;
      if Y > 0 then
        Rec(Y, N);
      end if;  
    end t2;
  begin
    Null;
  end Rec;

begin
  index := 10;
  tree_num := 0;
  put("Making Rec call: "); New_line;
  Rec(index, tree_num);
end AQstub;
