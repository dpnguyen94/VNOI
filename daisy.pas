{
ID: ndchiph1
PROG: daisy
LANG: PASCAL
}
uses math;
const
	inputfile = 'daisy.in';
    outputfile = 'daisy.out';
    maxN = 251;
//type

var
	fi,fo: text;
    n,m: longint;
    a: array[0..maxN,0..maxN] of boolean;
    vs: array[0..maxN] of boolean;


procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure closefile;
begin
	close(fi);
    close(fo);
end;

procedure input;
var
	i,u,v: longint;
begin
	readln(fi,n,m);	
	for i:= 1 to m do
    begin
    	readln(fi,u,v);
        a[u,v]:= true;
        a[v,u]:= true;
    end;
end;

procedure dfs(u: longint);
var
	v: longint;
begin
	vs[u]:= true;
	for v:= 1 to n do
		if a[u,v] and not vs[v] then dfs(v);
end;

procedure process;
begin
	dfs(1);
end;

procedure output;
var
	u: longint;
    exist: boolean;
begin
	exist:= false;
	for u:= 1 to n do
    	if not vs[u] then
        begin
        	writeln(fo,u);
            exist:= true;
        end;
    if not exist then writeln(fo,0);
end;


BEGIN
	openfile;
    input;
    process;
    output;
    closefile;
END.
