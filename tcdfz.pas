{
ID: ndchiph1
PROG: fact4
LANG: PASCAL
}
program tcdfz;
uses crt;
var     fi,fo: text;
        n,cnt: longint;
        res: longint;
        f2,f5: array[0..30] of int64;

procedure init;
var     i: integer;
begin
        f2[0]:= 1;
        for i:= 1 to 30 do f2[i]:= f2[i-1]*2;
        //
        f5[0]:= 1;
        for i:= 1 to 13 do f5[i]:= f5[i-1]*5;
end;

procedure count;
var     i,cnt,t,c2,c5: longint;
begin
        c2:= 0; i:= 1;
        while (f2[i] <= n) do begin
                inc(c2,n div f2[i]);
                inc(i);
        end;
        //
        c5:= 0; i:= 1;
        while (f5[i] <= n) do begin
                inc(c5,n div f5[i]);
                inc(i);
        end;
        //
        cnt:= c2-c5;
        //
        if cnt > 4 then begin
                cnt:= cnt mod 4;
                t:= 1;
                for i:= 1 to cnt do t:= t*2;
                res:= (6*t) mod 10;
        end
        else begin
                t:= 1;
                for i:= 1 to cnt do t:= t*2;
                res:= t mod 10;
        end;
end;

procedure process(i: int64; k: integer);
var     j,cnt,t: longint;
begin
        cnt:= 0;
        for j:= i downto 1 do
         if (j mod 10 = k) then begin
                cnt:= j div 10 + 1;
                break;
         end;
        cnt:= cnt mod 4;
        t:= 1;
        for j:= 1 to cnt do t:= t*k;
        res:= (res*t) mod 10;
end;

procedure main;
var     i,j: integer;
        t: int64;
begin
        for i:= 0 to 29 do
         for j:= 0 to 12 do begin
                t:= f2[i]*f5[j];
                if (t <= n) then begin
                        t:= n div t;
                        process(t,3);
                        process(t,7);
                        process(t,9);
                end;
         end;
        //
        writeln(fo,res);
end;

begin
        assign(fi,'fact4.in'); reset(fi);
        assign(fo,'fact4.out'); rewrite(fo);
        //
        readln(fi,n);
        init;
        count;
        main;
        //
        close(fi);
        close(fo);
end.
