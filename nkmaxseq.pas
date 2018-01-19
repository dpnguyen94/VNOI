uses math;
const
    inputfile = '';
    outputfile = '';
    maxN = 50010;
//type

var
    fi,fo: text;
    n,p,res1: longint;
    a,b,s,next: array[0..maxN] of longint;


procedure openfile;
begin
    assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;


procedure input;
var
    i: longint;
begin
    readln(fi,n,p);
    for i:= 1 to n do
    begin
        readln(fi,a[i]);
        s[i]:= s[i-1] + a[i];
    end;
end;

procedure init;
var
    i,j: longint;
begin
    j:= 1;
    for i:= 0 to n-1 do
    begin
        while (s[j] >= s[i]) and (j <= n) do inc(j);
        next[i]:= j;
    end;
end;

procedure process;
var
    i,j,le,ri,mid,res2: longint;
begin
    i:= 0;
    j:= 1;
    while (next[i] <> 0) do
    begin
        inc(j);
        b[j]:= i;
        i:= next[i];
    end;

    for i:= 1 to n do
    begin
        le:= 1; ri:= j;
        res2:= -1;

        while (le <= ri) do
        begin
            mid:= (le + ri) div 2;
            if (s[i] - s[b[mid]] >= p) then
            begin
                res2:= b[mid];
                ri:= mid-1;
            end
            else le:= mid + 1;
        end;

        if (res2 <> -1) and (i - res2 > res1) then
            res1:= i - res2;
    end;
end;

procedure output;
begin
    if (res1 <> 0) then
        writeln(fo,res1)
    else writeln(fo,-1);
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
