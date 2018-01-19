uses math;
const
    inputfile = 'BIENDOI.INP';
    outputfile = 'BIENDOI.OUT';
    maxN = 110;
    maxC = 1000000000;
//type

var
    fi,fo: text;
    n,d: longint;
    a: array[1..maxN] of longint;
    f: array[1..maxN,0..maxN] of longint;


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
    readln(fi,n,d);
    for i:= 1 to n do
        read(fi,a[i]);
end;


procedure process;
var
    i,j,k: longint;
begin
    for i:= 0 to maxN do
        f[1,i]:= abs(a[1] - i);

    for i:= 2 to n do
        for j:= 0 to maxN do
        begin
            f[i,j]:= maxC;

            for k:= 0 to maxN do
                if (abs(j-k) <= d) then
                    f[i,j]:= min(f[i,j],f[i-1,k] + abs(a[i] - j));
        end;
end;


procedure output;
var
    i,res: longint;
begin
    res:= maxC;
    for i:= 0 to 100 do
        if (f[n,i] < res) then res:= f[n,i];

    writeln(fo,res);
end;


begin
    openfile;
    input;
    process;
    output;
    closefile;
end.
