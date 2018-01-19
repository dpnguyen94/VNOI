program tongchuso;
uses crt;
var     x,y: longint;
        q: word;
        t1,t2: word;

begin
        clrscr;
        write('X='); readln(x);
        write('q='); readln(q);

        t1:= 0; t2:= 0;
        y:= x;

        while (y > 0) do
        begin
                t1:= t1+ y mod 10;
                y:= y div 10;
        end;

        while (x > 0) do
        begin
                t2:= t2+ x mod q;
                x:= x div q;
        end;

        writeln(t1);
        writeln(t2);
        readln;
end.
