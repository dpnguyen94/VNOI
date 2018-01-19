//const
	
var	
	i,j,k,t: longint;
    fo: text;
begin
	assign(fo,'lem2.in1'); rewrite(fo);
    writeln(fo,20,' ',10);
    for i:= 1 to 20 do
    begin
    	t:= 20 - i;
        write(fo,t,' ');
        for j:= 1 to t do write(fo,i + j,' ');
        writeln(fo);
    end;

    for i:= 1 to 20 do write(fo,random(1),' ');
    close(fo);
end.
