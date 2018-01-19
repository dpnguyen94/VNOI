{
ID: ndchiph1
PROG: dualpal
LANG: PASCAL
}
program dualpal;
uses crt;
var     fi,fo: text;
        a,res: array[0..15] of integer;
        n,s: integer;

function ispalin(s,base: integer): boolean;
var     i: integer;
begin
        a[0]:= 0;
        while (s > 0) do begin
                inc(a[0]);
                a[a[0]]:= s mod base;
                s:= s div base;
        end;
        //
        for i:= 1 to (a[0] div 2) do
         if a[i] <> a[a[0]-i+1] then exit(false);
        //
        exit(true);
end;

procedure process;
var     k,cnt,i: integer;
begin
        inc(s);
        k:= 1;
        while (k <= n) do begin
                cnt:= 0;
                for i:= 2 to 10 do begin
                        if ispalin(s,i) then inc(cnt);
                        if (cnt = 2) then begin
                                res[k]:= s;
                                break;
                        end;
                end;
                if (cnt = 2) then begin
                        inc(k);
                        inc(s);
                end
                else inc(s);
        end;
end;

procedure output;
var     i: integer;
begin
        for i:= 1 to n do writeln(fo,res[i]);
end;


begin
        assign(fi,'dualpal.in'); reset(fi);
        assign(fo,'dualpal.out'); rewrite(fo);
        //
        readln(fi,n,s);
        process;
        output;
        //
        close(fi);
        close(fo);
end.
