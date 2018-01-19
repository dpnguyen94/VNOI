uses math;
const   MAX_N = 100000;
        C = 1000000000;
var     fi,fo: text;
        a,sign: array[1..1000] of longint;
        p: array[0..MAX_N] of int64;
        n,time: longint;

procedure init;
var     i,j: longint;
begin
        j:= 1;
        for i:= 1 to n do begin
                if (i mod 2 = 1) then begin
                        a[i]:= j*(3*j-1) div 2;
                        j:= -j;
                end
                else begin
                        a[i]:= j*(3*j-1) div 2;
                        j:= (-j) + 1;
                end;
                if (a[i] > n) then break;
        end;
        //
        for j:= 1 to i do
         if (j mod 4 = 1) or (j mod 4 = 2) then sign[j]:= 1
         else sign[j]:= -1;
end;

procedure process;
var     i,j: longint;
begin
        p[0]:= 1;
        for i:= 1 to n do begin
                j:= 1;
                p[i]:= 0;
                while (i-a[j] >= 0) do begin
                        p[i]:= p[i]+p[i-a[j]]*sign[j];
                        inc(j);
                end;
                p[i]:= p[i] mod C;
                while (p[i] < 0) do p[i]:= p[i]+C;
        end;
end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        readln(fi,n);
        init;
        process;
        p[0]:= 0;
        writeln(fo,p[n]);
        //
        close(fi);
        close(fo);
end.
