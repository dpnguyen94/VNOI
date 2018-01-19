program vratf;
uses crt;
var     cnt,cow,k: longint;

procedure enter;
begin
        readln(cow,k);
end;

procedure group(n: longint);
begin
        if ((n+k) mod 2 <> 0) or (n<=k) then begin
                inc(cnt);
                exit;
        end;
        group((n-k) div 2);
        group((n-k) div 2 + k);
end;

begin
        enter;
        group(cow);
        writeln(cnt);
end.
