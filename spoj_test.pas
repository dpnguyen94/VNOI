program spoj_test;
uses crt;
var     a: -99..99;

begin
        repeat
                readln(a);
                if (a <> 42) then writeln(a)
                else exit;
        until FALSE;
end.