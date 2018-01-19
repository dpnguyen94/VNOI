program qbstr;
uses crt;
const   M = 10000;
var     a,b: ansistring;
        c: array[0..M,0..M] of integer;

procedure enter;
begin
        readln(a);
        readln(b);
end;

function max(x,y: integer): integer;
begin
        if x>y then max:= x
        else max:= y;
end;

procedure optimize;
var     i,j,m,n: integer;
begin
        m:= length(a);
        n:= length(b);
        for i:= 0 to m do c[i,0]:= 0;
        for i:= 0 to n do c[0,i]:= 0;
        for i:= 1 to m do
         for j:= 1 to n do begin
                if a[i] = b[j] then c[i,j]:= c[i-1,j-1]+1
                else c[i,j]:= max(c[i-1,j],c[i,j-1]);
         end;
        //
        writeln(c[i,j]);
end;

begin
        enter;
        optimize;
end.
