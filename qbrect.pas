uses math;
const
    LM = 1000;
var
    fi,fo: text;
    n,m: longint;
    a: array[1..LM,1..LM] of longint;
    h: array[0..LM] of Longint;
    le,ri: array[0..LM] of longint;
    res: longint;


procedure input;
var i,j: longint;
begin
    readln(fi,m,n);
    for i:= 1 to m do
    begin
        for j:= 1 to n do read(fi,a[i,j]);
        readln(fi);
    end;
end;


procedure solve;
var i,j,area,t: longint;
begin

    for i:= 1 to n do
    begin
        le[i]:= i-1;
        j:= i-1;

        while (j >= 1) and (h[j] >= h[i]) do j:= le[j];
        le[i]:= j;
    end;

    for i:= n downto 1 do
    begin
        ri[i]:= i+1;
        j:= i+1;

        while (j <= n) and (h[j] >= h[i]) do j:= ri[j];
        ri[i]:= j;
    end;

    //
    area:= 0;
    for i:= 1 to n do
    begin
        t:= h[i] * (ri[i]-le[i]-1);
        if (t > area) then area:= t;
    end;

    //
    if (area > res) then res:= area;
end;


procedure process;
var i,j: longint;
begin
    fillchar(h,sizeof(h),0);
    res:= 0;
    for i:= 1 to m do
    begin
        for j:= 1 to n do
            if a[i,j] = 0 then h[j]:= 0
            else inc(h[j]);

        //
    	solve;
    end;

    writeln(fo,res);
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
