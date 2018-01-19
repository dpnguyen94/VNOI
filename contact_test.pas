var
	i,j: longint;
    fo: text;
begin
	assign(fo,'contact.in'); rewrite(fo);      	
	writeln(fo,1,' ',12,' ',20);
    for i:= 1 to 2500 do
    begin
    	for j:= 1 to 80 do write(fo,1);
        writeln(fo);
    end;
    close(fo);
end.
