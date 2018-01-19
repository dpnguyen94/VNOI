uses math;
const
    inputfile = '';
    outputfile = '';
    maxN = 10000 + 10;
    maxM = 100000 + 10;
    maxC = 1000000 * 2 * maxM;
//type

var
	fi,fo: text;
    n,m,nheap: longint;
	a,cost: array[1..2 * maxM] of longint;
    x,y,c: array[1..maxM] of longint;
    h: array[1..maxN] of longint;

    d: array[1..maxN] of int64;
    heap,pos: array[1..maxN] of longint;
    vs: array[1..maxN] of boolean;


procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure input;
var
	i,u,v: longint;
begin
	read(fi,n,m);
    for i:= 1 to m do
    begin
    	read(fi,x[i],y[i],c[i]);
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
        cost[h[u]]:= c[i];
        cost[h[v]]:= c[i];

        dec(h[u]);
        dec(h[v]);
    end;
end;

function pop: longint;
var
	p,c,tmp: longint;
begin
	pop:= heap[1];

    //
    tmp:= heap[nheap];	
	dec(nheap);

    p:= 1;
    repeat
 		c:= p * 2;
        if (c < nheap) and (d[heap[c]] > d[heap[c+1]]) then inc(c);
        if (c > nheap) or (d[heap[c]] >= d[tmp]) then break;

        heap[p]:= heap[c];
        pos[heap[p]]:= p;
        p:= c;
    until FALSE;

    heap[p]:= tmp;
    pos[tmp]:= p;
end;

procedure update(x: longint);
var
	p,c,tmp: longint;	
begin
	tmp:= heap[x];
    c:= x;
    repeat
		p:= c div 2;
        if (p = 0) or (d[heap[p]] <= d[tmp]) then break;

	    heap[c]:= heap[p];
		pos[heap[c]]:= c;
        c:= p;
    until FALSE;

    heap[c]:= tmp;
    pos[tmp]:= c;
end;

procedure Prim_Heap;
var
	i,u,v,s: longint;
begin
    s:= 1;
    for i:= 1 to n do d[i]:= maxC;

    //
    nheap:= 1;
    d[s]:= 0;
    heap[1]:= s;
    pos[s]:= 1;

    for i:= 1 to n do
    	if (i <> s) then
        begin
			inc(nheap);
			heap[nheap]:= i;
            pos[i]:= nheap;
        end;

    repeat
		u:= pop;
        if (nheap = 0) then exit;
        vs[u]:= true;
        		
        for i:= h[u]+1 to h[u+1] do
        begin
			v:= a[i];
            if (vs[v]) then continue;

            if (d[v] > cost[i]) then
            begin
				d[v]:= cost[i];
				update(pos[v]);
            end;
        end;
    until FALSE;
end;

procedure output;
var
	i: longint;
  res: int64;
begin
	res:= 0;
	for i:= 1 to n do
  	res:= res + d[i];

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
    Prim_Heap;
    output;
    closefile;
end.
