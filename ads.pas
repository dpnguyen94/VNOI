uses math;
const
	inputfile = '';
    outputfile = '';
    maxN = 2010;
//type

var
	fi,fo: text;
    n,m,count: longint;
    a: array[1..maxN,1..maxN] of boolean;
    vs: array[1..maxN] of boolean;
    	

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

procedure dfs(i: longint);
var
	j: longint;
begin
	vs[i]:= true;

    for j:= 1 to n do
    	if not vs[j] and a[i,j] then dfs(j);
end;

procedure process;
var
	i: longint;
begin
	count:= 0;
    for i:= 1 to n do
    	if not vs[i] then
        begin
        	inc(count);
        	dfs(i);
        end;
end;

procedure output;
begin
	writeln(fo,m - n + count);
end;


BEGIN
	openfile;
    input;
    process;
    output;
    closefile;
END.
