uses math;
var
	fo: text;
    i,j: longint;
begin
	assign(fo,'crec01.in1'); rewrite(fo);
	writeln(fo,'1000 1000');
	for i:= 1 to 1000 do
    begin
    	for j:= 1 to 1000 do write(fo,1);
        writeln(fo);
    end;
    close(fo);
end.