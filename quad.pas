uses math;
const
	maxN = 2501;
//type

var
	fi,fo: text;
    n: longint;
    f: array[0..maxN,0..4] of longint;


procedure input;
begin
	readln(fi,n);
end;

procedure process;
var
	i,j,tmp,k,t: longint;
begin
	tmp:= n div 2;
	if (n mod 2 = 0) then dec(tmp);

	f[0,0]:= 1;
    for i:= 1 to maxN do
    	for j:= 1 to 4 do
        begin
        	t:= min(i,tmp);
        	for k:= 1 to t do f[i,j]:= f[i,j] + f[i-k,j-1];
        end;
end;

procedure output;
begin
	writeln(fo,f[n,4]);
end;


begin
	assign(fi,''); reset(fi);
    assign(fo,''); rewrite(fo);
    //
    input;
    process;
    output;
    //
    close(fi);
    close(fo);
end.
