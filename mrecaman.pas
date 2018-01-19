program mrecaman;
uses crt;
var     free: array[0..100000000] of boolean;
        a: array[0..500000] of longint;
        k: longint;
        f: text;

procedure init;
var     i: longint;
begin
        fillchar(free,sizeof(free),false);
        a[0]:= 0;
        for i:= 1 to 500000 do begin
                if (a[i-1] - i > 0) and not (free[a[i-1] - i]) then begin
                        a[i]:= a[i-1]-i;
                        free[a[i]]:= true;
                end
                else begin
                        a[i]:= a[i-1]+i;
                        free[a[i]]:= true;
                end;
        end;
end;

begin
        init;
        //
        repeat
                readln(k);
                if (k = -1) then break
                else writeln(a[k]);
        until FALSE;
end.
