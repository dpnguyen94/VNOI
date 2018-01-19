//const
	
var	
	i,j,t: longint;
    fo: text;
begin
	assign(fo,'nttree.in1'); rewrite(fo);
    writeln(fo,100000);
    for i:= 0 to 99998 do
    	writeln(fo,i,' ',i+1,' ',1);
    close(fo);
end.
