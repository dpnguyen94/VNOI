program countcbg;
uses crt;
var     n: longint;
        fi,fo: text;

procedure process;
var     k,a,i,num: longint;
begin
        num:= 0;
        for k:= 2 to round(sqrt(2*n)) do
                if (2*n mod k = 0) then begin
                        i:= 2*n div k;
                        a:= (i+1-k) div 2;
                        if (a >= 1) and (2*a+k-1 = i) then inc(num);
                end;
        assign(fo,''); rewrite(fo);
        writeln(fo,num);
        close(fo);
end;


begin
        assign(fi,''); reset(fi);
        while not EOF(fi) do begin
                readln(fi,n);
                process;
        end;
        close(fi);
end.