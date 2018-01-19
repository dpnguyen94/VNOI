program quicksort;
uses crt;
var     a: array[1..1000] of longint;
        n: integer;

procedure nhap;
var     i: integer;
begin
        readln(n);
        for i:= 1 to n do
        readln(a[i]);
end;

procedure qsort(l,r: integer);
var     i,j: integer;
        z,t: longint;
begin
        if l>=r then exit;
        i:= l; j:=r;
        t:= a[(l+r) div 2];
        repeat
                while (a[i] < t) do inc(i);
                while (a[j] > t) do dec(j);

                if i <= j then
                begin
                        if i < j then begin
                                z:= a[i]; a[i]:= a[j]; a[j]:= z;
                        end;
                        inc(i);dec(j);
                end;
        until i > j;

        qsort(l,j);
        qsort(i,r);
end;

procedure xuat;
var     i: integer;
begin
        for i:= 1 to n do write(a[i],' ');
end;


begin
        clrscr;
        nhap; qsort(1,n);xuat;
        readln;
end.
