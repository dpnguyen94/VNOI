//const
	
var	
	i,j: longint;
    fo: text;
begin
	assign(fo,'vector.in1'); rewrite(fo);
    writeln(fo,30);
	for i:= 1 to 31 do writeln(fo,random(100) - random(100),' ',random(100) - random(100));
    close(fo);
end.
