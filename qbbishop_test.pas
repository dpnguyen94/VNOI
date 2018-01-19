//const
	
var	
	i,j,t: longint;
    vs: array[1..200,1..200] of boolean;
    fo: text;
begin
	assign(fo,'qbbishop.in1'); rewrite(fo);
	writeln(fo,'200 10 1 1 200 200');
    t:= 10;
    while (t > 0) do
    begin
    	i:= random(200);
        j:= random(200);

        if not vs[i,j] then
        begin
        	vs[i,j]:= true;
        	writeln(fo,i,' ',j);
            dec(t);
        end;
    end;
    close(fo);
end.
