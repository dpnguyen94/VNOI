//const
	
var	
	i,j,t: longint;
    fo: text;
begin
	assign(fo,'nkpath.in1'); rewrite(fo);
    writeln(fo,'100 100');
    for i:= 1 to 100 do
    begin
    	for j:= 1 to 100 do
        	write(fo,random(30001),' ');
        writeln(fo);
    end;
    close(fo);
end.
