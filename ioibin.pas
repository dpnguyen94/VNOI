uses math;
const
     MAX_P = 50000;
     MAX_N = 10000;
var
    fi,fo: text;
    a: array[1..MAX_N] of longint;
    p: longint;

procedure init;
var i: longint;
begin
    for i:= 1 to MAX_N do a[i]:= i;
end;


function find(i: longint): longint;
begin
    if (a[i] <> a[a[i]]) then a[i]:= find(a[i]);
    exit(a[i]);
end;


procedure process;
var i,k,x,y: longint;
begin
    for i:= 1 to p do
    begin
        readln(fi,x,y,k);
        if (k = 1) then
        begin
            a[find(y)]:= find(x);
        end else
        begin
            if (find(x) = find(y)) then writeln(fo,1)
            else writeln(fo,0);
        end;
    end;
end;


begin
    assign(fi,''); reset(fi);
    assign(fo,''); rewrite(fo);
    //
    readln(fi,p);
    init;
    process;
    //
    close(fi);
    close(fo);
end.
