{ Test program }

var x , limit , squ ;

procedure square;
begin
   squ := x * x
end ;
 
begin
   limit := 1 ;
   x := 1;
   ? limit ;
   while x <= 10 do
   begin
      call square;
      ! squ ; 
      x := x + 1
   end
end . 
