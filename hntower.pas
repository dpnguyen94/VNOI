program hanoitower;
uses crt;
var    t, n: integer;

procedure hn(n,a,b: byte);
begin
        if n=0 then exit;
        hn(n-1, a, 6-a-b);
        writeln(a,' -> ',b);
        hn(n-1, 6-a-b, b);
end;

begin
        clrscr;
        readln(n);
        hn(n,1,2);
        readln;
end.

























































































































































































































































































































































































































































































