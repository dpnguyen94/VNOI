const
	maxV = 100000001; 	
var	
	i,j,t: longint;
    fo: text;
begin
	assign(fo,'qbgame.in1'); rewrite(fo);
    writeln(fo,10000);
    for i:= 1 to 8 do
    begin
    	for j:= 1 to 10000 do write(fo,random(maxV),' ');
		writeln(fo);
    end;	
    close(fo);
end.
