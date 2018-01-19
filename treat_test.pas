//const
	
var	
	i,j,t: longint;
    fo: text;
begin
	assign(fo,'treat.in1'); rewrite(fo);
    writeln(fo,100000);
    for i:= 1 to 100000 do
    	writeln(fo,random(100000)+1);
    close(fo);
end.
