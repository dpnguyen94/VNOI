program lqdrect;
uses crt;
var     a: array[1..1000,1..300] of 0..1;
        m,n: integer;
        fi,fo: text;

procedure input;
var     i,j: integer;
begin
        readln(fi,m,n);
        for i:= 1 to m do begin
                for j:= 1 to n do read(fi,a[i,j]);
                readln(fi);
        end;
end;

procedure process;
var     res,cnt: int64;
        i,j,k: integer;
begin
        res:= 0;
        for i:= 1 to n-1 do
         for j:= i+1 to n do begin
                cnt:= 0;
                for k:= 1 to m do cnt:= cnt + (a[k,i] and a[k,j]);
                res:= res + cnt*(cnt-1) div 2;
         end;
        //
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
