uses math;
const
    inputfile = 'v8org.inp';
    outputfile = 'v8org.out';
    maxN = 10010;
//type

var
    fi,fo: text;
    n,k,res: longint;
    x,y,h,nchild: array[1..maxN] of longint;
    a: array[1..2 * maxN] of longint;


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

    for i:= 1 to n-1 do
    begin
        x[i]:= i+1;
        read(fi,y[i]);

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

        dec(h[u]);
        dec(h[v]);
    end;
end;


procedure visit(u: longint);
var
    i,v: longint;
begin
    nchild[u]:= 1;

    for i:= h[u]+1 to h[u+1] do
    begin
        v:= a[i];
        if (nchild[v] = 0) then
        begin
        		visit(v);
        		nchild[u]:= nchild[u] + nchild[v];
        end;
    end;

    if (nchild[u] >= k) then
    begin
        inc(res);
        nchild[u]:= 0;
    end;
end;


procedure process;
begin
    visit(1);
end;


procedure output;
begin
    writeln(fo,res);
end;


begin
    openfile;
    input;
    process;
    output;
    closefile;
end.
