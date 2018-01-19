program tria;
uses crt;
const   fi = 'tria.inp';
        fo = 'tria.out';
        MN = 100;
var     a: array[1..100,1..100] of byte;
        s,p: array[1..MN,1..MN] of integer;
        n: integer;
        f: text;

procedure nhap;
var     i,j: integer;
begin
        assign(f,fi); reset(f);
        readln(f,n);
        for i:= 1 to n do
                for j:= 1 to i do read(f,a[i,j]);
        close(f);
end;

procedure QHD;
var     i,j: integer;
begin
        fillchar(s,sizeof(s),0);
        fillchar(p,sizeof(p),0);
        s[1,1]:= a[1,1];
        for i:= 2 to n do
        begin
                s[i,1]:= s[i-1,1] + a[i,1];
                p[i,1]:= 1;
                s[i,i]:= s[i-1,i-1] + a[i,i];
                p[i,i]:= i-1;
        end;


        for i:= 2 to n do
        for j:= 2 to i-1 do

        begin
                s[i,j]:= s[i-1,j] + a[i,j];
                p[i,j]:= j;
                if (s[i,j] < s[i-1,j-1] + a[i,j]) then
                begin
                        s[i,j]:= s[i-1,j-1] + a[i,j];
                        p[i,j]:= j-1;
                end;
        end;
end;



procedure xuat;
var     i,j,k,max: integer;
        c: array[1..100] of byte;
begin
        assign(f,fo); rewrite(f);
        max := -1;
        for i:= 1 to n do
                if s[n,i] > max then begin max := s[n,i]; k:= p[n,i]; end;

        writeln(f,max);

        j:= 1;
        while (n > 1) do
        begin
                c[j] := max - s[n-1,k]; inc(j);
                max := s[n-1,k];
                k := p[n-1,k];
                dec(n);
        end;
        c[j]:= a[1,1];

        for i:= j downto 1 do write(f,c[i],' ');
        close(f);
end;

begin
        nhap; QHD; xuat;
end.
