uses math;
const
    maxN = 100010;
    C = 1000000007;
var
    fi,fo: text;
    long,a,f,head,s: array[0..maxN] of longint;
    id: array[1..maxN] of longint;
    n,k: longint;


procedure input;
var i: longint;
begin
    readln(fi,n);
    for i:= 1 to n do read(fi,a[i]);
end;


procedure process1;
var     i,j,le,ri,mid,res: longint;
begin
    a[0]:= -maxlongint;

    k:= 0;
    for i:= 1 to n do
    begin
        le:= 0; ri:= k;
        while (le <= ri) do
        begin
            mid:= (le+ri) div 2;
            if (a[f[mid]] < a[i]) then
            begin
                le:= mid + 1;
                res:= mid;
            end else ri:= mid-1;
        end;
        f[res+1]:= i;
        long[i]:= res+1;

        if (res + 1 > k) then k:= res + 1;
    end;

    for i:= 1 to n do id[i]:= i;
end;

procedure swap(var x,y: longint);
var z: longint;
begin
    z:= x; x:= y; y:= z;
end;

procedure sort(le,ri: longint);
var i,j,k,t,t1: longint;
begin
    if (le >= ri) then exit;
    i:= le; j:= ri;
    k:= (i+j) div 2;
    t:= long[k];
    t1:= id[k];

    repeat
        while (long[i] < t) or ( (long[i] = t) and (id[i] < t1) ) do inc(i);
        while (long[j] > t) or ( (long[j] = t) and (id[j] > t1) ) do dec(j);

        if (i <= j) then
        begin
            swap(long[i],long[j]);
            swap(id[i],id[j]);
            swap(a[i],a[j]);
            inc(i); dec(j);
        end;

    until i > j;

    sort(le,j);
    sort(i,ri);
end;

procedure process2;
var     i,j,sum,t1,t2: longint;
begin
    long[0]:= 0;
    for i:= 1 to n do
        if (long[i] <> long[i-1]) then head[long[i]]:= i;
    head[k+1]:= n+1;

    for i:= head[1] to head[2]-1 do s[i]:= 1;

    for i:= 2 to k do
    begin
        t1:= head[i-1]; t2:= head[i-1];
        sum:= s[head[i-1]];
        for j:= head[i] to head[i+1]-1 do
        begin
            while (t1 < head[i]-1) and (a[t1] >= a[j]) do
            begin
                sum:= (sum + C - s[t1]) mod C;
                inc(t1);
            end;
            while (t2 < head[i]-1) and (id[t2+1] < id[j]) do
            begin
                inc(t2);
                sum:= (sum + s[t2]) mod C;
            end;
            s[j]:= sum;
        end;
    end;

    sum:= 0;
    for i:= head[k] to head[k+1]-1 do sum:= (sum + s[i]) mod C;
    writeln(fo,sum);
end;


begin
    assign(fi,''); reset(fi);
    assign(fo,''); rewrite(fo);
	//
    input;
    process1;
    sort(1,n);
    process2;
	//
    close(fi);
    close(fo);
end.
