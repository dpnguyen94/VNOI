program nkrez;
uses crt;
var     a,b,c: array[1..10000] of integer;
        s: array[1..10000] of longint;
        n: integer;
        fi,fo: text;

procedure input;
var     i: integer;
begin
        readln(fi,n);
        for i:= 1 to n do begin
                readln(fi,a[i],b[i]);
                c[i]:= b[i]-a[i];
        end;
end;


procedure sort(l,r: integer);
var     i,j,z,t1,t2: integer;
begin
        if (l >= r) then exit;
        i:= l; j:= r;
        t1:= a[(l+r) div 2];
        t2:= b[(l+r) div 2];

        repeat
                while (a[i] < t1) or ((a[i] = t1) and (b[i] < t2)) do inc(i);
                while (a[j] > t1) or ((a[j] = t1) and (b[j] > t2)) do dec(j);

                if i <= j then begin
                        if i < j then begin
                                z:= a[i]; a[i]:= a[j]; a[j]:= z;
                                z:= b[i]; b[i]:= b[j]; b[j]:= z;
                                z:= c[i]; c[i]:= c[j]; c[j]:= z;
                        end;
                        inc(i); dec(j);
                end;
        until i >= j;
        //
        sort(l,j);
        sort(i,r);
end;

procedure optimize;
var     i,j: integer;
        max1,max2: longint;
begin
        sort(1,n);
        s[1]:= c[1];

        max2:= s[1];
        for i:= 2 to n do begin
                s[i]:= c[i];
                max1:= 0;
                for j:= 1 to i-1 do
                 if (a[i] >= b[j]) and (s[j] > max1) then max1:= s[j];
                inc(s[i],max1);
                if (s[i] > max2) then max2:= s[i];
        end;
        //
        writeln(fo,max2);
end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        input;
        optimize;
        //
        close(fi);
        close(fo);
end.
