program qbmarket;
uses crt;
var     fi,fo: text;
        n: integer;
        s: longint;
        c,m: array[1..500] of integer;


procedure input;
var     i: integer;
begin
        readln(fi,s,n);
        for i:= 1 to n do readln(fi,c[i],m[i]);
end;


procedure


begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        input;


        //
        close(fi);
        close(fo);
end.