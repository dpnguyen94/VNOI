uses math;
const
	inputfile = '';
    outputfile = '';
    maxN = 200001;
    LM = 1000000007;
//type

var
	fi,fo: text;
    n,count: longint;
    a,h,x,y,c,cost: array[1..maxN] of longint;
    vs: array[1..maxN] of boolean;
    ft,fd: array[0..maxN] of int64;


procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure input;
var
	i,u,v: longint;	
begin
	readln(fi,n);
    for i:= 1 to n-1 do
    begin
    	readln(fi,x[i],y[i],c[i]);

        inc(h[x[i]]);
        inc(h[y[i]]);
    end;

    for i:= 2 to n+1 do
    	h[i]:= h[i-1] + h[i];

    for i:= 1 to n-1 do
    begin
    	u:= x[i];
        v:= y[i];

        a[h[u]]:= v;
        a[h[v]]:= u;
        cost[h[u]]:= c[i];
        cost[h[v]]:= c[i];

        dec(h[u]);
        dec(h[v]);
    end;
end;

procedure visit(u: longint);
var
	i,v: longint;
    t: int64;
begin
	vs[u]:= true;

	for i:= h[u] + 1 to h[u+1] do
    begin
    	v:= a[i];
        if not vs[v] then
        begin
			ft[v]:= (ft[u] + fd[u] + 1) mod LM;
            ft[v]:= (ft[v] * cost[i]) mod LM;

            visit(v);

			t:= ((fd[v] + 1) * cost[i]) mod LM;
            fd[u]:= (fd[u] + t) mod LM;
		end;
    end;
end;

procedure process;
var
	i: longint;	
begin
	count:= 0;
    visit(1);
end;

procedure output;
var
	i: longint;
	res: int64;
begin
	res:= 0;
    for i:= 1 to n do
    	res:= (res + ft[i]) mod LM;

    //
    writeln(fo,res);
end;

procedure closefile;
begin
	close(fi);
    close(fo);
end;


begin
	openfile;
    input;
    process;
    output;
    closefile;
end.
