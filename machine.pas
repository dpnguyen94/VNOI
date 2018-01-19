program machine;
uses crt;
const   MAX_N = 10000;
var     fi,fo: text;
        a,b,a1,b1,c,n1,n2: array[1..MAX_N] of integer;
        n,x,y: integer;

procedure input;
var     i: integer;
begin
        readln(fi,n);
        for i:= 1 to n do read(fi,a1[i]);
        readln(fi);
        for i:= 1 to n do read(fi,b1[i]);
        readln(fi);
        for i:= 1 to n do read(fi,c[i]);
        //init;
        for i:= 1 to n do begin
                a[i]:= a1[i]+b1[i];
                b[i]:= b1[i]+c[i];
        end;
end;

procedure init;
var     k: integer;
begin
        x:= 0; y:= 0;
        for k:= 1 to n do
         if (a[k] <= b[k]) then begin
                inc(x);
                n1[x]:= k;
         end
         else begin
                inc(y);
                n2[y]:= k;
         end;
end;

procedure sort_n1(l,r: integer);
var     i,j,t,z: integer;
begin
        if (l >= r) then exit;
        i:= l; j:= r;
        t:= a[n1[(l+r) div 2]];

        repeat
                while (a[n1[i]] < t) do inc(i);
                while (a[n1[j]] > t) do dec(j);

                if i <= j then begin
                        if i < j then begin
                                z:= n1[i]; n1[i]:= n1[j]; n1[j]:= z;
                        end;
                        inc(i); dec(j);
                end;

        until i > j;

        //
        sort_n1(l,j);
        sort_n1(i,r);
end;

procedure sort_n2(l,r: integer);
var     i,j,t,z: integer;
begin
        if (l >= r) then exit;
        i:= l; j:= r;
        t:= b[n2[(l+r) div 2]];

        repeat
                while (b[n2[i]] > t) do inc(i);
                while (b[n2[j]] < t) do dec(j);

                if i <= j then begin
                        if i < j then begin
                                z:= n2[i]; n2[i]:= n2[j]; n2[j]:= z;
                        end;
                        inc(i); dec(j);
                end;

        until i > j;

        //
        sort_n2(l,j);
        sort_n2(i,r);
end;


procedure process;
var     k: integer;
        sa,sb,sc: longint;
        tt: array[1..MAX_N] of integer;
begin
        sort_n1(1,x);
        sort_n2(1,y);
        //
        for k:= 1 to x do tt[k]:= n1[k];
        for k:= 1 to y do tt[x+k]:= n2[k];
        //
        {
        sa:= a[tt[1]];
        sb:= sa+b[tt[1]];
        for k:= 2 to n do begin
                inc(sa,a[tt[k]]);
                if (sa >= sb) then sb:= sa+b[tt[k]]
                else sb:= sb+b[tt[k]];
        end;
        writeln(fo,sb);
        for k:= 1 to n-1 do write(fo,tt[k],' ');
        write(fo,tt[n]);
        }
        sa:= a1[tt[1]];
        sb:= sa+b1[tt[1]];
        sc:= sb+c[tt[1]];
        for k:= 2 to n do begin
                inc(sa,a1[tt[k]]);
                if (sa >= sb) then sb:= sa+b1[tt[k]]
                else sb:= sb+b1[tt[k]];
                if (sb >= sc) then sc:= sb+c[tt[k]]
                else sc:= sc+c[tt[k]];
        end;
        writeln(fo,sc);
        for k:= 1 to n-1 do write(fo,tt[k],' ');
        write(fo,tt[n]);
end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        input;
        init;
        process;
        //
        close(fi);
        close(fo);
end.
