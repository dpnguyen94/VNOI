program nknumfre;
uses crt;
var     a,b,i,cnt: longint;

function swap_num(x: longint): longint;
var     y: longint;
begin
        y:= 0;
        while (x>0) do begin
                y:= y*10 + x mod 10;
                x:= x div 10;
        end;
        swap_num:= y;
end;

function gcd(x,y: longint): longint;
begin
        if (x=0) or (y=0) then begin gcd:= x+y; exit; end;
        if (x>y) then gcd:= gcd(y,x mod y)
        else gcd:= gcd(x,y mod x);
end;

begin
        readln(a,b);
        for i:= a to b do
                if gcd(swap_num(i),i)=1 then inc(cnt);
        writeln(cnt);
end.
