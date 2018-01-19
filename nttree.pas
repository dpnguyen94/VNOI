uses math;
const
	inputfile = '';
    outputfile = '';
    maxN = 200001;
//type

var
	fi,fo: text;
    n,count: longint;
    a,h,x,y,nb: array[1..maxN] of longint;
    ft,fd,c,cost: array[0..maxN] of int64;


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
        inc(x[i]);
        inc(y[i]);

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
begin
    inc(count);
    nb[u]:= count;

	for i:= h[u] + 1 to h[u+1] do
    begin
    	v:= a[i];
        if (nb[v] = 0) then
        begin
            ft[v]:= ft[u] + fd[u] + count * cost[i];
            visit(v);
            fd[u]:= fd[u] + fd[v]
            	+ (count - nb[v] + 1) * cost[i];
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
    	res:= res + ft[i];

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
