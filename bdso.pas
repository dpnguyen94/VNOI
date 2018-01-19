program bieudienso;
uses crt;
var
       PT,BD: array[0..30000] of byte;
       a: array[1..1000] of integer;
       n,s: integer;

procedure nhap;
var     i: integer;
begin
        write('n='); readln(n);
        for i:= 1 to n do
        begin
        write('a[',i,']='); readln(a[i]);
        end;
        write('s='); readln(s);
end;


procedure bieudien;
var
        i,j,w: integer;
begin
        w:= 0; BD[w]:= 1; PT[w]:= 0;
        for i:= 1 to n do
        begin
                for j:= w downto 0 do
                if (BD[j] = 1) and (PT[j+a[i]] = 0) then
                begin
                        BD[j+a[i]]:= 1; PT[j+a[i]]:= i;
                end;
                inc(w,a[i]);
                if (PT[s] <> 0) then exit;
        end;
end;


procedure xuat;
var     k,i,j: integer;
begin
        if PT[s] = 0 then begin writeln(0); exit; end;
        k:= 0; j:= s;
        repeat
                i:= PT[j];
                inc(k); BD[k]:= i;
                dec(j,a[i]);
        until j = 0;
        writeln(k);
        for i:= k downto 1 do
        write(a[BD[i]],' ');
end;

begin
        clrscr;
        nhap; bieudien; xuat;
        readln;
end.
