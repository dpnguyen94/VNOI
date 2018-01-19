program nkjump;
uses crt;
const   MAX_N = 1000;
var     fi,fo: text;
        a: array[1..MAX_N] of longint;
        c: array[1..MAX_N,1..MAX_N] of boolean;
        f: array[1..MAX_N] of integer;
        n: integer;

procedure input;
var     i: integer;
begin
        readln(fi,n);
        for i:= 1 to n do read(fi,a[i]);
end;

procedure qsort(l,r: integer);
var     i,j: integer;
        z,t: longint;
begin
        if l>=r then exit;
        i:= l; j:=r;
        t:= a[(l+r) div 2];
        repeat
                while (a[i] < t) do inc(i);
                while (a[j] > t) do dec(j);

                if i <= j then
                begin
                        if i < j then begin
                                z:= a[i]; a[i]:= a[j]; a[j]:= z;
                        end;
                        inc(i);dec(j);
                end;
        until i>j;

        qsort(l,j);
        qsort(i,r);
end;


procedure init;
var     i,j,t,k: integer;
begin
        fillchar(c,sizeof(c),false);
        for i:= 1 to n-2 do begin
                t:= i+2;
                for j:= i+1 to n-1 do begin
                 for k:= t to n do
                  if (a[i]+a[j] = a[k]) then begin
                        c[i,k]:= true;
                        c[j,k]:= true;
                  end
                  else if (a[i]+a[j] < a[k]) then break;
                 t:= k; //neo
                end;
        end;
end;

procedure process;
var     i,j,max: integer;
begin
        for i:= 1 to n do f[i]:= 1;
        for i:= 2 to n do
         for j:= i-1 downto 1 do
          if (c[j,i]) and (f[j]+1 > f[i]) then f[i]:= f[j]+1;
        //

        max:= 0;
        for i:= 1 to n do
         if (f[i] > max) then max:= f[i];

        writeln(fo,max);
end;


begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        input;
        qsort(1,n);
        init;
        process;
        //
        close(fi);
        close(fo);
end.
