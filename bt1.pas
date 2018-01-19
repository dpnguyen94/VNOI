uses math;
const   MAX_N = 100000;
type    mang = array[1..MAX_N] of longint;
var     fi,fo: text;
        n: longint;
        f: array[1..MAX_N] of longint;
        s: array[-MAX_N..MAX_N] of int64;
        c: array[1..MAX_N] of char;

procedure input;
var     t: longint;
begin
        n:= 0;
        t:= 0;
        fillchar(f,sizeof(f),0);
        while not eof(fi) do begin
                inc(n);
                read(fi,c[n]);
                if (c[n] = 'a') then inc(t)
                else dec(t);

                f[n]:= t;
        end;
end;


procedure process;
var     i: longint;
        res: int64;
begin
        fillchar(s,sizeof(s),0);
        res:= 0;
        for i:= 1 to n do inc(s[f[i]]);

        inc(res,s[0]);
        for i:= -n to n do begin
                inc(res,s[i] * (s[i]-1) div 2);

        end;
        //
        writeln(fo,res);
end;

begin
        assign(fi,'bt1.inp'); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        input;
        process;
        //
        close(fi);
        close(fo);
end.
