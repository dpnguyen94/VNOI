program cnmarble;
uses crt;
var     a,c: array[1..500000] of longint;
        s,m,n: longint;
        fi,fo: text;

procedure input;
var     i: longint;
begin
        s:= 0;
        readln(fi,n,m);
        for i:= 1 to n do begin
                read(fi,a[i]);
                inc(s,a[i]);
        end;
end;

procedure output;
var     i,j,box_num: longint;
begin
        box_num:= s div m;

        j:= 0;
        for i:= 1 to n do
         while (a[i] > 0) do begin
                inc(j);
                c[j]:= i;
                dec(a[i]);
         end;
        //
        for i:= 1 to box_num do begin
                j:= i;
                while (j <= s) do begin
                        write(fo,c[j],' ');
                        inc(j,box_num);
                end;
                writeln(fo);
        end;
end;


begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        input;
        output;
        //
        close(fi);
        close(fo);
end.
