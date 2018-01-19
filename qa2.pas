program qu2;
uses crt;
var     fi,fo: text;
        n: longint;
        a,fl,fr: array[1..1000] of longint;

procedure input;
var     i: longint;
begin
        readln(fi,n);
        for i:= 1 to n do read(fi,a[i]);
end;


procedure init;
var     i,j: longint;
begin
        for i:= 1 to n do fl[i]:= 1;
        for i:= 2 to n do
         for j:= 1 to i-1 do begin
                if (a[i] >= a[j]) and (fl[j]+1 > fl[i]) then
                 fl[i]:= fl[j]+1;
         end;

        for i:= 1 to n do fr[i]:= 1;
        for i:= n-1 downto 1 do
         for j:= n downto i+1 do
          if (a[i] >= a[j]) and (fr[j]+1 > fr[i]) then
           fr[i]:= fr[j]+1;

end;

function min(x,y: longint): longint;
begin
        if (x > y) then exit(y)
        else exit(x);
end;

procedure process;
var     i,j,max,t: longint;
begin
        max:= 0;
        for i:= 1 to n do begin
                t:= min(fl[i],fr[i]);
                if t > max then max:= t;
        end;
        writeln(fo,max+max-1);
end;


begin
        assign(fi,'qa2.inp'); reset(fi);
        assign(fo,'qa2.out'); rewrite(fo);
        //
        input;
        init;
        process;
        //
        close(fi);
        close(fo);
end.