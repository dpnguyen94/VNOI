program thaphnvong;
uses crt;
var     n: byte;
        f: text;

procedure hnv(n,a,b: byte);
begin
        if n = 0 then exit;
        if (b = a mod 3+1) then
        begin;
                hnv(n-1, a, 6-a-b);
                writeln(f, a,'->', b);
                hnv(n-1, 6-a-b, b);
        end
        else
        begin;
                hnv(n-1, a, b);
                writeln(f, a,'->', 6-a-b);
                hnv(n-1, b, a);
                writeln(f, 6-a-b,'->', b);
                hnv(n-1, a, b);
        end;
end;

begin
        clrscr;
        write('n = '); readln(n);
        assign(f,'hnv.out');
        rewrite(f);
        hnv(n,1,2);
        close(f);
end.
