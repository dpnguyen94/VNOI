uses math;
const
	inputfile = '';
    outputfile = '';
    maxN = 1010;
    maxM = 100010;
    maxK = 11;
    maxC = 1000010 * maxM;
type
	state = record
    	co,sl: longint;
    end;
var
	fi,fo: text;
    n,m,k,nheap: longint;
    x,y,ct: array[1..maxM] of longint;
    h: array[1..maxN] of longint;
    a: array[1..2 * maxM] of longint;
    c: array[1..2 * maxM] of double;
    d: array[1..maxN,0..maxK] of double;
    pos: array[1..maxN,0..maxK] of longint;

    vs: array[1..maxN,0..maxK] of boolean;
    heap: array[1..maxN * maxK] of state;


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
        readln(fi,x[i],y[i],ct[i]);
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
        c[h[u]]:= ct[i];
        c[h[v]]:= ct[i];

        dec(h[u]);
        dec(h[v]);
    end;
end;

procedure init;
var
	i,j: longint;
begin
	nheap:= 1;
	d[1,0]:= 0;
    heap[1].co:= 1;
    heap[1].sl:= 0;
    pos[1,0]:= 1;

    for i:= 2 to n do
    	for j:= 0 to k do
        begin
        	d[i,j]:= maxC;
			inc(nheap);
            heap[nheap].co:= i;
            heap[nheap].sl:= j;
            pos[i,j]:= nheap;
        end;
end;

procedure pop(var u,x: longint); //downheap;
var
	p,c,i,j: longint;
begin
	u:= heap[1].co;
    x:= heap[1].sl;

    i:= heap[nheap].co;
    j:= heap[nheap].sl;
	dec(nheap);

    p:= 1;
    repeat
    	c:= p * 2;
        if (c < nheap) and (d[heap[c].co,heap[c].sl] > d[heap[c+1].co,heap[c+1].sl]) then inc(c);
		if (c > nheap) or (d[i,j] <= d[heap[c].co,heap[c].sl]) then break;

        heap[p]:= heap[c];
		pos[heap[p].co,heap[p].sl]:= p;
        p:= c;
    until FALSE;

    heap[p].co:= i;
    heap[p].sl:= j;
    pos[i,j]:= p;
end;

procedure update(ps: longint); //upheap;
var
	c,p,i,j: longint;
begin
	i:= heap[ps].co;
    j:= heap[ps].sl;

    c:= ps;
    repeat
		p:= c div 2;
        if (p = 0) or (d[i,j] >= d[heap[p].co,heap[p].sl]) then break;

        heap[c]:= heap[p];
		pos[heap[c].co,heap[c].sl]:= c;
        c:= p;
    until FALSE;

    heap[c].co:= i;
    heap[c].sl:= j;
    pos[i,j]:= c;
end;

procedure process;
var
	i,u,x,v,y: longint;
    tmp: double;
begin
	repeat
		pop(u,x);
        if (nheap = 0) then exit;
        vs[u,x]:= true;

        for i:= h[u]+1 to h[u+1] do
        begin
			v:= a[i];

            for y:= x to k do
            begin
            	if vs[v,y] then continue;

            	tmp:= d[u,x] + c[i] / (1 shl (y - x));
            	if (d[v,y] > tmp) then
                begin
                	d[v,y]:= tmp;
                    update(pos[v,y]);
                end;
            end;
        end;
    until FALSE;
end;

procedure output;
begin
	writeln(fo,d[n,k]:0:2);
end;


BEGIN
	openfile;
    input;
    init;
    process;
    output;
    closefile;
END.
