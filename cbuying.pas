program cbuying;
uses crt;
const   MAX_N = 100000;
var     fi,fo: text;
        p,c: array[1..MAX_N] of int64;
        n: longint;
        b: int64;

procedure input;
var     i: longint;
begin
        readln(fi,n,b);
        for i:= 1 to n do readln(fi,p[i],c[i]);
end;

procedure qsort(L,R: longint);
var     i,j: longint;
        z,t: int64;
begin
        if L>=R then exit;
        i:= L; j:=R;
        t:= p[(L+R) div 2];
        repeat
                while (p[i] < t) do inc(i);
                while (p[j] > t) do dec(j);

                if i <= j then
                begin
                        if i < j then begin
                                z:= p[i]; p[i]:= p[j]; p[j]:= z;
                                z:= c[i]; c[i]:= c[j]; c[j]:= z;
                        end;
                        inc(i);dec(j);
                end;
        until i>j;

        qsort(L,j);
        qsort(i,R);
end;

procedure process;
var     i: longint;
        j,cow: int64;
begin
        cow:= 0;
        i:= 1;

        while i<=n do begin
                if (b < p[i]) then break;
                j:= b div p[i];
                //
                if (j > c[i]) then j:= c[i];
                inc(cow,j);
                dec(b,p[i]*j);
                //
                inc(i);
        end;

        writeln(fo,cow);
end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        input;
        qsort(1,n);
        process;
        //
        close(fi);
        close(fo);
end.
