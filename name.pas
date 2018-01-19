program name;
uses crt;
var     s: ansistring;
        j: integer;

begin
        clrscr;
        readln(s);

        //process
        j:= 1;
        while (s[j] = ' ') do begin s[j]:= '0'; inc(j); end;
        s[j]:= upcase(s[j]);
        //
        j:= length(s);
        while (s[j] = ' ') do begin s[j]:= '0'; dec(j); end;
        //
        for j:= 1 to length(s)-1 do
                if (s[j] = ' ') and (s[j+1] <> ' ') then s[j+1]:= upcase(s[j+1]);
        for j:= 1 to length(s)-1 do
                if (s[j] = ' ') and (s[j+1] = ' ') then s[j]:= '0';

        for j:= 1 to length(s) do
                if s[j] <> '0' then write(s[j]);
        readln;

end.
