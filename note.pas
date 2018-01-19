program note;
uses crt;
var     fi,fo: text;
        f: integer;
        p: longint;

function calc(f1: integer; p1: longint): char;
begin
        if (f1 = 1) then exit('D');
        //
        if (p1 mod 4 = 1) then exit('U')
        else if (p1 mod 4 = 3) then exit('D')
                else calc:= calc(f1-1,p1 div 2);

end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        while TRUE do begin
                readln(fi,f,p);
                if (f = 0) and (p = 0) then exit;
                writeln(calc(f,p));
        end;
        //
        close(fi);
        close(fo);

end.