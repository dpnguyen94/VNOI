program InsertionSort;
uses crt;
var     a: array[1..1000] of integer;
        n: integer;

procedure nhap;
var     i: integer;
begin
          readln(n);
          for i:= 1 to n do readln(a[i]);
end;


procedure InsSort;
var     i,j,tmp: integer;
begin
        for i:= 2 to n do
        begin
                tmp:= a[i];
                j:= i-1;
                while (j > 0) and (tmp < a[j]) do
                begin
                        a[j+1]:= a[j]; dec(j);
                end;
                a[j+1]:= tmp;
        end;
end;

procedure xuat;
var     i: integer;
begin
        for i:= 1 to n do write(a[i],' ');
end;

begin
        clrscr;
        nhap;InsSort;xuat;
        readln;
end.
