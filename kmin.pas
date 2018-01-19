uses math;
const
    LM = 50010;
type
    mang = array[1..LM] of longint;

var
    fi,fo: text;
    a,b,h,cur: mang;
    m,n,k: longint;
    nheap: longint;

procedure input;
var
    i: longint;
begin
    readln(fi,m,n,k);
    for i:= 1 to m do readln(fi,a[i]);
    for i:= 1 to n do readln(fi,b[i]);
end;

procedure sort(var c: mang; le,ri: longint);
var
    i,j,z,t: longint;
begin
    if (le >= ri) then exit;
    i:= le; j:= ri;
    t:= c[(i+j) div 2];

    repeat
        while (c[i] < t) do inc(i);
        while (c[j] > t) do dec(j);

        if (i <= j) then
        begin
            z:= c[i]; c[i]:= c[j]; c[j]:= z;
            inc(i); dec(j);
        end;
    until i >= j;

    sort(c,le,j);
    sort(c,i,ri);
end;

procedure swap(var x,y: longint);
var
    z: longint;
begin
    z:= x; x:= y; y:= z;
end;

procedure downheap(i: longint);
var
    j: longint;
begin
    j:= i * 2;
    if (j > nheap) then exit;
    if (j < nheap) and (a[h[j]] + b[cur[h[j]]] > a[h[j+1]] + b[cur[h[j+1]]]) then inc(j);
    if (a[h[i]] + b[cur[h[i]]] > a[h[j]] + b[cur[h[j]]]) then
    begin
        swap(h[i],h[j]);
        downheap(j);
    end;
end;

procedure process;
var
    i,t: longint;
begin
    sort(a,1,m);
    sort(b,1,n);

    nheap:= m;
    for i:= 1 to m do h[i]:= i;
    for i:= 1 to m do cur[i]:= 1;

    while (k > 0) do
    begin
        writeln(fo,a[h[1]] + b[cur[h[1]]]);
        dec(k);

        inc(cur[h[1]]);
        if (cur[h[1]] > n) then
        begin
            h[1]:= h[nheap];
            dec(nheap);
        end;

        downheap(1);
    end;
end;

begin
    assign(fi,''); reset(fi);
    assign(fo,''); rewrite(fo);
    //
    input;
    process;
    //
    close(fi);
    close(fo);
end.
