uses math;
const
    inputfile = '';
    outputfile = '';
    maxN = 10010;
    maxM = 100010;
    maxC = 1000000000;
//type

var
    fi,fo: text;
    n,m,sum,nheap: longint;
    x,y,c: array[1..maxM] of longint;
    h,d: array[1..maxN] of longint;
    a,cost: array[1..2 * maxM] of longint;
    vs: array[1..maxN] of boolean;

    heap: array[1..maxN] of longint;
    pos: array[1..maxN] of longint;


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
        readln(fi,x[i],y[i],c[i]);

        inc(h[x[i]]);
        inc(h[y[i]]);

        sum:= sum + c[i];
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
    nheap:= n;
    d[1]:= 0;
    heap[1]:= 1;
    pos[1]:= 1;

    for i:= 2 to n do
    begin
        d[i]:= -maxC;
        heap[i]:= i;
        pos[i]:= i;
    end;
end;


function pop: longint;
var
    i,p,c: longint;
begin
    pop:= heap[1];

    i:= heap[nheap];
    dec(nheap);

    p:= 1;
    repeat
        c:= p * 2;
        if (c < nheap) and (d[heap[c]] < d[heap[c+1]]) then inc(c);
        if (c > nheap) or (d[i] >= d[heap[c]]) then break;

		heap[p]:= heap[c];
        pos[heap[p]]:= p;
        p:= c;
    until FALSE;

    heap[p]:= i;
    pos[i]:= p;
end;


procedure update(x: longint);
var
    i,c,p: longint;
begin
    i:= heap[x];

	c:= x;
    repeat
        p:= c div 2;
        if (p = 0) or (d[i] <= d[heap[p]]) then break;

        heap[c]:= heap[p];
        pos[heap[c]]:= c;
        c:= p;
    until FALSE;

    heap[c]:= i;
    pos[i]:= c;
end;


procedure process;
var
    i,u,v: longint;
begin
    repeat
        u:= pop;
        if (d[u] = -maxC) then d[u]:= 0;
        if (nheap = 0) then exit;
        vs[u]:= true;

        for i:= h[u]+1 to h[u+1] do
        begin
            v:= a[i];

            if not vs[v] and (d[v] < cost[i]) then
            begin
                d[v]:= cost[i];
                update(pos[v]);
            end;
        end;
    until FALSE;
end;


procedure output;
var
    i,res: longint;
begin
    res:= 0;
    for i:= 1 to n do
        res:= res + d[i];

    writeln(fo,sum - res);
end;


begin
    openfile;
    input;
    init;
    process;
    output;
    closefile;
end.
