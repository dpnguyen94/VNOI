uses math;
const
    inputfile = 'CHENHLECH.INP';
    outputfile = 'CHENHLECH.OUT';
    maxN = 1000010;
var
    fi,fo: text;
    n,c: longint;
    a,b: array[1..maxN] of longint;


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


procedure process1;
var
    i,j,res: longint;
begin
    res:= maxlongint;
    for i:= 1 to n do
        for j:= 1 to n do
            res:= min(res,abs(a[i] + b[j] - c));

    writeln(fo,res);
end;


procedure sort_a(le,ri: longint);
var
    i,j,t,z: longint;
begin
    if (le >= ri) then exit;
    i:= le; j:= ri;
    t:= a[(i+j) div 2];

    repeat
        while (a[i] < t) do inc(i);
        while (a[j] > t) do dec(j);

        if (i <= j) then
        begin
            z:= a[i]; a[i]:= a[j]; a[j]:= z;
            inc(i); dec(j);
        end;
    until i > j;

    sort_a(le,j);
    sort_a(i,ri);
end;


procedure sort_b(le,ri: longint);
var
    i,j,t,z: longint;
begin
    if (le >= ri) then exit;
    i:= le; j:= ri;
    t:= b[(i+j) div 2];

    repeat
        while (b[i] > t) do inc(i);
        while (b[j] < t) do dec(j);

        if (i <= j) then
        begin
            z:= b[i]; b[i]:= b[j]; b[j]:= z;
            inc(i); dec(j);
        end;
    until i > j;

    sort_b(le,j);
    sort_b(i,ri);
end;


procedure process2;
var
    i,res: longint;
begin
    sort_a(1,n);
    sort_b(1,n);

    res:= maxlongint;
    for i:= 1 to n do
        res:= min(res,abs(a[i] + b[i] - c));

     writeln(fo,res);
end;


procedure input;
var
    i: longint;
begin
    readln(fi,n,c);
    for i:= 1 to n do
        read(fi,a[i]);
    for i:= 1 to n do
        read(fi,b[i]);

    if (n <= 10000) then process1
    else process2;
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
