program mystery;
uses crt;
const   fo = '';
        c = 20122007;
var     a: qword;
        f: text;

function pow3modc(x: qword): qword;
var     tmp: qword;
begin
        if (x = 1) then exit(3);
        //
        tmp:= pow3modc(x div 2);
        tmp:= (tmp*tmp) mod c;
        if (x mod 2 = 1) then tmp:= (tmp*3) mod c;

        pow3modc:= tmp;
end;

procedure calc;
var     d,t: longint;
        tt,res: qword;
begin
        res:= 1;
        //
        t:= longint(trunc(sqrt(a)));
        if (qword(t*t) = a) then begin
                tt:= pow3modc(t);
                if (tt = 0) then tt:= c-1
                else dec(tt);
                res:= (res*tt) mod c;
                dec(t);
        end;
        //
        for d:= 1 to t do begin
                if (a mod d = 0) then begin
                        tt:= pow3modc(qword(d));
                        if (tt = 0) then tt:= c-1
                        else dec(tt);
                        res:= (res*tt) mod c;
                        //
                        tt:= pow3modc(qword(a div d));
                        if (tt = 0) then tt:= c-1
                        else dec(tt);
                        res:= (res*tt) mod c;
                end;
        end;


        assign(f,fo); rewrite(f);
        writeln(f,res);
        close(f);
end;

begin
        readln(a);
        if (a = 1) then begin writeln(2); exit; end;
        calc;
end.
