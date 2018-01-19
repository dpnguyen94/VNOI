//const
	
var	
	i,j,t: longint;
    fo: text;
begin
	assign(fo,'marathon.in'); rewrite(fo);
    writeln(fo,5000);
    for i:= 1 to 5000 do
    begin
    	for j:= 1 to 3 do 	
        	write(fo,random(100),' ');
        writeln(fo);
    end;
    close(fo);
end.
