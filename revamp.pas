uses math;
const
	inputfile = 'revamp.inp';
    outputfile = 'revamp.out';
	maxN = 10010;
  	maxM = 50010;
    maxK = 21;
    maxC = 1000000 * maxM;
type
	state = record
		x,st: longint;
    end;
var
	fi,fo: text;
    n,m,k,nheap: longint;
    x,y,c: array[1..maxM] of longint;
	a,cost: array[1..2 * maxM] of longint;
    h: array[1..maxN] of longint;
    d: array[1..maxN,0..maxK] of int64;

    heap: array[1..maxK * maxN] of state;
	pos: array[1..maxN,0..maxK] of longint;
    vs: array[1..maxN,0..maxK] of boolean;


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
	readln(fi,n,m,k);
    for i:= 1 to m do
    begin
    	readln(fi,x[i],y[i],c[i]);
        inc(h[x[i]]);
        inc(h[y[i]]);
    end;

    for i:= 2 to n do
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

procedure init;
var
	i,j: longint;	
begin
	d[1,0]:= 0;
	nheap:= 1;
    heap[1].x:= 1;
    heap[1].st:= 0;
    pos[1,0]:= 1;
    		
    for i:= 2 to n do
    	for j:= 0 to k do
        begin
        	d[i,j]:= maxC;
			inc(nheap);
            heap[nheap].x:= i;
            heap[nheap].st:= j;
            pos[i,j]:= nheap;
        end;
end;

procedure pop(var u,tt: longint); //downheap;
var
	i,j,p,c: longint;
begin
	u:= heap[1].x;
    tt:= heap[1].st;

    i:= heap[nheap].x;
    j:= heap[nheap].st;
    dec(nheap);

    p:= 1;
    repeat
		c:= p * 2;
        if (c < nheap) and (d[heap[c].x,heap[c].st] > d[heap[c+1].x,heap[c+1].st]) then inc(c);
		if (c > nheap) or (d[i,j] <= d[heap[c].x,heap[c].st]) then break;

        heap[p]:= heap[c];
        pos[heap[p].x,heap[p].st]:= p;
        p:= c;
    until FALSE;

    heap[p].x:= i;
    heap[p].st:= j;
    pos[i,j]:= p;
end;

procedure update(u: longint); //upheap;
var
	i,j,c,p: longint;
begin
	i:= heap[u].x;
    j:= heap[u].st;

	c:= u;
    repeat
    	p:= c div 2;
        if (p = 0) or (d[i,j] >= d[heap[p].x,heap[p].st]) then break;

        heap[c]:= heap[p];
        pos[heap[c].x,heap[c].st]:= c;
        c:= p;
    until FALSE;		

    heap[c].x:= i;
    heap[c].st:= j;
    pos[i,j]:= c;
end;

procedure process;
var
	u,tt,i,v: longint;		
begin
	repeat
		pop(u,tt);
		if (nheap = 0) then exit;
        vs[u,tt]:= true;

        for i:= h[u]+1 to h[u+1] do
        begin
			v:= a[i];
            if not vs[v,tt] and (d[v,tt] > d[u,tt] + cost[i]) then
            begin
            	d[v,tt]:= d[u,tt] + cost[i];
            	update(pos[v,tt]);
            end;
			
            if (tt < k) then
            	if not vs[v,tt+1] and (d[v,tt+1] > d[u,tt]) then
                begin
                	d[v,tt+1]:= d[u,tt];
                    update(pos[v,tt+1]);
                end;
        end;
    until FALSE;		
end;

procedure output;
begin
    writeln(fo,d[n,k]);
end;


BEGIN
	openfile;
    input;
    init;
    process;
    output;
    closefile;
END.
