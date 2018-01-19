//const
	
var	
	i,j,t: longint;
  fo: text;
begin
	assign(fo,'delnum.inp'); rewrite(fo);
  writeln(fo,100000);
  for i:= 1 to 100000 do
  	write(fo,random(1000000000) - random(1000000000),' ');
  close(fo);
end.
