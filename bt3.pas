uses math;
var     fi,fo: text;
        s: string[100];
        n: longint;
        f: array[-1..100,-1..100] of int64;

procedure process;
var     i,j: longint;
begin
        n:= length(s);
        fillchar(f,sizeof(f),0);
        f[0,0]:= 1;
        for i:= 1 to n do
        begin
                //if (s[i] = ')') or (s[i] = '?') then f[i,0]:= f[i-1,1];

                for j:= 0 to n do begin
                        if (s[i] = '(') then f[i,j]:= f[i-1,j-1];
                        if (s[i] = ')') then f[i,j]:= f[i-1,j+1];
                        if (s[i] = '?') then f[i,j]:= f[i-1,j+1]+f[i-1,j-1];
                end;
        end;

        writeln(fo,f[n,0]);
end;


begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);

        readln(fi,s);
        process;

        close(fi);
        close(fo);
end.