uses math;
var
    fi,fo: text;
    a,b,c: int64;
    n,p: longint;
    d: array[0..1000000] of boolean;
    next: array[1..1000000] of longint;
    s: string;

procedure init;
var     i: longint;
begin
    fillchar(d,sizeof(d),false);
    for i:= 0 to n-1 do next[i]:= i;
end;


function find(x: int64): longint;
begin
    if (next[x] <> next[next[x]]) then next[x]:= find(next[x]);
end;


procedure process;
var     i,k,j,t: longint;
        res: int64;
begin
    for i:= 0 to p-1 do
    begin
        t:= (a*i*i+b*i+c) mod n;

        k:= find(t);
        d[k]:= true;

        next[k]:= (k+1) mod n;
    end;

    //
    res:= 0;
    j:= n div 2;
    for i:= 0 to j-1 do
        if (d[i]) and (d[(i+j) mod n]) then
        begin
            inc(res,p-2);
        end;

    //
    writeln(fo,res);
end;


begin
    assign(fi,''); reset(fi);
    assign(fo,''); rewrite(fo);

    while TRUE do
    begin
        readln(fi,s);
        if (s = '[END]') then break;
        readln(fi,n);
        readln(fi,p);
        readln(fi,a);
        readln(fi,b);
        readln(fi,c);
        readln(fi);

        if (n mod 2 = 1) then
        begin
            writeln(fo,0);
            continue;
        end;
        //
        init;
        process;
    end;

    close(fi);
    close(fo);
end.
