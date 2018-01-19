program gcd_lcm;
uses crt;
var     a,b: longint;

function gcd(x,y: longint): longint;
begin
        if (x = 0) or (y = 0) then exit(x+y);
			
        //
        if (x > y) then gcd:= gcd(y, x mod y)
        else gcd:= gcd(x,y mod x);
end;

function lcm(x,y: longint): longint;
begin
        lcm:= (x*y) div gcd(x,y);
end;

begin
        clrscr;
        write('a='); readln(a);
        write('b='); readln(b);

        writeln('UCLN(',a,',',b,')=',gcd(a,b));
        writeln('BCNN(',a,',',b,')=',lcm(a,b));
        readln;
end.
