program vstep;
uses crt;
const   MAX_N = 100000;
        C = 14062008;
var     fi,fo: text;
        n,k: longint;
        s: array[0..MAX_N] of longint;
        b: array[1..MAX_N] of boolean;

procedure init;
var     i,j: longint;
begin
        fillchar(b,sizeof(b),true);
        readln(fi,n,k);
        for i:= 1 to k do begin
                read(fi,j);
                b[j]:= false;
        end;
end;

procedure calc;
var     i: longint;
begin
        s[0]:= 0; s[1]:= 1;
        for i:= 2 to n do if b[i] then s[i]:= (s[i-1]+s[i-2]) mod C
        else s[i]:= 0;
        //
        writeln(fo,s[n]);
end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        init;
        calc;
        //
        close(fi);
        close(fo);
end.