program m3tile;
uses crt;
var     fi,fo: text;
        c: array[0..31] of qword;
        n: integer;

procedure init;
var     i: integer;
        sum: qword;
begin
        c[0]:= 1; c[1]:= 0; c[2]:= 3; c[3]:= 0;
        sum:= c[0] + c[2];
        for i:= 4 to 31 do
         if (i mod 2 = 1) then c[i]:= 0
         else begin
                c[i]:= sum + sum + c[i-2];
                inc(sum,c[i]);
         end;
end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        init;
        repeat
                readln(fi,n);
                if (n = -1) then break
                else writeln(fo,c[n]);
        until FALSE;
        //
        close(fi);
        close(fo);
end.
