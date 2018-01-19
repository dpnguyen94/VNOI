program meo;
uses crt;
const   fi = '';
        fo = '';
var     n,k: integer;
        s: ansistring;
        f: text;

procedure nhap;
begin
        assign(f,fi); reset(f);
        readln(f,n,k);
        readln(f,s);
        close(f);
end;

procedure xuli;
var     i: integer;
        c: char;
begin
        repeat
                for i:= 1 to n-1 do begin
                        if (s[i] <> s[i+1]) then begin
                                c:= char(240-ord(s[i])-ord(s[i+1]));
                                s[i]:= c;
                                s[i+1]:= c;
                        end;
                end;
                if (s[n] <> s[1]) then begin
                        c:= char(240-ord(s[n])-ord(s[1]));
                        s[n]:= c;
                        s[1]:= c;
                end;
                dec(k);
        until k = 0;
        assign(f,fo); rewrite(f);
        writeln(f,s);
        close(f);

end;

begin
        nhap;
        xuli;
end.