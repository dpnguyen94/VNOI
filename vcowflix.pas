program vcowflix;
uses crt;
var     a: array[1..16] of longint;
        bd: array[0..5000] of 0..1;
        c,n: integer;

procedure enter;
var     i: integer;
begin
        readln(c,n);
        for i:= 1 to n do readln(a[i]);
end;

procedure calculate;
var     i,j,w: integer;
begin
        fillchar(bd,sizeof(bd),0);
        //
        w:= 0; bd[w]:= 1;
        for i:= 1 to n do begin
                for j:= w downto 0 do begin
                        if (bd[j] = 1) and (j+a[i] <= c) and (bd[j+a[i]] <> 1) then
                                bd[j+a[i]]:= 1;
                end;
                if (w+a[i] <=c) then inc(w,a[i]) else w := c;
        end;
end;

procedure output;
begin
        while (bd[c] <> 1) do dec(c);
        writeln(c);
end;

begin
        enter;
        calculate;
        output;
end.