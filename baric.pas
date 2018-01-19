uses math;
const
    maxN = 110;
//type

var
    fi,fo: text;
    n,e: longint;
    m,sd,sc: array[1..maxN] of longint;
    s,f: array[0..maxN,0..maxN] of longint;


procedure input;
var
    i: longint;
begin
    readln(fi,n,e);
    for i:= 1 to n do read(fi,m[i]);
end;

procedure init;
var
    i,j,k,t: longint;
begin
    for i:= 1 to n-1 do
        for j:= i+1 to n do
        begin
            t:= m[i] + m[j];
            for k:= i+1 to j-1 do
                s[i,j]:= s[i,j] + abs(2 * m[k] - t);
        end;

    for i:= 1 to n do
    begin
        for j:= 1 to i-1 do
            sd[i]:= sd[i] + 2 * abs(m[j] - m[i]);

        for j:= i to n do
            sc[i]:= sc[i] + 2 * abs(m[j] - m[i]);
    end;
end;

procedure process;
var
    i,j,k,t: longint;
begin
    for i:= 1 to n do
        f[1,i]:= sd[i];


    for i:= 2 to n do
        for j:= i to n do
        begin
            t:= maxlongint;
            for k:= i-1 to j-1 do
                t:= min(t,f[i-1,k] + s[k,j]);

            f[i,j]:= t;
        end;

    for i:= 1 to n do
        for j:= i to n do
            f[i,j]:= f[i,j] + sc[j];


    for i:= 1 to n do
    begin
        t:= maxlongint;
        for j:= i to n do
            if (f[i,j] <= e) and (f[i,j] < t) then
                t:= f[i,j];

        if (t < maxlongint) then break;
    end;

    writeln(fo,i,' ',t);
end;


begin
    assign(fi,''); reset(fi);
    assign(fo,''); rewrite(fo);
    //
    input;
    init;
    process;
    //
    close(fi);
    close(fo);
end.
