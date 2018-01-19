{
ID: ndchiph1	
PROG: milk3
LANG: PASCAL
}
uses math;
const
	MAX = 20;
type
	mang = array[1..3] of integer;
var	
	src: array[1..6] of integer = (1,1,2,2,3,3);
    des: array[1..6] of integer = (2,3,1,3,1,2);

	fi,fo: text;
	m: array[0..MAX,0..MAX] of boolean;
    f: array[0..MAX] of boolean;
    b: mang;
    total: integer;

procedure input;
var	i: integer;
begin
	for i:= 1 to 3 do read(fi,b[i]);
    total:= b[3];
end;

procedure pour(x,y: integer; var a: mang);
begin
	if (a[x] < b[y]-a[y]) then begin
        a[y]:= a[y] + a[x];
    	a[x]:= 0;
    end else
    begin
    	a[x]:= a[x] - (b[y]-a[y]);
        a[y]:= b[y];
    end;
end;

procedure dfs(i,j: integer);
var k: integer;
	a: array[1..3] of integer;
begin
	//
	m[i,j]:= true;
    for k:=1 to 6 do begin
    	a[1]:= i; a[2]:= j; a[3]:= total-i-j;
        pour(src[k], des[k], a);
        if not m[a[1],a[2]] then dfs(a[1], a[2]);
    end;
end;


procedure process;
var 	i,j,t: integer;
		first: boolean;
begin
	//
	fillchar(m,sizeof(m),false);
	fillchar(f,sizeof(f),false);

    //
    dfs(0,0);

    //
    for i:= 0 to MAX do
	 	if (m[0,i]) then
        begin
        	t:= b[3]-i;
            if (t >= 0) then f[t]:= true;
        end;

    //
    first:= true;
    for i:= 0 to MAX do
		if (f[i]) then begin
        	if not first then write(fo, ' ');
            first:= false;
        	write(fo,i);
        end;
    writeln(fo);
end;


begin
	assign(fi,'milk3.in'); reset(fi);
    assign(fo,'milk3.out'); rewrite(fo);
    //
    input;
	process;
    //
    close(fi);
	close(fo);
end.