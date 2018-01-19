program cond1;
uses crt;
const   fi = '';
        fo = '';
var     res: array[2..10] of longint = (3,13,75,541,4683,47293,545835,7087261,102247563);
        n: 2..10;

begin
        repeat
                readln(n);
                if n= -1 then exit;
                writeln(res[n]);
        until FALSE;
end.
