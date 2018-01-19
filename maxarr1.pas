program test;
uses crt;
var     fi,fo: text;
        a: array[0..100000] of integer;
        max: array[1..100000] of integer;
        num_test,t,n: longint;

procedure init;
var     i: longint;
begin
        a[0]:= 0; a[1]:= 1;
        max[1]:= 1;
        for i:= 2 to 1000000 do begin
                if (i mod 2 = 0) then a[i]:= a[i div 2]
                else a[i]:= a[i div 2]+a[i div 2+1];
                //
                if (a[i] > max[i-1]) then max[i]:= a[i]
                else max[i]:= max[i-1];
        end;
end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        init;
        readln(fi,num_test);
        for t:= 1 to num_test do begin
                readln(fi,n);
                writeln(fo,max[n]);
        end;
        //
        close(fi);
        close(fo);
end.
