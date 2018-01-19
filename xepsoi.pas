program xepsoi;
uses crt;

var     n,p: integer;
        a: array[1..200] of integer;
        c: array[1..1000] of integer;

procedure Nhap;
var     i: integer;
begin
        readln(n);
        for i:= 1 to n do
        begin write('a[',i,']='); readln(a[i]); end;
        readln(p);
        for i:= 1 to p do
        begin write('c[',i,']='); readln(c[i]); end;
end;

procedure xepsoi;
var     i,t,sohieu: integer;
begin
        for i:= p downto 1 do
        begin
                sohieu:= c[i];
                t:= 0;
                while (a[sohieu] > 0) do
                begin
                        dec(a[sohieu]);inc(t);
                        dec(sohieu);
                        if sohieu = 0 then sohieu:= n;
                end;
                a[sohieu]:=t;
        end;
end;

procedure Xuat;
var     i: integer;
begin
        for i:= 1 to n do
        write(a[i],' ');
end;

begin
        clrscr;
        nhap;xepsoi;xuat;
        readln;
end.