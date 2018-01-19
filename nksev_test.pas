const
	maxL = 300000;
  maxN = 4000;	
var	
	i,j,len: longint;
    fo: text;
begin
	assign(fo,'nksev.in1'); rewrite(fo);
  randomize;
  for i:= 1 to maxL do
  	write(fo,chr(random(2) + 97));
  writeln(fo);
  writeln(fo,maxN);
  for i:= 1 to maxN do
  begin
  	len:= random(100) + 1;
    for j:= 1 to len do
    	write(fo,chr(random(2) + 97));
    writeln(fo);
  end;	
  close(fo);
end.
