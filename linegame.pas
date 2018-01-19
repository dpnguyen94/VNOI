program linegame;
uses crt;
const   fi = '';
        fo = '';
        MAX_N = 1000000;
var     a: array[1..MAX_N] of integer;
        s1,s2: array[1..MAX_N] of int64;
        n: longint;
        f: text;

procedure enter;
var     i: longint;
begin
        assign(f,fi); reset(f);
        readln(f,n);
        for i:= 1 to n do read(f,a[i]);
        close(f);
end;

procedure calc;
var     i: longint;
        max1,max2,res: int64;
begin
        //init;
        s1[1]:= a[1]; max1:= s1[1];
        s2[1]:= 0; max2:= 0;
        //process;
        for i:= 2 to n do begin
                s1[i]:= max2 + a[i];
                s2[i]:= max1 - a[i];
                if (s1[i] > max1) then max1:= s1[i];
                if (s2[i] > max2) then max2:= s2[i];
        end;
        //
        if (max1 > max2) then res:= max1
        else res:= max2;

        assign(f,fo); rewrite(f);
        writeln(f,res);
        close(f);
end;

begin
        enter;
        calc;
end.