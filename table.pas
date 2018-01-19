uses math;
const
    inputfile = 'table.dat';
    outputfile = 'table.sol';
    maxN = 210;
    E = 1E-5;
type
    cot = record
        x,y: int64;
    end;
var
    fi,fo: text;
    xl,xr,r,n: longint;
    c: array[1..maxN] of cot;
    d: array[0..maxN,0..maxN] of double;
    a: array[0..maxN,0..maxN] of boolean;

    vs: array[0..maxN] of boolean;
    qu: array[1..maxN] of longint;
    dq,cq: longint;


procedure openfile;
begin
    assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure input;
var
    i: longint;
begin
    read(fi,xl,xr);
    read(fi,r);
    read(fi,n);
    for i:= 1 to n do
        read(fi,c[i].x,c[i].y);
end;

procedure init;
var
    i,j: longint;
begin
    for i:= 1 to n do
    begin
        d[0,i]:= c[i].x - xl - r;
        d[i,0]:= d[0,i];

        d[i,n+1]:= xr - c[i].x - r;
        d[n+1,i]:= d[i,n+1];
    end;
    d[0,n+1]:= xr - xl;
    d[n+1,0]:= d[0,n+1];

    //
    for i:= 1 to n-1 do
        for j:= i+1 to n do
        begin
            d[i,j]:= sqrt(sqr(c[i].x - c[j].x) + sqr(c[i].y - c[j].y)) - 2 * r;
            d[j,i]:= d[i,j];
        end;
end;

procedure build(m: double);
var
    i,j: longint;
begin
    fillchar(a,sizeof(a),false);

    for i:= 0 to n do
        for j:= i+1 to n+1 do
            if (d[i,j] - m <= E) then
            begin
                a[i,j]:= true;
                a[j,i]:= true;
            end;
end;

function canpass: boolean;
var
    u,v: longint;
begin
    fillchar(vs,sizeof(vs),false);

    dq:= 1; cq:= 1;
    qu[1]:= 0;
    vs[0]:= true;

    while (dq <= cq) do
    begin
        u:= qu[dq];
        inc(dq);

        for v:= 0 to n+1 do
            if a[u,v] and not vs[v] then
            begin
                inc(cq);
                qu[cq]:= v;
                vs[v]:= true;

                if (vs[n+1]) then exit(false);
            end;
    end;

    exit(true);
end;

procedure process;
var
    le,ri,mid,res: double;
begin
    le:= 0; ri:= xr - xl;
    while (ri - le >= E) do
    begin
        mid:= (le + ri)/2;
        build(mid);
        if canpass then
        begin
            res:= mid;
            le:= mid + E;
        end
        else ri:= mid - E;
    end;

    writeln(fo,res:0:3);
end;

procedure output;
begin
end;

procedure closefile;
begin
    close(fi);
    close(fo);
end;


begin
    openfile;
    input;
    init;
    process;
    output;
    closefile;
end.
