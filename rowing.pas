uses math;
const
    inputfile = 'ROWING.INP';
    outputfile = 'ROWING.OUT';
    maxN = 4010;
    maxC = sqr(1000000000) + 10;
type
    point = record
        x,y: int64;
    end;
var
    fi,fo: text;
    n,h: longint;
    p: array[0..maxN] of point;
    d: array[0..maxN] of double;
    vs: array[0..maxN] of boolean;


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
    i: longint;
begin
    readln(fi,n,h);
    for i:= 1 to n do
        readln(fi,p[i].x,p[i].y);
    p[0].y:= h;
end;


function calc(i,j: longint): double;
var
    tmp: double;
begin
	if (i = 0) or (i = n+1)
    	or (j = 0) or (j = n+1) then exit(abs(p[i].y - p[j].y));

    tmp:= sqrt(sqr(p[i].x - p[j].x) + sqr(p[i].y - p[j].y));
    exit(tmp);
end;


procedure init;
var
    i: longint;
begin
    d[0]:= 0;
    for i:= 1 to n+1 do
        d[i]:= maxC;
end;


procedure process;
var
    u,v: longint;
    dmin,tmp: double;
begin
    repeat
        u:= -1;
        dmin:= maxC;

        for v:= 0 to n+1 do
            if not vs[v] and (d[v] < dmin) then
            begin
                u:= v;
                dmin:= d[v];
            end;

        if (u = -1) or (u = n+1) then exit;
        vs[u]:= true;

        for v:= 0 to n+1 do
            if not vs[v] then
            begin
                tmp:= calc(u,v);
                if (tmp < d[u]) then tmp:= d[u];

                if (d[v] > tmp) then d[v]:= tmp;
            end;
    until FALSE;
end;


procedure output;
begin
    writeln(fo,trunc(d[n+1]));
end;


begin
    openfile;
    input;
    init;
    process;
    output;
    closefile;
end.
