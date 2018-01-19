program shhv;
uses crt;
var     fi,fo: text;
        f: array[0..11] of longint;
        a: array[1..12] of integer;
        free: array[1..12] of boolean;
        n: integer;
        p: longint;

procedure input;
begin
        n:= 0;
        while not seekeoln(fi) do begin
                inc(n);
                read(fi,a[n]);
        end;
        readln(fi);
        readln(fi,p);
        if (n = 1) then begin
                writeln(fo,1);
                writeln(fo,1);
                close(fo);
                halt;
        end;
end;

procedure init;
var     i: integer;
begin
        f[0]:= 1;
        for i:= 1 to 11 do f[i]:= f[i-1]*i;
end;

procedure process1;
var     i,j,cnt: integer;
        res1: longint;
begin
        fillchar(free,sizeof(free),true);
        res1:= 0;
        for i:= 1 to n-1 do begin
                cnt:= 0;
                for j:= 1 to a[i]-1 do
                 if free[j] then inc(cnt);
                inc(res1,cnt*f[n-i]);
                free[a[i]]:= false;
        end;
        writeln(fo,res1+1);
end;

procedure process2;
var     i,j: integer;
begin
        fillchar(free,sizeof(free),true);
        inc(a[n-1],1);
        free[a[n-1]]:= false;
        for i:= n-2 downto 1 do begin
                j:= 1;
                while (a[i] > 0) or (not free[j]) do begin
                        if free[j] then dec(a[i]);
                        inc(j);
                end;
                a[i]:= j;
                free[a[i]]:= false;
        end;
        //
        for i:= n-1 downto 1 do write(fo,a[i],' ');
        for i:= 1 to n do if free[i] then write(fo,i);
end;


procedure attempt(i:integer; j: longint);
var     k: integer;
begin
        if (j < 0) then exit;
        if (i = 0) and (j = 0) then begin
                process2;
                close(fo);
                halt;
        end;
        for k:= i downto 0 do begin
                a[i]:= k;
                attempt(i-1,j-a[i]*f[i]);
        end;
end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        input;
        init;
        process1;
        attempt(n-1,p-1);
        //
        close(fi);
        close(fo);
end.
