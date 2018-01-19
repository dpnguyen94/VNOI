program binary;
uses crt;
var     fi,fo: text;
        n,cnt1,cnt2: int64;
        k: longint;
        a: array[0..31] of integer;
        c: array[0..31,0..31] of int64;

procedure init;
var     i,j: integer;
begin
        c[0,0]:= 1;
        for i:= 1 to 31 do begin
                c[0,i]:= 1; c[i,i]:= 1;
                for j:= 1 to i-1 do c[j,i]:= c[j-1,i-1]+c[j,i-1];
        end;
end;

procedure process;
var     i,t,len,cnt,j: longint ;
        res1,res2: int64;
begin
        a[0]:= 0;
        t:= n;
        while (t > 0) do begin
                inc(a[0]);
                a[a[0]]:= t mod 2;
                t:= t div 2;
        end;
        //
        res1:= 0;
        for i:= k+1 to a[0] do inc(res1,c[k,i-1]);
        //
        cnt:= 0;
        for i:= 1 to a[0] do
         if (a[i] = 0) then inc(cnt);
        //
        t:= 0;
        res2:= 0;
        for i:= 1 to a[0] do begin
                if (a[i] = 0) then begin
                        inc(t);
                        j:= k-(cnt-t);
                        if (j < 0) or (j > 31) then continue;
                        inc(res2,c[j,i-1]);
                end;
        end;
        if (k = 1) then writeln(fo,res1-res2+1)
        else writeln(fo,res1-res2);
end;


begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        init;
        //
        while not eof(fi) do begin
                readln(fi,n,k);
                process;
        end;
        //
        close(fi);
        close(fo);
end.
