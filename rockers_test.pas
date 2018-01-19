//const
	
var	
	i,j,t: longint;
    fo: text;
begin
	assign(fo,'crect.in1'); rewrite(fo);
    writeln(fo,'400 400');
    for i:= 1 to 400 do
    begin
    	for j:= 1 to 400 do
        begin
        	t:= random(5);
        	write(fo,char(ord('A') + t));
        end;
        writeln(fo);
    end;
    close(fo);
end.
