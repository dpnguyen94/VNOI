program numcon;
uses crt;
var     fi,fo: text;
        s: array[1..100] of string;
        a: array[1..100] of integer;
        n: integer;

procedure process;
var     i,j,k: integer;
        st: string;
begin
        //init;
        fillchar(a,sizeof(a),0);

        for i:= 1 to n do begin
                for j:= length(s[i]) downto 1 do begin
                        if (s[i][j] <> '0') then break
                        else inc(a[i]);
                end;
                delete(s[i],j+1,a[i]);
        end;

        //sort;
        for i:= 1 to n-1 do
         for j:= i+1 to n do
          if (s[i] < s[j]) or ((s[i] = s[j]) and (a[i] > a[j])) then begin
                st:= s[i]; s[i]:= s[j]; s[j]:= st;
                k:= a[i]; a[i]:= a[j]; a[j]:= k;
          end;
end;

procedure output;
var     i,j: integer;
begin
        for i:= 1 to n do
         for j:= 1 to a[i] do s[i]:= s[i]+'0';

        for i:= 1 to n do write(fo,s[i]);
        writeln(fo);

end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        n:= 0;
        while not EOF(fi) do begin
                inc(n);
                readln(fi,s[n]);
        end;
        process;
        output;
        //
        close(fi);
        close(fo);

end.
