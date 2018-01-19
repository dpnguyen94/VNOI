//const
	
var	
	i,j,t: longint;
    fo: text;
begin
	assign(fo,'nksp.in1'); rewrite(fo);
    for i:= 1 to 1000 do
    begin
    	t:= random(ord('z') - ord('a')+1);
		j:= ord('a') + t;
        write(fo,char(j));
    end;
    close(fo);
end.
