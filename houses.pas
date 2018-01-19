uses math;
var     fi,fo: text;
        n,l,cnt,sum: longint;
        a: array[0..20] of longint;
        h: array[1..100] of longint;
        free: array[0..20] of boolean;

procedure input;
var     i: longint;
begin
        readln(fi,l,n);
        sum:= 0;
        for i:= 1 to n do begin
                read(fi,a[i]);
                inc(sum,a[i]);
        end;
end;

procedure print;
var     i: longint;
begin
        inc(cnt);
        if (cnt > 1000) then begin
                close(fo);
                halt;
        end;
        //
        for i:= 1 to l do write(fo,h[i],' ');
        writeln(fo);
end;

procedure attempt(i,r: longint);
var     j,k,t: longint;
begin
        if (i > l) then begin
                print;
                exit;
        end;
        //
        if (i <= l-r) then t:= 0
        else t:= 1;
        //
        for j:= t to n do begin
                 if free[j] then begin
                        for k:= i to i+a[j]-1 do h[k]:= j;
                        if (j <> 0) then begin
                                free[j]:= false;
                                attempt(i+a[j],r-a[j]);
                        end
                        else attempt(i+a[j],r);
                        //
                        free[j]:= true;
                 end;
        end;
end;

procedure process;
var     i,j,rest: longint;
begin
        fillchar(free,sizeof(free),true);
        cnt:= 0;
        a[0]:= 1;
        for i:= 1 to n do begin
                for j:= 1 to a[i] do h[j]:= i;
                rest:= sum-a[i];
                free[i]:= false;
                attempt(a[i]+1,rest);
                free[i]:= true;
        end;
end;


begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);

        input;
        process;

        close(fi);
        close(fo);
end.

