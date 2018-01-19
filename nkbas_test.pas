const
	maxN = 17;
    maxM = 5;		
var	
	i,j,t: longint;
    fo: text;
begin
	assign(fo,'nkbas.in1'); rewrite(fo);
    writeln(fo,maxN,' ',maxM);
    for i:= 1 to maxM do
    begin
    	writeln(fo,random(maxN)+1,' ',random(maxN)+1);
    end;
    close(fo);
end.
