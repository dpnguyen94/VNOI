program mdigits2;
uses crt;
var     s,st: ansistring;
        i,n: longint;

begin
        //init;
        for i:= 1 to 100000 do begin
                str(i,st);
                s:= s+st;
        end;
        //
        readln(n);
        str(n,st);
        for i:= 1 to length(s)-length(st)+1 do
                if (st = copy(s,i,length(st))) then begin
                        writeln(i);
                        exit;
                end;
end.