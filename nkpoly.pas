uses math;
const
    inputfile = '';
    outputfile = '';
    maxN = 210;
type
    point = record
        x,y: int64;
    end;

var
    fi,fo: text;
    n: longint;
    p: array[1..maxN] of point;
    f1,f2: array[1..maxN,1..maxN] of int64;


procedure openfile;
begin
    assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure input;
var
    i: longint;
begin
    read(fi,n);
    for i:= 1 to n do
        read(fi,p[i].x,p[i].y);
end;

function area(p1,p2,p3: point): int64;
begin
    area:= abs((p1.x - p2.x) * (p1.y + p2.y) + (p2.x - p3.x) * (p2.y + p3.y)
            + (p3.x - p1.x) * (p3.y + p1.y));
end;

procedure process;
var
    i,j,t: longint;
    k,m: int64;
begin
    for i:= 1 to n-2 do
    begin
        f1[i,i+2]:= area(p[i],p[i+1],p[i+2]);
        f2[i,i+2]:= f1[i,i+2];
    end;

    for j:= 4 to n do
        for i:= j-3 downto 1 do
        begin
            f1[i,j]:= low(int64);
            f2[i,j]:= high(int64);

            for t:= i+1 to j-1 do
            begin
                k:= area(p[i],p[t],p[j]);

                if (f1[i,j] < k) then f1[i,j]:= k;
                if (f1[i,j] < f1[i,t]) then f1[i,j]:= f1[i,t];
                if (f1[i,j] < f1[t,j]) then f1[i,j]:= f1[t,j];

                m:= low(int64);
                if (m < k) then m:= k;
                if (m < f2[i,t]) then m:= f2[i,t];
                if (m < f2[t,j]) then m:= f2[t,j];

                if (f2[i,j] > m) then f2[i,j]:= m;
            end;
        end;
end;

procedure output;
begin
    writeln(fo,f1[1,n]/2:0:1);
    writeln(fo,f2[1,n]/2:0:1);
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
