{
ID: ndchiph1
PROG: butter
LANG: PASCAL
}
uses math;
const
	inputfile = 'butter.in';
    outputfile = 'butter.out';
    maxP = 810;
    maxM = 1500;
    maxC = 300 * maxM;
//type

var
	fi,fo: text;
    cow,n,m,nheap,pt,res: longint;
    ncow: array[1..maxP] of longint;
    x,y,c: array[1..maxM] of longint;
    a,cost: array[1..2 * maxM] of longint;
    h: array[1..maxP] of longint;

	d,heap,pos: array[1..maxP] of longint;
    vs: array[1..maxP] of boolean;


procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;


procedure input;
var
	i,u,v: longint;
begin
	readln(fi,cow,n,m);
    for i:= 1 to cow do
    begin
    	readln(fi,u);
    	inc(ncow[u]);
    end;

    for i:= 1 to m do
    begin
    	readln(fi,x[i],y[i],c[i]);
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


procedure init;
var
	i: longint;	
begin
	d[pt]:= 0;
	nheap:= 1;
    heap[1]:= pt;
    pos[pt]:= 1;

    for i:= 1 to n do
    	if (i <> pt) then
        begin
			d[i]:= maxC;
            inc(nheap);
            heap[nheap]:= i;
            pos[i]:= nheap;
        end;
end;


function pop: longint;
var
	p,c,tmp: longint;
begin
	pop:= heap[1];

	tmp:= heap[nheap];
    dec(nheap);

    p:= 1;
    repeat
    	c:= p * 2;
        if (c < nheap) and (d[heap[c]] > d[heap[c+1]]) then inc(c);
        if (c > nheap) or (d[tmp] <= d[heap[c]]) then break;

        heap[p]:= heap[c];
        pos[heap[p]]:= p;
        p:= c;
    until FALSE;

    heap[p]:= tmp;
    pos[tmp]:= p;
end;


procedure update(x: longint);
var
	c,p,tmp: longint;
begin
	tmp:= heap[x];

    c:= x;
    repeat
    	p:= c div 2;
        if (p = 0) or (d[tmp] >= d[heap[p]]) then break;

        heap[c]:= heap[p];
        pos[heap[c]]:= c;
        c:= p;
    until FALSE;

    heap[c]:= tmp;
    pos[tmp]:= c;
end;


procedure DijkstraHeap;
var
	i,u,v,sum: longint;
begin
	init;
	
    //
    fillchar(vs,sizeof(vs),false);	
    repeat
		u:= pop;
        if (nheap = 0) then break;
        vs[u]:= true;

        for i:= h[u]+1 to h[u+1] do
        begin
			v:= a[i];
            if (vs[v]) then continue;

            if (d[v] > d[u] + cost[i]) then
            begin
				d[v]:= d[u] + cost[i];
                update(pos[v]);
            end;
        end;
    until FALSE;

    sum:= 0;
    for i:= 1 to n do
    	inc(sum,ncow[i] * d[i]);

    res:= min(res,sum);
end;


procedure process;
begin
	res:= maxlongint;
	for pt:= 1 to n do
		DijkstraHeap;
end;


procedure output;
begin
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
