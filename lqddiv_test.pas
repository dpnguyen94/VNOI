//const
	
var	
	i,j: longint;
    fo: text;
begin
	assign(fo,'lqddiv.in1'); rewrite(fo);
    writeln(fo,32);
    for i:= 1 to 32 do writeln(fo,1000000);
    close(fo);
end.
