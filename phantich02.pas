program phantich;
uses crt;
var     x,p,num: longint;
begin
        clrscr;
        readln(x);
        p:= 2;
        repeat
                num:= 0;
                while (x mod p = 0) do
                begin
                        inc(num);
                        x:= x div p;
                end;
                if (num > 0) then writeln(p,' ',num);
                inc(p);
        until x = 1;
        readln;
end.
