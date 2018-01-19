program dtdoi;
uses crt;
const   MAX_S = 9999;
        MAX_N = 100;
var     fi,fo: text;
        n: integer;
        s: longint;
        a: array[1..MAX_N] of integer;
        f: array[0..MAX_S] of integer;

procedure input;
var     i: integer;
begin
        readln(fi,n,s);
        for i:= 1 to n do read(fi,a[i]);
end;

procedure dp;
var     i: longint;
        j: integer;
begin
        fillchar(f,sizeof(f),0);
        //
        for i:= 1 to MAX_S do
         for j:= 1 to n do
          if a[j] <= i then
           if (f[i] = 0) or (f[i-a[j]]+ 1 < f[i]) then f[i]:= f[i-a[j]]+ 1;
end;

procedure greedy;
var     i,max: integer;
        j: longint;
begin
        if (s < 10000) then writeln(fo,f[s])
        else begin
                max:= 0;
                for i:= 1 to n do
                		if a[i] > max then max:= a[i];

                if (s <= 10100) then begin
                        j:= 0;
                        while (s >= 10000) do begin
                                dec(s,max);
                                inc(j);
                        end;
                        writeln(fo,j+f[s]);
                end
                else begin
                        j:= (s-10100) div max;
                        dec(s,j*max);
                        while (s >= 10000) do begin
                                inc(j);
                                dec(s,max);
                        end;
                        writeln(fo,j+f[s]);
                end;

        end;
end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        input;
        dp;
        greedy;
        //
        close(fi);
        close(fo);
end.

