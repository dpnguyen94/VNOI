program cond;
uses crt;
const   fi = '';
        fo = '';
var     fac: array[1..10] of longint;
        a: array[0..11] of integer;
        res,x: longint;

procedure init;
var     i: integer;
begin
        fac[1]:= 1;
        for i:= 2 to 10 do fac[i]:= fac[i-1]*i;
        a[0]:= -1; a[11]:= -1;
end;

function c(k,n: integer): longint;
begin
        c:= fac[n] div (fac[k]*fac[n-k]);
end;

procedure calc;
var     t,p,i,y,z: longint;
begin
        t:= x; p:= 1;
        for i:= 1 to x-1 do
         if (a[i] = 0) then begin
                y:= 1;
                z:= i-1;
                while (a[z] = 1) do begin
                        inc(y); dec(z);
                end;
                p:= p*c(y,t);
                dec(t,y);
         end;
        inc(res,p);
end;

procedure attempt(i: integer);
var     j: integer;
begin
        if (i > x-1) then begin calc; exit; end;
        //
        for j:= 0 to 1 do begin
                a[i]:= j;
                attempt(i+1);
        end;
end;

begin
        init;
        //
        repeat
                res:= 0;
                //
                readln(x);
                if x = -1 then exit;
                //
                attempt(1);
                //
                writeln(res);
        until FALSE;
end.
