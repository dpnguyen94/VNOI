program ziczac;
uses crt;
const MN = 100;
var     d:array[1..MN,1..MN] of integer;
        n,i,j : integer;

procedure Nhap;
begin
        readln(n);
end;


procedure Dienso;
var     m,z,t : integer;
begin
        d[1,1] := 1; d[n,n] := sqr(n);
        m := 2;
        for t:= 2 to n do
        begin
                z := t+1;
                if (t mod 2 = 0) then
                begin
                        for i:= 1 to z-1 do
                        begin
                                j:= z-i; d[i,j]:= m; inc(m);
                        end;
                end
                else
                begin
                        for j:=1 to z-1 do
                        begin
                                i:= z-j; d[i,j]:= m; inc(m);
                        end;
                end;
        end;
        for t:= n+1 to 2*(n+1) - 4 do
        begin
                z := t+1;
                if (t mod 2 <> 0) then
                begin
                        for i:= n downto z-n do
                        begin
                                j:= z-i; d[i,j]:= m; inc(m);
                        end;
                end
                else
                begin
                        for j:= n downto z-n do
                        begin
                                i:= z-j; d[i,j]:= m; inc(m);
                        end;
                end;
        end;
end;


procedure Xuat;
var     a,b : integer;
begin
        for a:= 1 to n do
        begin
                for b:= 1 to n do
                write(d[a,b] : 4);
                writeln;
        end;
end;



begin
        clrscr;
        Nhap; Dienso; Xuat;
        readln;
end.
