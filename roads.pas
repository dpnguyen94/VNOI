uses math;
const
    inputfile = '';
    outputfile = '';
    maxN = 110;
    maxM = 10010;
    maxK = 10010;
    maxC = 110 * maxM;
type
    state = record
        x,tt: longint;
    end;
var
    fi,fo: text;
    ntest,test,n,m,k,nheap: longint;
    x,y,lt,tt: array[1..maxM] of longint;
    h: array[1..maxN] of longint;
    a,l,t: array[1..maxM] of longint;
    d: array[1..maxN,0..maxK] of longint;

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
    readln(fi,k);
    readln(fi,n);
    readln(fi,m);

    fillchar(h,sizeof(h),0);

    for i:= 1 to m do
    begin
        readln(fi,x[i],y[i],lt[i],tt[i]);
        inc(h[x[i]]);
    end;

    for i:= 2 to n+1 do
        h[i]:= h[i-1] + h[i];

    for i:= 1 to m do
    begin
        u:= x[i];
        v:= y[i];

        a[h[u]]:= v;
        l[h[u]]:= lt[i];
        t[h[u]]:= tt[i];

        dec(h[u]);
    end;
end;


procedure init;
var
    i,j: longint;
begin
    d[1,0]:= 0;
    nheap:= 1;
    heap[1].x:= 1;
    heap[1].tt:= 0;
    pos[1,0]:= 1;

    for i:= 2 to n do
        for j:= 0 to k do
        begin
            d[i,j]:= maxC;
            inc(nheap);
            heap[nheap].x:= i;
            heap[nheap].tt:= j;
            pos[i,j]:= nheap;
        end;
end;


procedure pop(var u,st: longint);
var
    i,j,p,c: longint;
begin
    u:= heap[1].x;
    st:= heap[1].tt;

    i:= heap[nheap].x;
    j:= heap[nheap].tt;
    dec(nheap);

    p:= 1;
    repeat
        c:= p * 2;
        if (c < nheap) and (d[heap[c].x,heap[c].tt] > d[heap[c+1].x,heap[c+1].tt]) then inc(c);
        if (c > nheap) or (d[i,j] <= d[heap[c].x,heap[c].tt]) then break;

        heap[p]:= heap[c];
        pos[heap[p].x,heap[p].tt]:= p;
        p:= c;
    until FALSE;

    heap[p].x:= i;
    heap[p].tt:= j;
    pos[i,j]:= p;
end;


procedure update(u: longint);
var
    i,j,c,p: longint;
begin
    i:= heap[u].x;
    j:= heap[u].tt;

    c:= u;
    repeat
        p:= c div 2;
        if (p = 0) or (d[i,j] >= d[heap[p].x,heap[p].tt]) then break;

        heap[c]:= heap[p];
        pos[heap[c].x,heap[c].tt]:= c;
        c:= p;
    until FALSE;

    heap[c].x:= i;
    heap[c].tt:= j;
    pos[i,j]:= c;
end;


procedure process;
var
    u,st,i,v,tmp: longint;
begin
    fillchar(vs,sizeof(vs),false);
    repeat
        pop(u,st);
		if (nheap = 0) then exit;

        vs[u,st]:= true;

        for i:= h[u]+1 to h[u+1] do
        begin
            v:= a[i];
            tmp:= st + t[i];
            if (tmp <= k) then
                if not vs[v,tmp] and (d[v,tmp] > d[u,st] + l[i]) then
                begin
                    d[v,tmp]:= d[u,st] + l[i];
                    update(pos[v,tmp]);
                end;
        end;
    until FALSE;
end;


procedure output;
var
	i,res: longint;
begin
	res:= maxC;
	for i:= 0 to k do
    	if (d[n,i] < res) then res:= d[n,i];

    //
    if (res = maxC) then writeln(fo,-1)
    else writeln(fo,res);
end;


begin
    openfile;
    readln(fi,ntest);
    for test:= 1 to ntest do
    begin
        input;
        init;
        process;
        output;
    end;
    closefile;
end.
