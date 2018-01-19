uses crt;
var     fi,fo: text;
        a,b: qword;

function odd_num(a,b: int64): int64;
begin
        if (a mod 2 = 0) then inc(a);
        if (b mod 2 = 0) then dec(b);
        //
        if (a > b) then exit(0);
        exit((b-a) div 2 +1);
end;

procedure process;
var     x: int64;
        res,t: qword;
        i: integer;
begin
        res:= 0;
        i:= 0;
        while (1 shl i <= b) do begin
                t:= 1 shl i;

                x:= a div t;
                if (x*t <> a) then inc(x);

                inc(res,t*odd_num(x,b div t));
                //
                inc(i);
        end;
        //
        writeln(fo,res);
end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        readln(fi,a,b);
        process;
        //
        close(fi);
        close(fo);
end.
