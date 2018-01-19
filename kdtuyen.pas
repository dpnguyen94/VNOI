program kdtuyen;
uses crt;
var     f: array[1..1000000] of 0..9;
        x: longint;
        fi,fo: text;

function get_f(n: longint): integer;
var     sum: integer;
begin
        sum:= 0;
        while (n > 0) do begin
                inc(sum,n mod 10);
                n:= n div 10;
        end;
        exit(sum);
end;

procedure process;
var     i,s: longint;
begin
        f[1]:= 1; f[2]:= 2; f[3]:= 6;
        for i:= 4 to x do begin
                s:= f[i-1]*i;
                while (s > 9) do s:= get_f(s);
                f[i]:= s;
        end;
        //
        writeln(fo,f[x]);
end;


begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        readln(fi,x);
        process;
        //
        close(fi);
        close(fo);
end.