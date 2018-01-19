//const
	
var	
	i,j: longint;
    fo: text;
begin
	assign(fo,'game1.in1'); rewrite(fo);
    writeln(fo,5000);
	for i:= 1 to 5000 do writeln(fo,random(5000));
    close(fo);
end.
