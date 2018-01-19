{
ID: ndchiph1
PROG: game1
LANG: PASCAL
}
uses math;
const
	maxN = 5010;
var                                	
	fi,fo: text;
    a: array[1..maxN] of longint;
    s,f: array[0..maxN,0..maxN] of longint;
    n: longint;


procedure input;
var
	i,j: longint;
begin
	readln(fi,n);
    for i:= 1 to n do read(fi,a[i]);

    for i:= 1 to n do
    	for j:= i to n do
        	s[i,j]:= s[i,j-1] + a[j];
end;
	
procedure process;
var
	i,j: longint;
begin
	for j:= 1 to n do
    	for i:= j downto 1 do
            f[i,j]:= s[i,j] - min(f[i+1,j],f[i,j-1]);

    writeln(fo,f[1,n],' ',s[1,n] - f[1,n]);
end;


begin
	assign(fi,'game1.in1'); reset(fi);
    assign(fo,'game1.out'); rewrite(fo);
	//
    input;
    process;
    //
    close(fi);
    close(fo);
end.
