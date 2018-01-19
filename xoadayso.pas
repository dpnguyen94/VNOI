program xoadayso;
uses crt;
var     n: integer;
        a,b: array[1..30000] of integer;

procedure process;
var     sl,i,m: integer;
begin
        //init
        for i:= 1 to n do begin b[i]:= i; a[i]:= i; end;
        sl:= 0;
        m:= n;
        while (m > 1) do
        begin
                for i:= 1 to n do
                        if (a[i] mod 2 = 1) then begin a[i]:= 0; dec(m); end;
                inc(sl);
                for i:= 1 to n do a[i]:= a[i] div 2;
        end;
        for i:= 1 to n do
                if a[i] <> 0 then writeln(b[i]);
        writeln(sl);
end;


begin
        clrscr;
        readln(n);
        process;
        readln;

end.
