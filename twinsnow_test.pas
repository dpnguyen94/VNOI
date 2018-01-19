const
	maxN = 100000;
  maxV = 10000000;	
var	
	i,j,t: longint;
    fo: text;
begin
	assign(fo,'twinsnow.in1'); rewrite(fo);
  writeln(fo,maxN);
  randomize;
  for i:= 1 to maxN do
  begin
  	t:= random(maxV + 1);
  	for j:= 1 to 6 do
    	write(fo,random(maxV + 1),' ');

    writeln(fo);
  end;
  close(fo);
end.
