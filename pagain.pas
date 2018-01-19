program pagain;
uses crt; //,windows;
var
        tp: integer;
        p: array[1..66000] of boolean;
        p1: array[1..7000] of longint;
        p2: array[1..7000] of qword;
        fi,fo: text;
        //time: longint;

function powmod(y:qword; d:qword; x:qword): qword; // y^d mod x
var tmp: qword;
    i:integer;
begin
        tmp:= 1;
        for i:=31 downto 0 do begin
                tmp := (tmp*tmp) mod x;
                if (((d shr i) and 1) = 1) then tmp := (tmp*y) mod x;
        end;
        powmod := tmp;

{
        //
        if (d = 1) then begin powmod := y mod x; exit; end;

        //
        tmp := powmod(y, d div 2, x);
        tmp := (tmp*tmp) mod x;
        if (d mod 2 = 1) then tmp := (tmp*y) mod x;
        powmod := tmp;
}

end;


function miller_rabin(x:qword):boolean;
var y, z ,d: qword;
    s, i, j: integer;
    checked: boolean;
begin
        //
        d:= x-1; s:= 0;
        while (d mod 2 = 0) do begin inc(s); d:= d div 2; end;

        //
        miller_rabin:= false;
        for i:=1 to 20 do begin
                y:= 2 + random(int64(x)-3);
                z:= powmod(y,d,x);
                if (z=1) or (z=x-1) then continue;

                checked:= true;
                for j:=1 to s-1 do begin
                        z := (z*z) mod x;
                        if (z=1) then exit;
                        if (z=x-1) then begin checked:=false; break; end;
                end;
                if (checked) then exit;
        end;
        miller_rabin:= true;
end;


procedure xuli;
var     num_test,t,i: integer;
        n: qword;
        check: boolean;
begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        readln(fi,num_test);

        for t:= 1 to num_test do begin
                //
                readln(fi,n);
                if (n = 3) then begin writeln(2); continue; end;
                dec(n);
                if (n mod 2 = 0) then dec(n);


                //
                while TRUE do begin
                        if (miller_rabin(n)) then break;
                        dec(n,2);
                end;

                //
                writeln(fo, n);
        end;
        //
        close(fo);
        close(fi);
end;

begin
        //time:= gettickcount;
        xuli;
        //writeln('time = ', (gettickcount-time)/1000.0:6:6);
        //readln;
end.
