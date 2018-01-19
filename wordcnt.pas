program wordcnt;
uses crt;
var     s: ansistring;
        c: array[1..1000] of 1..20;
        m: array[1..1000] of integer;
        num_test,t: 1..20;

procedure count;
var     i,j,w,max: integer;
begin
        readln(s);
        s:= ' ' + s + ' ';
        fillchar(c,sizeof(c),0);
        //
        w:= 1;
        for i:= 1 to length(s)-1 do
                if (s[i] = ' ') and (s[i+1] <> ' ') then begin
                        j:= i+1;
                        while (s[j] <> ' ') do begin
                                inc(c[w]);
                                inc(j);
                        end;
                        inc(w);
                end;
        //
        m[1]:= 1;
        for i:= 2 to w-1 do
                if (c[i] <> c[i-1]) then m[i]:= 1
                else m[i]:= m[i-1]+1;
        //
        max:= 0;
        for i:= 1 to w-1 do if (m[i] > max) then max:= m[i];
        writeln(max);
end;

begin
        readln(num_test);
        for t:= 1 to num_test do count;
end.
