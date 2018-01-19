uses math;
//const

	
//type


var
	fi,fo: text;
    s1,s2,s: string[50];


procedure input;
begin
	readln(fi,s1);	
    readln(fi,s2);
    readln(fi);
end;


procedure process;
var	len,i,tz,ta,c1,c2: longint;
begin
	len:= length(s1);
    tz:= ord('z');
    ta:= ord('a');

    for i:= 1 to len do
	begin
    	c1:= ord(s1[i]);
        c2:= ord(s2[i]);
    	if (s1[i] > s2[i]) then
        begin
        	c1:= ord(s2[i]);
            c2:= ord(s1[i]);
        end;

        //
        if (c2 - c1 >= (c1 - ta) + (tz - c2) + 1) then s1[i]:= 'a'
        else s1[i]:= char(c1);
    end;

    writeln(fo,s1);
end;


begin
	assign(fi,''); reset(fi);
    assign(fo,''); rewrite(fo);
	//
    while TRUE do
    begin
    	readln(fi,s);
        if (s = '[END]') then break;
        input;
        process;
    end;
    //
    close(fi);
    close(fo);
end.
