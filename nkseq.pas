program nkseq;
uses crt;
const   MAX_N = 100000;
var     a,s,l,r: array[0..MAX_N+1] of int64;
        n: longint;
        fi,fo: text;

procedure input;
var     i: longint;
begin
        readln(fi,n);
        for i:= 1 to n do read(fi,a[i]);
end;

procedure process;
var     i: longint;
        cnt,t,min: int64;
begin
        //init;
        a[0]:= 0; a[n+1]:= 0;

        t:= a[n];
        for i:= n downto 1 do begin
                s[i]:= t;
                inc(t,a[i-1]);
        end;

        r[n]:= a[n];
        for i:= n-1 downto 1 do begin
                if (a[i] < a[i]+r[i+1]) then r[i]:= a[i]
                else r[i]:= a[i]+r[i+1];
        end;

        t:= a[1]; min:= a[1];
        for i:= 1 to n do begin
                l[i]:= min;
                inc(t,a[i+1]);
                if (t < min) then min:= t;
        end;
        l[0]:= 0;

        //count;
        cnt:= 0;
        for i:= 1 to n do
         if (r[i] > 0) and (s[i]+l[i-1] > 0) then inc(cnt);

        //
        writeln(fo,cnt);
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