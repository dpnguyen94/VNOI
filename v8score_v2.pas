program v8score_v2;
uses crt;
var     fi,fo: text;
        a: array[1..20,1..20] of int64;

procedure input;
var
begin
        readln(fi,s,k,n);
        for i:= 1 to n do begin
                for j:= 1 to k read(fi,a[i,j]);
                readln(fi);
        end;
end;

procedure process;
var
begin

end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        input;
        //
        close(fi);
        close(fo);
end.