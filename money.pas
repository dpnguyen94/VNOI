{
ID: ndchiph1	
PROG: money
LANG: PASCAL
}
uses math;
const
	MAX_N = 10000;
    MAX_V = 25;	
{
var
	fi,fo: text;
    f: array[0..MAX_N,1..MAX_V] of int64;
    c: array[1..MAX_V] of longint;
    v,n: longint;

procedure input;
var 	i: longint;
begin
	readln(fi,v,n);
	for i:= 1 to v do read(fi,c[i]);		
end;

procedure process;
var	i,j,k: longint;
begin
	fillchar(f,sizeof(f),0);

    for i:= 1 to v do f[0,i]:= 1;

    for i:= 1 to n do
    begin
    	for j:= 1 to v do
        begin
			for k:= j downto 1 do
            	if (c[k] <= i) then inc(f[i,j],f[i-c[k],k]);
        end;
    end;
	
    writeln(fo,f[n,v]);
end;
}
var	
	fi,fo: text;
    f: array[0..MAX_N] of int64;
    v,n: longint;

procedure process;
var 	i,j,c: longint;
begin
	readln(fi,v,n);

    fillchar(f,sizeof(f),0);
    f[0]:= 1;

    for i:= 1 to v do
    begin
    	read(fi,c);
        for j:= c to n do inc(f[j],f[j-c]);
    end;	

    writeln(fo,f[n]);
end;

begin
	assign(fi,'money.in'); reset(fi);
    assign(fo,'money.out'); rewrite(fo);
	//
    //input;
    process;

    //
    close(fi);
    close(fo);
end.
