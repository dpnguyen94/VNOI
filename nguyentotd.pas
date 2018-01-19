program nguyento;
uses crt;
var     a,b: longint;
        x,y: array[1..1000] of longint;
        t1,t2: integer;

{function is_prime(n: longint): boolean;
var     i: integer;
begin
        for i:= 2 to round(sqrt(n)) do
        begin
                if (n mod i = 0) then begin is_prime:= false; exit; end;
        end;
        is_prime:= true;
end;}

function prime(i,j: longint):boolean;
var     m,k,z: longint;
begin
        z:= 2; t1:= 1;
        repeat
                k:= i; {giu lai gia tri cua i truoc vong lap while}
                while (i mod z = 0) do
                begin
                        x[t1]:= z;
                        i:= i div z;
                end;
                inc(z);
                if i <> k then inc(t1);
        until i = 1;

        z:= 2; t2:= 1;{lam tuong tu doi voi i}
        repeat
                k:= j; {giu lai gia tri j truoc vong lap while}
                while (j mod z = 0) do
                begin
                        y[t2]:= z;
                        j:= j div z;
                end;
                inc(z);
                if j <> k then inc(t2);
        until j = 1;

        if t1 <> t2 then begin prime:= false; exit; end
        else
        begin
                for m:= 1 to t1-1 do
                if x[m] <> y[m] then begin prime:= false; exit; end;
        end;
        prime:= true;
end;


begin
        clrscr;
        write('a='); readln(a);
        write('b='); readln(b);

        if prime(a,b) then write('YES') else write('NO');
        readln;
end.