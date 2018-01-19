uses math;
const
	module = 2111992;
    MAX_N = 100000;
//type
var
	fi,fo: text;
    f: array[0..MAX_N] of longint;
    n,k: longint;

procedure input;
begin
	readln(fi,n,k);
end;


procedure process;
var	i: longint;
begin
	for i:= 0 to n do
    	if (i <= k) then f[i]:= i+1
        else f[i]:= (f[i-1] + f[i-k-1]) mod module;

    //
    writeln(fo,f[n]);
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
