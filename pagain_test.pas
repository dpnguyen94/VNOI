program test01;
uses crt;
const   fo = 'pagain.in';
var     f: text;
        i: integer;
        t: int64;

begin
        assign(f,fo); rewrite(f);
        writeln(f,10000);
        for i:= 1 to 10000 do begin
            t:= (random((1 shl 4)-3)+3) * int64(1 shl 28);
            writeln(f,t);
        end;
        close(f);
end.