uses math;
const   MAX_N = 100000;
var
    fi,fo: text;
    tr,sau,a: array[0..MAX_N] of longint;
    n,m: longint;

procedure init;
var i: longint;
begin
    for i:= 1 to n do
    begin
        sau[i]:= i+1;
        tr[i]:= i-1;
    end;
    sau[n]:= -1;
end;


procedure process;
var   i,j,x: longint;
begin
    for i:= 1 to m do
    begin
        readln(fi,j,x);
        if (j = 0) then
        begin
            sau[tr[x]]:= sau[x];
            tr[sau[x]]:= tr[x];
        end
        else
        begin
            writeln(fo,sau[x]);
        end;
    end;
end;

begin
    assign(fi,'dayso.in'); reset(fi);
    assign(fo,'dayso.out'); rewrite(fo);
    //
    readln(fi,n,m);
    init;
    process;
    //
    close(fi);
    close(fo);
end.
