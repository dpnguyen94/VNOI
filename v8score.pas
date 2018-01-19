program v8score;
uses crt;
const   fi = '';
        fo = '';
var     a: array[1..20,1..20] of longint;
        b: array[0..20] of longint;
        f: text;
        s,k,n: integer;


procedure nhap;
var     i,j: integer;
begin
        assign(f,fi); reset(f);
        readln(f,s,k,n);
        for i:= 1 to n do begin
                for j:= 1 to k do read(f,a[i,j]);
                readln(f);
        end;
        close(f);
end;

procedure print;
var     i: integer;
begin
        assign(f,fo); rewrite(f);
        writeln(f,'YES');
        for i:= 1 to k do write(f,b[i],' ');
        writeln(f);
        close(f);
        halt;
end;

procedure attempt(j: integer; sum: longint);
var     i: integer;
begin
        if (j > k) then
         if (sum = s) then print
         else exit;
        //
        for i:= 1 to n do
         if (a[i,j] >= b[j-1]) and (sum + a[i,j] <= s) and ((k-j) * a[i,j] <= s-sum-a[i,j]) then begin
                b[j]:= a[i,j];
                attempt(j+1,sum+b[j]);
         end;
end;

begin
        nhap;
        //
        b[0]:= -maxlongint;
        //
        attempt(1,0);
        //
        assign(f,fo); rewrite(f);
        writeln(f,'NO');
        close(f);
end.
