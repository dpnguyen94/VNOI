uses math;
const
	inputfile = 'graph_.in';
    outputfile = 'graph_.out';
    maxN = 10010;
    maxM = 50010;
//type

var
	fi,fo: text;
    n,m,count: longint;
    x,y: array[1..maxM] of longint;
    h: array[1..maxN] of longint;
    a,list: array[1..2 * maxM] of longint;

    low,nb,pr: array[1..maxN] of longint;
    nchild: array[1..maxN] of longint;
    iscut: array[1..maxN] of boolean;


procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;


procedure input;
var
	i,u,v: longint;
begin
	readln(fi,n,m);
    for i:= 1 to m do
    begin
		readln(fi,x[i],y[i]);
        inc(h[x[i]]);
        inc(h[y[i]]);
    end;

    for i:= 2 to n+1 do
    	h[i]:= h[i-1] + h[i];

    for i:= 1 to m do
    begin
    	u:= x[i];
        v:= y[i];

        a[h[u]]:= v;
        a[h[v]]:= u;
        list[h[u]]:= h[v];
        list[h[v]]:= h[u];

        dec(h[u]);
        dec(h[v]);
    end;
end;


procedure visit(u: longint);
var
	i,v: longint;
begin
	inc(count); nb[u]:= count;
    low[u]:= n+1;

    for i:= h[u]+1 to h[u+1] do
    begin
    	if (list[i] = 0) then continue;
    	v:= a[i];

        list[list[i]]:= 0;
        if (pr[v] = 0) then
        begin
        	pr[v]:= u;
            visit(v);

            low[u]:= min(low[u],low[v]);
        end
        else low[u]:= min(low[u],nb[v]);
    end;
end;


procedure process;
var
	i: longint;
begin
	count:= 0;	
    for i:= 1 to n do
    	if (pr[i] = 0) then
        begin
        	pr[i]:= -1;
            visit(i);
        end;
end;


procedure output;
var
	u,v: longint;
	br,cv: longint;
begin
	for v:= 1 to n do
    	if (pr[v] <> -1) then inc(nchild[pr[v]]);
	
    //	
    br:= 0;
    for v:= 1 to n do
    begin
    	u:= pr[v];
        if (u <> -1) and (low[v] >= nb[v]) then inc(br);
    end;

    for v:= 1 to n do
    begin
		u:= pr[v];
        if (u = -1) then continue;

        if (low[v] >= nb[u]) then
        	iscut[u]:= iscut[u] or (pr[u] <> -1) or (nchild[u] >= 2);
    end;

    cv:= 0;
    for u:= 1 to n do
    	if iscut[u] then inc(cv);

    //
    writeln(fo,cv,' ',br);
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
