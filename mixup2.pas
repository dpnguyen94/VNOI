uses math;
const
	maxN = 16;
    LM = 66000;
//type

var
	fi,fo: text;
	n,k: longint;
    s: array[0..maxN] of longint;
    w: array[0..LM,0..maxN] of int64;
    f: array[0..maxN] of longint;	

procedure input;
var
	i: longint;
begin
	readln(fi,n,k);
    for i:= 0 to n-1 do readln(fi,s[i]);
end;

procedure init;
var
	i: longint;
begin
	f[0]:= 1;
    for i:= 1 to maxN do f[i]:= f[i-1] * 2;
end;

procedure DP;
var
	i,j,t: longint;	
begin
	for i:= 0 to n-1 do w[f[i],i]:= 1;

	for i:= 0 to f[n] - 1 do
    	for j:= 0 to n-1 do
        	if (((i shr j ) and 1) = 1) then
            	for t:= 0 to n-1 do
                	if (((i shr t) and 1) = 0) and (abs(s[t] - s[j]) > k) then
                    	w[i + f[t],t]:= w[i + f[t],t] + w[i,j];
end;

procedure output;
var
	i,j: longint;
	res: int64;
begin
	res:= 0;
    for i:= 0 to n-1 do res:= res + w[f[n]-1,i];
    writeln(fo,res);
end;


begin
	assign(fi,''); reset(fi);
    assign(fo,''); rewrite(fo);
    //
    input;
    init;
    DP;
    output;
    //
    close(fi);
    close(fo);
end.
