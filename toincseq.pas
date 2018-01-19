uses crt;
const   MAX_N = 100010;
var     fi,fo: text;
        n: longint;
        a,min,max,inf,sup: array[1..MAX_N] of longint;

procedure input;
var     i: longint;
begin
        readln(fi,n);
        for i:= 1 to n do read(fi,a[i]);
end;

procedure process;
var     i,j,k,len,min1: longint;
begin
        i:= 1; j:= 2;
        inf[i]:= 1;

        while (j <= n) do begin
                if (a[j] <= a[inf[i]]) then inc(j)
                else begin
                        sup[i]:= j-1;
                        inc(i);
                        inf[i]:= j;
                end;
        end;
        sup[i]:= n;
        //
        for j:= 1 to i do begin
                max[j]:= a[inf[j]];
                min[j]:= maxlongint;
                for k:= inf[j] to sup[j] do
                 if a[k] < min[j] then min[j]:= a[k];
        end;
        //
        len:= max[i]-min[i];
        min1:= min[i];
        for j:= i-1 downto 1 do begin
                if (max[j] < min1) then begin
                        inc(len,max[j]-min[j]);
                        min1:= min[j];
                end;
                if (min1 >= min[j]) and (min1 <= max[j]) then begin
                        inc(len,min1-min[j]);
                        min1:= min[j];
                end;
        end;
        //
        writeln(fo,len);
end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        input;
        process;
        //
        close(fi);
        close(fo);
end.
