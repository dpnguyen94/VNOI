uses math;
const
	maxN = 1010;
//type

var
	fi,fo: text;
    n,t: longint;
	w,idw,ida,c: array[1..maxN] of longint;
    a: array[1..maxN] of int64;


procedure input;
var
	i,j: longint;
begin
	readln(fi,n,t);
    for i:= 1 to n do
    begin
    	read(fi,w[i]);
        idw[i]:= i;
    end;
    for i:= 1 to n do read(fi,a[i]);
    for i:= 1 to n do
    begin
		read(fi,j);
        a[i]:= j - a[i] * t;
        ida[i]:= i;
    end;
end;

procedure process;
var
	i,j,z1: longint;
    z2: int64;
begin
	for i:= 1 to n-1 do
    	for j:= i+1 to n do
        	if (w[i] > w[j]) then
            begin
            	z1:= w[i]; w[i]:= w[j]; w[j]:= z1;
                z1:= idw[i]; idw[i]:= idw[j]; idw[j]:= z1;
            end;
	
    for i:= 1 to n-1 do
    	for j:= i+1 to n do
        	if (a[i] > a[j]) then
            begin
            	z2:= a[i]; a[i]:= a[j]; a[j]:= z2;
                z2:= ida[i]; ida[i]:= ida[j]; ida[j]:= z2;
            end;

    for i:= 1 to n do
    	c[ida[i]]:= idw[i];
end;

procedure output;
var
	i: longint;
begin
	for i:= 1 to n do write(fo,c[i],' ');
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
