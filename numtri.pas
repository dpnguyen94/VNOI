{
ID: ndchiph1
PROG: numtri
LANG: PASCAL
}

uses math;
var
	fi,fo: text;
    r: integer;
    f,a: array[1..1000,1..1000] of longint;

procedure input;
var	i,j: integer;
begin
	readln(fi,r);
	for i:= 1 to r do
    begin
    	for j:= 1 to i do read(fi,a[i,j]);
        readln(fi);
    end;
end;

procedure dp;
var	i,j: integer;
	res: longint;
begin
	fillchar(f,sizeof(f),0);

    //init;
    f[1,1]:= a[1,1];
    for i:= 2 to r do
    begin
    	f[i,1]:= f[i-1,1]+a[i,1];
        f[i,i]:= f[i-1,i-1]+a[i,i];
    end;

    //
    for i:= 3 to r do
    	for j:= 2 to i-1 do
        	f[i,j]:= max(f[i-1,j],f[i-1,j-1])+a[i,j];
    //
    res:= 0;
    for i:= 1 to r do if f[r,i] > res then res:= f[r,i];
	
    writeln(fo,res);
end;


begin
	assign(fi,'numtri.in'); reset(fi);
    assign(fo,'numtri.out'); rewrite(fo);
    //
   	input;
    dp;
    //
    close(fi);
    close(fo);
end.