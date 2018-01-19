program xaynha;
uses crt;
var     fi,fo: text;
        n: int64;
        num_test,t: longint;

procedure process;
var     i,t1,t2: int64;
begin
        //i:= 1;
        i:= trunc(sqrt(trunc(2*sqrt(n))));
        while (sqr(i*(i+1) div 2) < n) do inc(i);
        t1:= sqr(i*(i+1) div 2) - n;
        if (t1 = 0) then begin
                writeln(fo,1,' ',i);
                exit;
        end;
        //
        dec(i);
        t2:= sqr(i*(i+1) div 2) - n;
        if (t1+t2 = 0) then writeln(fo,0,' ',t1,' ',i+1)
        else if (t1 < abs(t2)) then writeln(fo,0,' ',t1,' ',i+1)
                else writeln(fo,0,' ',t2,' ',i);
end;



begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        readln(fi,num_test);
        for t:= 1 to num_test do begin
                readln(fi,n);
                if (n = 0) then writeln(fo,0,' ',1,' ',1)
                else process;
        end;
        //
        close(fi);
        close(fo);
end.
