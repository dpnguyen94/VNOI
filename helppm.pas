uses math;
const
    LM = 501;
var
    fi,fo: text;
    fx: array[0..LM,0..LM] of longint;
    m,n,k: longint;
    b: array[0..LM+1] of longint;
    res: longint;


procedure input;
var i,j,c: longint;
begin
    readln(fi,m,n,k);
    for i:= 1 to m do
        for j:= 1 to n do
        begin
            read(fi,c);
            fx[i,j]:= fx[i,j-1] + c;
        end;
end;


procedure process;
var     i,j,i1,j1,i2,j2,i3,i4,res,res1,t,t1: longint;
begin
    res:= maxlongint;
    for i:= 1 to n do
        for j:= i to n do
        begin
            for t:= 1 to m do b[t]:= fx[t,j] - fx[t,i-1] + b[t-1];

            t1:= 1;
            res1:= maxlongint;
            for t:= 1 to m do
            begin
                while (t1 < m) and (b[t1] - b[t-1] < k) do inc(t1);

                if (b[t1] - b[t-1] >= k) and (t1-t+1 < res1) then
                begin
                    res1:= t1-t+1;
                    i3:= t;
                    i4:= t1;
                end;
            end;

            if (res1 < maxlongint) and (res1 * (j-i+1) < res) then
            begin
                res:= res1*(j-i+1);
                j1:= i; j2:= j;
                i1:= i3; i2:= i4;
            end;
        end;

    if (res = maxlongint) then
    begin
        writeln(fo,-1);
        exit;
    end;
    writeln(fo,res);
    writeln(fo,i1,' ',j1,' ',i2,' ',j2);
end;

begin
    assign(fi,''); reset(fi);
    assign(fo,''); rewrite(fo);

    input;
    process;

    close(fi);
    close(fo);
end.
