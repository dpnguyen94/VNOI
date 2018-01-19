program dayso;
uses crt;
var     n: longint;
        i: longint;

function is_prime(n: longint): boolean;
var     i: integer;
begin
        for i:= 2 to round(sqrt(n)) do
        begin
                if (n mod i = 0) then begin is_prime:= false; exit; end;
        end;
        is_prime:= true;
end;


begin
        clrscr;
        readln(n);
        for i:= n downto 1 do
        begin
                if is_prime(i) or (n mod i = 0) then
                write(i,' ');
        end;
        readln;
end.
