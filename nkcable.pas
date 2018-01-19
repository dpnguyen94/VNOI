program nkcable;
uses crt;
const   MAX_N = 25000;
var     n: integer;
        l,d: array[0..MAX_N] of int64;
        fi,fo: text;

procedure enter;
var     i: integer;
begin
        readln(fi,n);
        for i:= 1 to n-1 do readln(fi,l[i]);
end;

function min(x,y: int64): int64;
begin
        if x<y then exit(x)
        else exit(y);
end;

procedure process;
var     i: integer;
begin
        d[1]:= l[1]; d[2]:= l[1];
        for i:= 3 to n do d[i]:= l[i-1]+min(d[i-1],d[i-2]);
        //
        writeln(fo,d[n]);
end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        enter;
        process;
        //
        close(fi);
        close(fo);

end.
