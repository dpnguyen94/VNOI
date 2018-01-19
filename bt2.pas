uses math;
var     fi,fo: text;
        f: array[0..100,0..100] of boolean;
        s: string[100];
        n: longint;

procedure process;
var     i,j,t: longint;
begin
        fillchar(f,sizeof(f),false);

        n:= length(s);

        for j:= 1 to n do
        begin
                if (s[j] = ')') and (s[j-1] = '(') then f[j-1,j]:= true;
                //
                if (s[j] = ')') then
                 for i:= j-2 downto 1 do
                 begin
                        if (s[i] = '(') then
                        begin
                                if (f[i+1,j-1]) then
                                begin
                                        f[i,j]:= true; continue;
                                end;

                                for t:= i+1 to j-1 do
                                 if (f[i,t]) and (f[t+1,j]) then
                                 begin
                                        f[i,j]:= true; break;
                                 end;
                        end;
                 end;
        end;
        //
        writeln(fo,f[1,n]);
end;


begin
        assign(fi,'bt2.inp'); reset(fi);
        assign(fo,''); rewrite(fo);

        readln(fi,s);
        process;

        close(fi);
        close(fo);
end.