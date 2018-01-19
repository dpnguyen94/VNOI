program cheat;
uses crt;
const MAX = 100000;
var     n,p: array[0..MAX] of longint;
        check: boolean;
        last,val,i,bi_a: longint;
        fi,fo: text;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        readln(fi,bi_a);
        //
        for i:= 1 to bi_a do begin
                n[i]:= i+1;
                p[i]:= i-1;
        end;

        last:= 0; check:= true;
        for i:= 1 to bi_a do begin
                readln(fi,val);
                if (val <> p[last]) and (val < last) then begin check:= false; break; end;
                n[p[val]]:= n[val];
                p[n[val]]:= p[val];
                last:= val;
        end;

        if (check) then writeln(fo,'NO')
        else writeln(fo,'YES');

        close(fo);
        close(fi);
end.
