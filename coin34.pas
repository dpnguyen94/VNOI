uses math;
const
    maxV = 370000;
    maxN = 20000;
//type

var
    fi,fo: text;
    n,ntest,test,res,cnt: longint;
    a,b: array[1..34] of longint;

    f: array[0..maxV] of longint;
    val,fv: array[0..maxN] of longint;

procedure input;
var
    i: longint;
begin
    a[1]:= 2;
    a[2]:= 3;
    a[3]:= 5;
    for i:= 4 to 34 do
    begin
        a[i]:= a[i-1] + a[i-2] + a[i-3];
    end;
end;

procedure solve1;
var
    i,s,sum: longint;
begin
    sum:= 0; s:= 0;
    for i:= 1 to 20 do
        if (b[i] = 1) then
        begin
            inc(sum,a[i]);
            inc(s);
        end;

    //
    if (s > f[sum]) then f[sum]:= s;
end;

procedure attempt1(i: longint);
var
    j: longint;
begin
    if (i > 20) then
    begin
        solve1;
        exit;
    end;

    //
    for j:= 0 to 1 do
    begin
        b[i]:= j;
        attempt1(i+1);
    end;
end;

procedure solve2;
var
    s,sum,i: longint;
begin
    sum:= 0; s:= 0;
    for i:= 1 to 14 do
        if (b[i] = 1) then
        begin
            inc(sum,a[i+20]);
            inc(s);
        end;

    if (s = 0) then exit;

    inc(cnt);
    val[cnt]:= sum;
    fv[cnt]:= s;
end;

procedure attempt2(i: longint);
var
    j: longint;
begin
    if (i > 14) then
    begin
        solve2;
        exit;
    end;

    //
    for j:= 0 to 1 do
    begin
        b[i]:= j;
        attempt2(i+1);
    end;
end;

procedure sort(le,ri: longint);
var
    i,j,z,t: longint;
begin
    if (le >= ri) then exit;
    i:= le; j:= ri;
    t:= val[(i+j) div 2];

    repeat
        while (val[i] < t) do inc(i);
        while (val[j] > t) do dec(j);

        if (i <= j) then
        begin
            z:= val[i]; val[i]:= val[j]; val[j]:= z;
            z:= fv[i]; fv[i]:= fv[j]; fv[j]:= z;
            inc(i); dec(j);
        end;

    until i > j;

    sort(le,j);
    sort(i,ri);
end;

procedure solve;
begin
    attempt1(1);

    cnt:= 0;
    attempt2(1);
    sort(1,cnt);
end;

procedure process;
var
    i,t,k,res: longint;
begin
    res:= -1;
    if (n < maxV) then
        if (f[n] > 0) and (f[n] > res) then res:= f[n];

    for i:= 1 to cnt do
    begin
        if (n < val[i]) then break;
        if (n = val[i]) then
        begin
            if (fv[n] > res) then res:= fv[n];
            continue;
        end;

        t:= n - val[i];
        if (t <= maxV) then
        begin
            if (f[t] = 0) then break;

            k:= f[t] + fv[i];
            if (k > res) then res:= k;
        end;
    end;

    writeln(fo,res);
end;

begin
    assign(fi,''); reset(fi);
    assign(fo,''); rewrite(fo);
    //
    input;
    solve;
    //
    readln(fi,ntest);
    for test:= 1 to ntest do
    begin
        readln(fi,n);
        write(fo,'Case #',test,': ');
        process;
    end;
    //
    close(fi);
    close(fo);
end.
