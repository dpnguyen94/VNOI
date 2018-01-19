program mmod29;
uses crt;
var     m: array[0..28] of integer;
        n: longint;
        fi,fo: text;


function powmod29(a: integer; x: longint): integer;
var     tmp: integer;
begin
        if (x = 1) then begin powmod29:= a mod 29; exit; end;
        //
        tmp:= powmod29(a,x div 2);
        tmp:= (tmp*tmp) mod 29;
        if (x mod 2 = 1) then tmp:= (tmp*a) mod 29;
        //
        powmod29:= tmp;
end;

procedure init;
var     i: integer;
begin
        for i:= 1 to 29 do m[21*i mod 29]:= i;
end;

procedure xuli;
var     res,tmp: integer;
begin
        res:= (powmod29(2,2*n+1)-1) mod 29;
        //
        tmp:= (powmod29(3,n+1)-1) mod 29;
        if (tmp mod 2 = 1) then tmp:= (tmp + 29) div 2
        else tmp:= tmp div 2;
        res:= (res*tmp) mod 29;
        //
        tmp:= m[powmod29(167,n+1)-1];
        res:= (res*tmp) mod 29;

        writeln(fo,res);
end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        init;
        repeat
                readln(fi,n);
                if (n = 0) then break;
                xuli;
        until FALSE;

        close(fo);
        close(fi);
end.
