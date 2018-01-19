program mkflags;
uses crt;
var     fi,fo: text;
        n: integer;

procedure fill(i: integer);
var     a: array[1..50,1..50] of integer;
        t,j,k: integer;
begin
        t:= 1;
        for j:= 1 to i do begin
                for k:= j to i do begin
                        a[j,k]:= t;
                        a[k+1,j]:= t;
                        inc(t);
                end;
        end;
        for j:= 1 to i+1 do begin
                for k:= 1 to i do write(fo,a[j,k],' ');
                writeln(fo);
        end;
end;

procedure process;
var     t: integer;
begin
        t:= round(sqrt(2*n));
        if (t*(t+1) = 2*n) then begin
                writeln(fo,t+1);
                fill(t);
        end
        else if (2*n > t*(t-1)) and (2*n < t*(t+1)) then begin
                writeln(fo,t);
                fill(t-1);
        end;

end;


begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        readln(fi,n);
        if (n = 1) then begin
                writeln(fo,1);
                writeln(fo,1,' ',1)
        end
        else process;
        //
        close(fi);
        close(fo);
end.
