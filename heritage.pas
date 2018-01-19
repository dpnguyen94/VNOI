{
ID: ndchiph1
PROG: heritage
LANG: PASCAL
}
uses math;
var                                	
	fi,fo: text;
    si,sp: string;


procedure input;
begin
	readln(fi,si);
    readln(fi,sp);
end;

procedure attempt(si,sp: string);
var
	i: longint;
    s1,s2: string;
begin	
	if (si = '') then exit;

	if (length(si) = 1) then
    begin
    	write(fo,sp[1]);
        exit;
    end;

	for i:= 1 to length(si) do
    	if (si[i] = sp[1]) then break;

    s1:= copy(si,1,i-1);
	s2:= copy(sp,2,i-1);
   	attempt(s1,s2);

    s1:= copy(si,i+1,length(si) - i);
    s2:= copy(sp,i+1,length(sp) - i);
    attempt(s1,s2);

    write(fo,sp[1]);
end;

procedure process;
begin
	attempt(si,sp);
    writeln(fo);
end;


begin
	assign(fi,'heritage.in'); reset(fi);
    assign(fo,'heritage.out'); rewrite(fo);
	//
    input;
    process;
    //
    close(fi);
    close(fo);
end.
