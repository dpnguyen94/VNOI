uses math;
const
    inputfile = '';
    outputfile = '';
    maxN = 40;
//type

var
    fi,fo: text;
    n,m,res2,res3,res: longint;
    a: array[1..maxN,1..maxN] of boolean;
    x,h,id: array[1..maxN] of longint;
    mark: array[1..maxN] of boolean;


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


procedure solve;
var
    i,j,t: longint;
begin
    t:= 0;
    for i:= 1 to n do
        if (x[i] = 1) then inc(t);
    if (t >= res) then exit;

    fillchar(mark,sizeof(mark),false);
    for i:= 1 to n do
        if (x[i] = 1) then
        begin
            mark[i]:= true;
            for j:= 1 to n do
                if (a[i,j]) then mark[j]:= true;
        end;

    for i:= 1 to n do
        if (mark[i] = false) then exit;

    res:= t;
end;


procedure attempt(i: longint);
var
    j: longint;
begin
    for j:= 0 to 1 do
    begin
        x[i]:= j;
        if (i = n) then solve
        else attempt(i+1);
    end;
end;


procedure process1;
begin
    res:= maxN;
    attempt(1);
    writeln(fo,res);
end;


procedure swap(var x,y: longint);
var
    z: longint;
begin
    z:= x;
    x:= y;
    y:= z;
end;


procedure sort;
var
    i,j: longint;
begin
    for i:= 1 to n do
        id[i]:= i;

    for i:= 1 to n-1 do
        for j:= i+1 to n do
            if (h[i] < h[j]) then
            begin
                swap(h[i],h[j]);
                swap(id[i],id[j]);
            end;
end;


procedure process2;
var
    i,u,v: longint;
begin
	x:= h;
    sort;

    res2:= 0;
    fillchar(mark,sizeof(mark),false);
    for i:= 1 to n do
    begin
        u:= id[i];
        if (mark[u]) then continue;

        inc(res2);
        mark[u]:= true;
        for v:= 1 to n do
            if (a[u,v]) then mark[v]:= true;
    end;
end;


procedure process3;
var
    i,u,v,hmax: longint;
begin
	h:= x;
    res3:= 0;
    fillchar(mark,sizeof(mark),false);
    repeat
        hmax:= 0;
        for i:= 1 to n do
            if (h[i] > hmax) then
            begin
                hmax:= h[i];
                u:= i;
            end;

        if (hmax = 0) then break;

        inc(res3);
        mark[u]:= true;
        for v:= 1 to n do
            if (a[u,v]) then mark[v]:= true;

        fillchar(h,sizeof(h),0);
        for u:= 1 to n do
            for v:= 1 to n do
                if a[u,v] and not mark[v] then inc(h[u]);
    until FALSE;

    res:= min(res2,res3);
    writeln(fo,res);
end;


procedure input;
var
    i,u,v: longint;
begin
    readln(fi,n,m);
    for i:= 1 to n do
    begin
    	h[i]:= 1;
        a[i,i]:= true;
    end;

    for i:= 1 to m do
    begin
        readln(fi,u,v);
        a[u,v]:= true;
        a[v,u]:= true;

        inc(h[u]);
        inc(h[v]);
    end;
	
    //
    if (n <= 20) then process1
    else
    begin
        process2;
        process3;
    end;
end;


procedure output;
begin
end;


begin
    openfile;
    input;
    output;
    closefile;
end.
