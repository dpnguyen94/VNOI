program minmax;
uses crt;
var     a: longint;
        n,k: integer;
        b,d: array[1..1000] of shortint;

function max(i,j: integer): integer;
var     t,tmp,m: integer;
begin
        if i = j then begin max:= i; exit; end;
        tmp:= d[i]; m:=i;
        for t:= i-1 downto j do
                if d[t] > tmp then begin tmp:= d[t]; m:=t; end;
        max:= m;
end;

function min(i,j: integer): integer;
var     t,tmp,m: integer;
begin
        if i = j then begin min:= i; exit; end;
        tmp:= d[i]; m:=i;
        for t:= i-1 downto j do
                if d[t] < tmp then begin tmp:= d[t]; m:=t; end;
        min:= m;
end;


procedure nhap;
var     i: integer;
begin
        write('n='); readln(n);
        write('a='); readln(a);
        write('k='); readln(k);

        i:= 1;
        while (a > 0) do
        begin
                d[i]:= a mod 10;
                a:= a div 10;
                inc(i);
        end;
end;


procedure timmax;
var     k1,n1,i,j: integer;
begin
        n1:= n; k1:= n1-k;
        i:= 1;
        while (k1 > 0) do
        begin
                b[i]:= max(n1,k1);
                n1:= max(n1,k1)-1;
                dec(k1); inc(i);
        end;
end;

procedure timmin;
var     k2,n2,i,j: integer;
begin
        n2:= n; k2:= n2-k;
        i:= 1;
        while (k2 > 0) do
        begin
                b[i]:= min(n2,k2);
                n2:= min(n2,k2)-1;
                dec(k2); inc(i);
        end;
end;


procedure xuatmax;
var     i: integer;
begin
        for i:= 1 to (n-k) do write(d[b[i]]);
end;

procedure xuatmin;
var     i,j: integer;
begin
        for i:= 1 to (n-k) do
                if d[b[i]] <> 0 then begin for j:= i to (n-k) do write(d[b[i]]); exit; end;
        write(0);
end;

begin
        clrscr;
        nhap;
        timmax; xuatmax;
        writeln;
        timmin; xuatmin;
        readln;
end.
