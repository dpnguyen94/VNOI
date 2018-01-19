uses math;
const
	maxN = 1010;
//type

var
	fi,fo: text;
    n,qu: longint;
    a,c,d: array[1..maxN,1..maxN] of longint;
    roads: array[1..maxN] of longint;

    q: array[1..maxN] of longint;
	vs: array[1..maxN] of boolean;


procedure input;
var
	i,u,v,val: longint;
begin
	readln(fi,n,qu);
    for i:= 1 to n-1 do
    begin
		readln(fi,u,v,val);

        inc(roads[u]);
        a[u,roads[u]]:= v;
        c[u,v]:= val;

        inc(roads[v]);
        a[v,roads[v]]:= u;
        c[v,u]:= val;
    end;
end;

procedure BFS(i: longint);
var
	dq,cq,s,t,k: longint;
begin
	fillchar(vs,sizeof(vs),false);

	dq:= 1; cq:= 1;
    q[cq]:= i;
    vs[i]:= true;

    while (dq <= cq) do
    begin
    	s:= q[dq];
        inc(dq);

        for t:= 1 to roads[s] do
        begin
        	k:= a[s,t];
        	if not vs[k] then
            begin
            	inc(cq);
                q[cq]:= k;
                vs[k]:= true;

                d[i,k]:= d[i,s] + c[s,k];
            end;
        end;
    end;
end;

procedure process;
var
	i: longint;	
begin
    for i:= 1 to n do
    	BFS(i);
end;

procedure output;
var
	i,u,v: longint;
begin
	for i:= 1 to qu do
    begin
    	readln(fi,u,v);
        writeln(fo,d[u,v]);
    end;
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
