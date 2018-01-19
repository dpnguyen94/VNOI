uses math;
const
    MAX_N = 1000;
var
    fi,fo: text;
    a: array[1..MAX_N,1..2] of longint;
    c,d: array[1..MAX_N] of longint;
    n: longint;


procedure input;
var i: longint;
begin
    readln(fi,n);
    for i:= 1 to n do readln(fi,c[i],d[i]);
end;


procedure dp;
var i,t: longint;
begin
    a[1,1]:= c[1];
    a[1,2]:= d[1];

    //
    for i:= 2 to n do
    begin
        a[i,1]:= a[i-1,1] + c[i] + abs(d[i]-d[i-1]);
        t:= a[i-1,2] + c[i] + abs(d[i]-c[i-1]);

        if (a[i,1] < t) then a[i,1]:= t;

        a[i,2]:= a[i-1,1] + d[i] + abs(c[i]-d[i-1]);
        t:= a[i-1,2] + d[i] + abs(c[i]-c[i-1]);

        if (a[i,2] < t) then a[i,2]:= t;
    end;

    writeln(fo,max(a[n,1],a[n,2]));
end;

begin
    assign(fi,''); reset(fi);
    assign(fo,''); rewrite(fo);
    //
    input;
    dp;
    //
    close(fi);
    close(fo);
end.