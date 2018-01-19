var	
	i,j: longint;
    fo: text;
begin
	assign(fo,'range.in1'); rewrite(fo);
    writeln(fo,250);
    for i:= 1 to 250 do
    begin
        for j:= 1 to 250 do write(fo,1);
		writeln(fo);
    end;
    close(fo);
end.
