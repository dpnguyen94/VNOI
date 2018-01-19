program bangso;
uses crt;

const MN = 30;
var     d:array[1..MN,1..MN] of integer;
        hang,cot,n : integer;

procedure Nhap;
begin
        readln(n);
end;

procedure Dienso;
var     z,t : integer;
        m : integer;
begin
        t := n div 2 + 1;
        m := 1;
        for  z:= 1 to (n div 2) do
        begin
             for cot := z to n-z do
             begin
                d[z,cot] := m; inc(m);
             end;
             for hang := z to n-z do
             begin
                d[hang,n-(z-1)] := m; inc(m);
             end;
             for cot:= n-(z-1) downto z+1 do
             begin
                d[n-(z-1),cot] := m; inc(m);
             end;
             for hang:= n-(z-1) downto z+1 do
             begin
                d[hang,z] := m; inc(m);
             end;
        end;
        if (n mod 2 = 1) then d[t,t] := m;
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
