uses math;
const
    inputfile = '';
    outputfile = '';
    LM = 10010;
//type

var
    fi,fo: text;
    n,m,t,res: longint;
    a,h,x,y: array[1..LM] of longint;
    free,vs,mark: array[1..LM] of boolean;

procedure openfile;
begin
    assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;


procedure input;
var
    i,u,v: longint;
begin
    readln(fi,n,m,t);
    for i:= 1 to m do
    begin
        readln(fi,y[i],x[i]);
        inc(h[x[i]]);
    end;

    for i:= 2 to n+1 do
        h[i]:= h[i-1] + h[i];

    for i:= 1 to m do
    begin
        u:= x[i]; v:= y[i];
        a[h[u]]:= v;
        dec(h[u]);
    end;
end;

procedure dfs1(u: longint);
var
    v: longint;
begin
    free[u]:= false;
    for v:= h[u]+1 to h[u+1] do
        if free[a[v]] then dfs1(a[v]);
end;

procedure dfs2(u: longint);
var
    v: longint;
begin
    vs[u]:= true;
    for v:= h[u]+1 to h[u+1] do
        if (free[a[v]]) and (not vs[a[v]]) then dfs2(a[v]);
end;

procedure process;
var
    i: longint;
begin
    fillchar(free,sizeof(free),true);
    dfs1(t);

    for i:= 1 to n do
        if (free[i]) and (not vs[i]) then
        begin
            mark[i]:= true;
            dfs2(i);
        end;

    fillchar(vs,sizeof(vs),false);
    for i:= n downto 1 do
        if (free[i]) and (not vs[i]) and (mark[i]) then
        begin
            inc(res);
            dfs2(i);
        end;
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
