program floyd;
uses crt;
const   MAX_N = 100;
        MAX_C = 1000000;
var     n,m,k,u,v,c,te: integer;
        a,t: array[1..MAX_N,1..MAX_N] of longint;
        fi,fo: text;

procedure enter;
var     i,j: integer;
begin
        readln(fi,n,m,k);
        //
        for i:= 1 to n do
         for j:= 1 to n do
          if (i = j) then a[i,j]:= 0
          else a[i,j]:= MAX_C;
        //
        for i:= 1 to m do begin
                readln(fi,u,v,c);
                a[u,v]:= c;
                a[v,u]:= c;
        end;
end;

procedure floyd;
var     i,u,v: integer;
begin
        for u:= 1 to n do
         for v:= 1 to n do t[u,v]:= v;
        //
        for i:= 1 to n do
         for u:= 1 to n do
          for v:= 1 to n do
           if (a[u,v] > a[u,i]+a[i,v]) then begin
                a[u,v]:= a[u,i]+a[i,v];
                t[u,v]:= t[u,i];
           end;
        //
        for u:= 1 to n do
         for v:= 1 to n do if a[u,v] = MAX_C then a[u,v]:= -1;
end;

procedure trace(s,f: integer);
var     dd: array[1..MAX_N] of integer;
        i,cnt: integer;
begin
        cnt:= 0;
        repeat
                inc(cnt);
                dd[cnt]:= s;
                s:= t[s,f];
        until (s = f);
        //
        write(fo,cnt+1,' ');
        for i:= 1 to cnt do write(fo,dd[i],' ');
        write(fo,f);
        //
        writeln(fo);
end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        enter;
        floyd;
        //
        for te:= 1 to k do begin
                readln(fi,c,u,v);
                if (c = 0) then writeln(fo,a[u,v])
                else if (a[u,v] < 0) then writeln(fo,-1)
                        else trace(u,v);
        end;
        //
        close(fi);
        close(fo);
end.