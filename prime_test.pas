const   MAX = 1000000;
var     p: array[0..MAX] of boolean;
        a: array[1..500000] of int64;
        i,j,k,sum: longint;
        fo: text;

begin
        fillchar(p,sizeof(p),true);
        p[0]:= false; p[1]:= false;

        for i:= 2 to MAX do
         if (p[i]) then begin
                j:= i;
                while (j+i <= MAX) do begin
                        inc(j,i);
                        p[j]:= false;
                end;
         end;
        //
        assign(fo,'prime.out'); rewrite(fo);
        k:= 1;
        for i:= 0 to MAX do begin
                if p[i] then begin a[k]:= i; inc(k); end;
        end;
        for i:= 1 to k-1 do begin
                if (i mod 20 = 0) then writeln(fo);
                write(fo,a[i],',');
        end;
        writeln(fo,k-1);
        close(fo);
end.
