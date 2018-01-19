uses math;
const
    maxN = 110;
//type

var
	fi,fo: text;
    ntest,t,n: longint;
    a: array[1..maxN] of longint;

    exist: boolean;


procedure input;
var
	i: longint;
begin
	readln(fi,n);

    exist:= false;
    for i:= 1 to n do
    begin
    	read(fi,a[i]);
        if (a[i] >= 2) then exist:= true;
    end;
end;

procedure process;
var
	i: longint;	
begin
	for i:= 2 to n do
    	a[1]:= a[1] xor a[i];

    if (exist) then
    begin
		if (a[1] = 0) then writeln(fo,-1)
    	else writeln(fo,1);
    end
    else
    	if (n mod 2 = 0) then writeln(fo,1)
        else writeln(fo,-1);
end;


begin
	assign(fi,''); reset(fi);
    assign(fo,''); rewrite(fo);
    //
    readln(fi,ntest);
    for t:= 1 to ntest do
    begin
    	input;
    	process;
    end;
    //
    close(fi);
    close(fo);
end.
