program vwordpow;
uses crt;
const   MAX_N = 1000;
        MAX_M = 100;
var     fi,fo: text;
        cow: array[1..MAX_N] of ansistring;
        s: array[1..MAX_M] of string[30];
        good: array[1..MAX_N] of integer;
        n,m: integer;

procedure input;
var     i: integer;
begin
        readln(fi,n,m);
        for i:= 1 to n do begin
                readln(fi,cow[i]);
                cow[i]:= lowercase(cow[i]);
        end;
        for i:= 1 to m do begin
                readln(fi,s[i]);
                s[i]:= lowercase(s[i]);
        end;
end;

function in_str(x: string[30]; y: ansistring): boolean;
var     i,j,len_x,len_y: integer;
begin
        i:= 1; j:= 1;
        len_x:= length(x);
        len_y:= length(y);
        //
        while (i <= len_x) and (j <= len_y) do
         if (x[i] = y[j]) then begin
                inc(i);
                inc(j);
         end
         else inc(j);
        //
        if (i > len_x) then exit(true)
        else exit(false);
end;

procedure process;
var     i,j: integer;
begin
        fillchar(good,sizeof(good),0);
        for i:= 1 to n do
         for j:= 1 to m do
          if in_str(s[j],cow[i]) then inc(good[i]);

        //output;
        for i:= 1 to n do writeln(fo,good[i]);
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
