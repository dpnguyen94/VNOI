uses math;
const
    inputfile = '';
    outputfile = '';
    maxN = 100010;
//type

var
    fi,fo: text;
    n,imin: longint;
    count: int64;
    le,ri: array[0..maxN] of longint;
    w,h,f: array[0..maxN] of int64;


procedure openfile;
begin
    assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure input;
var
    i: longint;
begin
    readln(fi,n);

    imin:= 1;
    for i:= 1 to n do
    begin
        readln(fi,w[i],h[i]);
        if (h[i] < h[imin]) then imin:= i;

        le[i]:= i-1; ri[i]:= i+1;
    end;
    h[0]:= maxlongint;
    h[n+1]:= maxlongint;
end;

procedure fill(i: longint);
var
    j: longint;
begin
    if (h[le[i]] < h[i]) then
    begin
        fill(le[i]);
        exit;
    end;
    if (h[ri[i]] < h[i]) then
    begin
        fill(ri[i]);
        exit;
    end;

    f[i]:= count + w[i];

    j:= 0;
    if (h[le[i]] < h[ri[i]]) then j:= le[i]
    else j:= ri[i];


    if (j <> 0) then
    begin
        count:= count + w[i] * (h[j] - h[i]);


        if (j < i) then
        begin
            ri[j]:= ri[i];
            le[ri[i]]:= j;
        end
        else
        begin
            le[j]:= le[i];
            ri[le[i]]:= j;
        end;

        w[j]:= w[j] + w[i];

        fill(j);
    end;
end;

procedure process;
begin
    count:= 0;
    fill(imin);
end;

procedure output;
var
    i: longint;
begin
    for i:= 1 to n do
        writeln(fo,f[i]);
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
