program factorial;
uses crt;
var     t,n: longint;
        c: array[0..20] of longint;
        i: integer;

procedure init;
begin
        {mang c luu cac gia tri luy thua cua 5}
        c[0]:= 1;
        for i:= 1 to 13 do
        c[i]:= c[i-1] * 5;
end;

procedure process;
begin
        readln(n);
        t:= 0; i:= 1;
        while(c[i] <= n) do begin
                t:= t+ (n div c[i]);
                inc(i);
        end;
        writeln(t);

end;

begin
        init;
        clrscr;
        process;
        readln;
end.