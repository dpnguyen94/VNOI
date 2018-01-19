program luckynum;
uses crt;
var     m0x,m8x,m6x: array[0..200] of integer;
        fi,fo: text;
        num_test,t,x: integer;

procedure init;
var     i: integer;
begin
        readln(fi,x);

        m8x[0]:= 0; m6x[0]:= 0;
        m0x[1]:= 10 mod x; m8x[1]:= 8 mod x; m6x[1]:= 6 mod x;
        for i:= 2 to 200 do begin
                m0x[i]:= (m0x[i-1]*10) mod x;
                m8x[i]:= (m8x[i-1]*10+8) mod x;
                m6x[i]:= (m6x[i-1]*10+6) mod x;
        end;
end;

procedure calc;
var      check: boolean;
         n,s8,t8,t6,i: integer;
begin
        check:= false;
        for n:= 1 to 200 do begin
                for s8:= 0 to n do begin
                        if (s8 = 0) or (s8 = n) then begin
                                if (s8 = 0) then
                                 if (m6x[n] = 0) then begin
                                        check:= true;
                                        break;
                                 end;
                                if (s8 = n) then
                                 if (m8x[n] = 0) then begin
                                        check:= true;
                                        break;
                                 end;
                        end
                        else if (m8x[s8]*m0x[n-s8] + m6x[n-s8]) mod x = 0 then begin
                                check:= true;
                                break;
                        end;

                end;
                if check then break;
        end;

        //
        if check then begin
                for i:= 1 to s8 do write(fo,8);
                for i:= 1 to n-s8 do write(fo,6);
                writeln(fo);
        end
        else writeln(fo,-1);
end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);

        readln(fi,num_test);
        for t:= 1 to num_test do begin
                init;
                calc;
        end;
        close(fo);
        close(fi);
end.
