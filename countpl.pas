uses math;
const
	maxL = 300;
//type

var                                	
	fi,fo: text;
	f: array[0..maxL] of longint;
    s: string;
    len: longint;

procedure input;
begin
	readln(fi,s);
    len:= length(s);
end;

function ispalin(st: string): boolean;
var
	i,t,n: longint;
begin
	n:= length(st);
    if (n mod 2 = 0) then t:= n div 2
    else t:= n div 2 + 1;

    inc(n);

    for i:= t downto 1 do
    	if (st[i] <> st[n - i]) then exit(false);

    exit(true);
end;

procedure process;
var
	i,j: longint;
    st: string;
begin
	for i:= 1 to len do f[i]:= i;

    for i:= 1 to len do
    begin
    	st:= '';
        for j:= i downto 1 do
        begin
        	st:= s[j] + st;
            if (f[j-1] + 1 < f[i]) and (ispalin(st)) then f[i]:= f[j-1] + 1;
        end;
    end;

    writeln(fo,f[len]);
end;

begin
	assign(fi,''); reset(fi);
    assign(fo,''); rewrite(fo);
	//
    input;
    process;
    //
    close(fi);
    close(fo);
end.
