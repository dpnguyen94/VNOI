program kmbus;
uses crt;
var     fi,fo: text;
        c: array[1..100] of byte;
        f: array[0..10000] of longint;
        l,b: integer;

procedure input;
var     i: integer;
begin
        readln(fi,b,l);
        for i:= 1 to b do readln(fi,c[i]);
end;

procedure process;
var     i,j: integer;
begin
        f[0]:= 0;
        for i:= 1 to l do f[i]:= maxlongint;

        for i:= 1 to l do
         for j:= 1 to b do
          if (j <= i) and (f[i] > f[i-j]+c[j]) then f[i]:= f[i-j]+c[j];
         //
        writeln(fo,f[l]);
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