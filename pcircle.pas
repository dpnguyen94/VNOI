program pcircle;
uses crt;
var     fi,fo: text;
        p: array[1..40] of boolean;
        vs: array[1..20] of boolean;
        a: array[1..20] of integer;
        n: integer;
        cnt: qword;
        res: array[1..10000,1..20] of integer;

procedure init;
var     i,j: integer;
begin
        fillchar(p,sizeof(p),true);
        //
        p[1]:= false; p[2]:= true;
        for i:= 2 to 40 do
         if p[i] then begin
                j:= i+i;
                while (j <= 40) do begin
                        p[j]:= false;
                        inc(j,i);
                end;
         end;
end;

procedure print_res;
var     i,j: integer;
begin
        writeln(fo,cnt);
        if (cnt > 10000) then cnt:= 10000;
        for i:= 1 to cnt do begin
                for j:= 1 to n+n do write(fo,res[i,j],' ');
                writeln(fo);
        end;
end;

procedure add;
var     i: integer;
begin
        inc(cnt);
        if (cnt <= 10000) then
         for i:= 1 to n+n do res[cnt,i]:= a[i];
end;

procedure attempt(i: integer);
var     j: integer;
begin
        if (i > n+n) then
         if p[a[n+n]+a[1]] then add
         else exit;
        //
        for j:= 2 to n+n do
         if (not vs[j]) and (p[j+a[i-1]]) then begin
                a[i]:= j;
                vs[j]:= true;
                attempt(i+1);
                vs[j]:= false;
         end;
end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        readln(fi,n);
        init;
        a[1]:= 1;
        fillchar(vs,sizeof(vs),false);
        vs[1]:= true;
        cnt:= 0;
        attempt(2);
        print_res;
        //
        close(fi);
        close(fo);
end.
