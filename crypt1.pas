{
ID: ndchiph1
PROG: crypt1
LANG: PASCAL
}

uses math;
var     fi,fo: text;
        inset: array[0..9] of boolean;
        n: integer;

procedure input;
var     i,m: longint;
begin
        readln(fi,n);
        fillchar(inset,sizeof(inset),false);
        for i:= 1 to n do begin
                read(fi,m);
                inset[m]:= true;
        end;
end;

function valid(x: longint): boolean;
begin
        while (x > 0) do begin
                if not inset[x mod 10] then exit(false);
                x:= x div 10;
        end;
        exit(true);
end;

procedure process;
var     i,j,i1,j1,cnt,res: longint;
begin
        cnt:= 0;
        for i:= 100 to 999 do begin
                if not valid(i) then continue;

                for j:= 10 to 99 do begin
                        if not valid(j) then continue;
                        if j mod 10 = 0 then continue;

                        //
                        i1:= i * (j mod 10);
                        if i1 >= 1000 then continue;
                        if not valid(i1) then continue;
                        j1:= i * (j div 10);
                        if j1 >= 1000 then continue;
                        if not valid(j1) then continue;
                        //
                        res:= i1 + j1 * 10;
                        if (res < 10000) and valid(res) then inc(cnt);
                end;
        end;

        writeln(fo,cnt);
end;


begin
        assign(fi,'crypt1.in'); reset(fi);
        assign(fo,'crypt1.out'); rewrite(fo);
        //
        input;
        process;
        //
        close(fi);
        close(fo);
end.
