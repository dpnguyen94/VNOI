program binarystring;
uses crt;
var     a: array[1..1000] of 0..1;
        n: integer;

procedure print_res;
var     i: integer;
begin
        for i:= 1 to n do write(a[i]);
        writeln;
end;

procedure attempt(i: integer);
var     t: integer;
begin
        if (i > n) then exit;
        for t:= 0 to 1 do
        begin
                a[i]:= t;
                if i = n then print_res
                else attempt(i+1);
        end;
end;

begin
        clrscr;
        readln(n);
        attempt(1);
        readln;
end.
