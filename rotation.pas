program rotation;
uses crt;
const   fi = '';
        fo = '';
var     a,b: array[1..1000] of 0..1;
        n: integer;
        f: text;

procedure nhap;
var     i,x,y,z: integer;
begin
        assign(f,fi); reset(f);
        readln(f,n);
        for i:= 1 to n-1 do begin
                readln(f,x,y,z);
                b[x]:= z;
        end;
        close(f);
end;

procedure xuli;
var     i: integer;
begin
        for i:= 2 to n do
                if (b[i-1] = 0) then a[i]:= a[i-1]
                else
                        if (a[i-1] = 0) then a[i]:= 1
                        else a[i]:= 0;
        assign(f,fo); rewrite(f);
        writeln(f,a[n]);
        close(f);
end;

begin
        nhap;
        xuli;
end.